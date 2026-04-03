#!/usr/bin/env python3
"""
describe_images.py — Generate AI alt text descriptions for images using OpenRouter vision API.

Iterates over images in the assets/ folder, calls a vision model to generate
accessible alt text, and saves results to _data/image_alt.json.

The JSON is used by _plugins/image_alt_injector.rb to inject alt attributes
into rendered HTML at build time.

Usage:
    python3 describe_images.py [options]

Options:
    --assets-dir DIR     Directory to scan for images (default: assets)
    --output FILE        Output JSON file (default: _data/image_alt.json)
    --model MODEL        OpenRouter model (default: qwen/qwen2.5-vl-7b-instruct)
    --limit N            Process at most N images (useful for testing)
    --force              Re-process images already in the JSON
    --dry-run            Print what would be processed without calling API
    --api-key KEY        OpenRouter API key (default: $OPENROUTER_API_KEY)

Requires OPENROUTER_API_KEY env var or --api-key, and a .env file is auto-loaded.
"""

import argparse
import base64
import io
import json
import os
import sys
import time
from pathlib import Path

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

try:
    import requests
except ImportError:
    sys.exit("Missing dependency: pip install requests")

try:
    from PIL import Image
    HAS_PIL = True
except ImportError:
    HAS_PIL = False
    print("WARNING: Pillow not installed — images won't be resized before sending. "
          "Install with: pip install Pillow")

OPENROUTER_URL = "https://openrouter.ai/api/v1/chat/completions"
DEFAULT_MODEL = "qwen/qwen3-vl-8b-instruct"
DEFAULT_ASSETS_DIR = "assets"
DEFAULT_OUTPUT = "_data/image_alt.json"

# Max dimension for resizing before sending to API (saves tokens)
MAX_IMAGE_DIM = 1024
# Supported extensions
IMAGE_EXTS = {".jpg", ".jpeg", ".png", ".gif", ".webp"}


def load_json(path: Path) -> dict:
    if path.exists():
        try:
            return json.loads(path.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            print(f"WARNING: Could not parse {path}, starting fresh.")
    return {}


def save_json(data: dict, path: Path):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2, sort_keys=True), encoding="utf-8")


def prepare_image_b64(image_path: Path) -> tuple[str, str]:
    """Returns (base64_string, mime_type). Resizes large images."""
    if HAS_PIL:
        with Image.open(image_path) as img:
            # Convert RGBA/P to RGB for JPEG compatibility
            if img.mode in ("RGBA", "P", "LA"):
                img = img.convert("RGB")
            # Resize if too large
            w, h = img.size
            if max(w, h) > MAX_IMAGE_DIM:
                ratio = MAX_IMAGE_DIM / max(w, h)
                img = img.resize((int(w * ratio), int(h * ratio)), Image.LANCZOS)
            buf = io.BytesIO()
            img.save(buf, format="JPEG", quality=85)
            buf.seek(0)
            return base64.b64encode(buf.read()).decode("utf-8"), "image/jpeg"
    else:
        # No PIL — send raw
        data = image_path.read_bytes()
        ext = image_path.suffix.lower()
        mime_map = {".jpg": "image/jpeg", ".jpeg": "image/jpeg",
                    ".png": "image/png", ".gif": "image/gif", ".webp": "image/webp"}
        mime = mime_map.get(ext, "image/jpeg")
        return base64.b64encode(data).decode("utf-8"), mime


def call_vision_api(image_path: Path, model: str, api_key: str) -> str:
    b64, mime = prepare_image_b64(image_path)

    prompt = (
        "Describe this image concisely for use as an HTML alt attribute. "
        "Focus on what is visually shown — be specific and factual. "
        "Keep it under 120 characters. Do not start with 'Image of' or 'A photo of'. "
        "Return only the description text, nothing else."
    )

    payload = {
        "model": model,
        "messages": [
            {
                "role": "user",
                "content": [
                    {
                        "type": "image_url",
                        "image_url": {"url": f"data:{mime};base64,{b64}"}
                    },
                    {
                        "type": "text",
                        "text": prompt
                    }
                ]
            }
        ],
        "temperature": 0.2,
        "max_tokens": 150,
    }

    try:
        resp = requests.post(
            OPENROUTER_URL,
            headers={
                "Authorization": f"Bearer {api_key}",
                "Content-Type": "application/json",
                "HTTP-Referer": "https://lucasteske.dev",
                "X-Title": "Jekyll Image Alt Describer",
            },
            json=payload,
            timeout=60,
        )
        resp.raise_for_status()
    except requests.HTTPError as e:
        raise RuntimeError(f"HTTP error: {e} — {e.response.text}")
    except requests.RequestException as e:
        raise RuntimeError(f"Request failed: {e}")

    return resp.json()["choices"][0]["message"]["content"].strip()


def image_to_key(image_path: Path, assets_root: Path) -> str:
    """Convert absolute image path to a web-root-relative key like /assets/posts/img.jpg"""
    rel = image_path.relative_to(assets_root.parent)
    return "/" + str(rel).replace("\\", "/")


def main():
    parser = argparse.ArgumentParser(description="Generate AI alt text for images using OpenRouter vision API.")
    parser.add_argument("--assets-dir", default=DEFAULT_ASSETS_DIR, help=f"Image directory to scan (default: {DEFAULT_ASSETS_DIR})")
    parser.add_argument("--output", default=DEFAULT_OUTPUT, help=f"Output JSON file (default: {DEFAULT_OUTPUT})")
    parser.add_argument("--model", default=DEFAULT_MODEL, help=f"OpenRouter model (default: {DEFAULT_MODEL})")
    parser.add_argument("--limit", type=int, default=None, help="Max images to process in this run")
    parser.add_argument("--force", action="store_true", help="Re-process already-described images")
    parser.add_argument("--dry-run", action="store_true", help="Show what would be processed without calling API")
    parser.add_argument("--api-key", help="OpenRouter API key (default: $OPENROUTER_API_KEY)")
    args = parser.parse_args()

    api_key = args.api_key or os.environ.get("OPENROUTER_API_KEY")
    if not api_key and not args.dry_run:
        sys.exit("ERROR: Set OPENROUTER_API_KEY or use --api-key")

    assets_dir = Path(args.assets_dir).resolve()
    if not assets_dir.exists():
        sys.exit(f"ERROR: Assets directory not found: {assets_dir}")

    output_path = Path(args.output)
    descriptions = load_json(output_path)

    # Collect all images
    all_images = sorted([
        p for p in assets_dir.rglob("*")
        if p.is_file() and p.suffix.lower() in IMAGE_EXTS
    ])

    # Filter to unprocessed (unless --force)
    to_process = []
    for img in all_images:
        key = image_to_key(img, assets_dir)
        if not args.force and key in descriptions:
            continue
        to_process.append((img, key))

    total = len(to_process)
    skipped = len(all_images) - total
    limited = min(total, args.limit) if args.limit else total

    print(f"Images found   : {len(all_images)}")
    print(f"Already done   : {skipped}")
    print(f"To process     : {total} (processing {limited} this run)")
    print(f"Model          : {args.model}")
    print(f"Output         : {output_path}")
    print()

    if args.dry_run:
        for img, key in to_process[:limited]:
            print(f"  [DRY RUN] {key}")
        return

    processed = 0
    errors = 0
    for img, key in to_process[:limited]:
        print(f"  [{processed + 1}/{limited}] {key} ... ", end="", flush=True)
        try:
            description = call_vision_api(img, args.model, api_key)
            descriptions[key] = description
            print(f"✓  {description[:80]}{'...' if len(description) > 80 else ''}")
            # Save after each image so progress isn't lost on interruption
            save_json(descriptions, output_path)
            processed += 1
        except Exception as e:
            print(f"✗  ERROR: {e}")
            errors += 1
        # Small delay to be polite to the API
        time.sleep(0.5)

    print()
    print(f"Done: {processed} described, {errors} errors, {skipped} skipped.")
    print(f"Saved to: {output_path}")


if __name__ == "__main__":
    main()
