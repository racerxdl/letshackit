#!/usr/bin/env python3
"""
enrich_article.py — Enrich Jekyll article front matter using OpenRouter AI.

Adds/updates: categories (from predefined list), tags (keywords), description (SEO).

Usage:
    python3 enrich_article.py <article_path> [options]

    OPENROUTER_API_KEY must be set as an environment variable (or use --api-key).

Examples:
    python3 enrich_article.py _i18n/en/_posts/2025-09-05-running-code-in-pax-machines.md
    python3 enrich_article.py _i18n/en/_posts/2025-09-05-running-code-in-pax-machines.md --dry-run
    python3 enrich_article.py _i18n/en/_posts/2025-09-05-running-code-in-pax-machines.md --model openai/gpt-4o-mini
"""

import argparse
import json
import os
import re
import sys
from pathlib import Path

try:
    import requests
except ImportError:
    sys.exit("Missing dependency: pip install requests")

try:
    import yaml
except ImportError:
    sys.exit("Missing dependency: pip install pyyaml")

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass  # dotenv optional; fall back to env vars

# ---------------------------------------------------------------------------
# Predefined categories (derived from all articles in the blog)
# ---------------------------------------------------------------------------
PREDEFINED_CATEGORIES = [
    "Arduino",
    "Automation",
    "CTF",
    "Camera",
    "FPGA",
    "Hacking",
    "Hardware",
    "Programming",
    "Hardware Hacking",
    "Home Assistant",
    "LimeSDR",
    "Linux",
    "Payment Machines",
    "Reverse Engineering",
    "Software Defined Radio",
    "Satellite"
]

DEFAULT_MODEL = "z-ai/glm-4.7-flash"
OPENROUTER_URL = "https://openrouter.ai/api/v1/chat/completions"
MAX_CONTENT_CHARS = 8000  # Truncate long articles to keep prompt manageable


# ---------------------------------------------------------------------------
# Front matter helpers
# ---------------------------------------------------------------------------

def parse_front_matter(content: str):
    """Return (dict, body_str) or (None, content) if no front matter."""
    m = re.match(r'^---\r?\n(.*?)\r?\n---\r?\n?(.*)', content, re.DOTALL)
    if not m:
        return None, content
    try:
        fm = yaml.safe_load(m.group(1)) or {}
    except yaml.YAMLError as e:
        sys.exit(f"ERROR: Could not parse front matter YAML: {e}")
    return fm, m.group(2)


def dump_front_matter(fm: dict, body: str) -> str:
    """Reconstruct file content from front matter dict + body."""
    # Preserve key order by dumping explicitly; yaml.dump sorts by default
    new_fm = yaml.dump(fm, allow_unicode=True, default_flow_style=False, sort_keys=False)
    return f"---\n{new_fm}---\n{body}"


# ---------------------------------------------------------------------------
# AI call
# ---------------------------------------------------------------------------

def build_prompt(title: str, body: str) -> str:
    categories_list = "\n".join(f"  - {c}" for c in PREDEFINED_CATEGORIES)
    article_excerpt = (body[:MAX_CONTENT_CHARS] + "\n[...truncated]") if len(body) > MAX_CONTENT_CHARS else body
    return f"""\
You are an SEO and content categorization expert. Analyze the blog article below and return a \
JSON object with exactly these three keys:

1. "categories": An array of 1-3 strings chosen ONLY from this predefined list (use exact spelling):
{categories_list}

2. "tags": An array of 5-12 specific keyword tags relevant to the article \
(not limited to the predefined list — pick precise technical terms).

3. "description": A single SEO meta description string, 120-160 characters, \
suitable for a <meta name="description"> tag.

Return ONLY a valid JSON object — no markdown fences, no explanation. Return in the same language as the article.

Article title: {title}

Article content:
{article_excerpt}
"""


def call_openrouter(prompt: str, model: str, api_key: str) -> str:
    try:
        resp = requests.post(
            OPENROUTER_URL,
            headers={
                "Authorization": f"Bearer {api_key}",
                "Content-Type": "application/json",
                "HTTP-Referer": "https://lucasteske.dev",
                "X-Title": "Jekyll Article Enricher",
            },
            json={
                "model": model,
                "messages": [{"role": "user", "content": prompt}],
                "temperature": 0.3,
            },
            timeout=90,
        )
        resp.raise_for_status()
    except requests.HTTPError as e:
        sys.exit(f"OpenRouter HTTP error: {e}\nResponse: {e.response.text}")
    except requests.RequestException as e:
        sys.exit(f"Request failed: {e}")

    return resp.json()["choices"][0]["message"]["content"]


def parse_ai_response(raw: str) -> dict:
    """Extract and validate JSON from the AI response."""
    # Strip optional markdown code fences
    raw = re.sub(r"^```[a-z]*\n?", "", raw.strip(), flags=re.MULTILINE)
    raw = re.sub(r"```$", "", raw.strip(), flags=re.MULTILINE)

    # Find JSON object
    m = re.search(r"\{.*\}", raw, re.DOTALL)
    if not m:
        sys.exit(f"ERROR: No JSON object found in AI response:\n{raw}")

    try:
        data = json.loads(m.group())
    except json.JSONDecodeError as e:
        sys.exit(f"ERROR: Could not parse JSON from AI response: {e}\n{m.group()}")

    # Validate required keys
    for key in ("categories", "tags", "description"):
        if key not in data:
            sys.exit(f"ERROR: AI response missing key '{key}': {data}")

    # Validate categories are from the predefined list
    valid = set(PREDEFINED_CATEGORIES)
    invalid = [c for c in data["categories"] if c not in valid]
    if invalid:
        print(f"  WARNING: AI returned categories not in predefined list: {invalid}")
        data["categories"] = [c for c in data["categories"] if c in valid]

    return data


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description="Enrich Jekyll article front matter with AI-generated metadata.")
    parser.add_argument("article", help="Path to the Jekyll article (.md)")
    parser.add_argument("--model", default=DEFAULT_MODEL, help=f"OpenRouter model (default: {DEFAULT_MODEL})")
    parser.add_argument("--api-key", help="OpenRouter API key (default: $OPENROUTER_API_KEY)")
    parser.add_argument("--dry-run", action="store_true", help="Print changes without writing to file")
    parser.add_argument("--force", action="store_true", help="Re-enrich even if article is already marked enriched: true")
    args = parser.parse_args()

    api_key = args.api_key or os.environ.get("OPENROUTER_API_KEY")
    if not api_key:
        sys.exit("ERROR: Set OPENROUTER_API_KEY environment variable or use --api-key")

    article_path = Path(args.article)
    if not article_path.exists():
        sys.exit(f"ERROR: File not found: {article_path}")

    content = article_path.read_text(encoding="utf-8")
    fm, body = parse_front_matter(content)
    if fm is None:
        sys.exit(f"ERROR: No front matter found in {article_path}")

    title = fm.get("title", article_path.stem)
    print(f"Article : {article_path}")
    print(f"Title   : {title}")
    print(f"Model   : {args.model}")
    print()

    if fm.get("enriched") and not args.force:
        print("Skipping: already enriched (use --force to re-enrich).")
        return

    prompt = build_prompt(title, body)
    print("Calling OpenRouter...", flush=True)
    raw = call_openrouter(prompt, args.model, api_key)
    data = parse_ai_response(raw)

    print(f"  categories : {data['categories']}")
    print(f"  tags       : {data['tags']}")
    print(f"  description: {data['description']}")
    print()

    # Merge tags: combine existing + AI-generated, deduplicate (case-insensitive), preserve order
    existing_tags = fm.get("tags") or []
    if isinstance(existing_tags, str):
        existing_tags = [t.strip() for t in existing_tags.split(",")]
    seen = {t.lower() for t in existing_tags}
    merged_tags = list(existing_tags)
    for tag in data["tags"]:
        if tag.lower() not in seen:
            merged_tags.append(tag)
            seen.add(tag.lower())
    data["tags"] = merged_tags
    print(f"  merged tags: {merged_tags}")

    # Apply to front matter
    fm["categories"] = data["categories"]
    fm["tags"] = data["tags"]
    fm["description"] = data["description"]
    fm["enriched"] = True

    new_content = dump_front_matter(fm, body)

    if args.dry_run:
        print("[DRY RUN] No file written.")
    else:
        article_path.write_text(new_content, encoding="utf-8")
        print(f"Updated: {article_path}")


if __name__ == "__main__":
    main()
