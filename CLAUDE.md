# Let's Hack It — Jekyll Blog

Blog by Lucas Teske (lucasteske.dev). Jekyll-based, multilingual (EN/PT-BR), deployed via GitHub Actions to gh-pages.

## Article Structure

Articles live under `_i18n/<lang>/_posts/`:

- **English**: `_i18n/en/_posts/`
- **Portuguese (BR)**: `_i18n/pt/_posts/`

Both files must share the **same filename** (including the English slug) so Jekyll links them as translations.

### File Naming

```
YYYY-MM-DD-url-slug.md
```

The date in the filename determines the URL (`/:year/:month/:slug/`). It should match the `date` field in frontmatter.

### Frontmatter

```yaml
---
title: Article Title
date: YYYY-MM-DD HH:MM:SS-03:00    # America/Sao_Paulo timezone
author: Mister Maluco                 # or Lucas Teske
layout: post
image: /assets/path/to/image.jpeg    # optional, featured image
categories:
- Hardware Hacking
- Reverse Engineering
tags:
- Tag1
- Tag2
description: Brief SEO description.
enriched: true                        # flip to true after enrichment
---
```

- `enriched: false` while drafting; set to `true` after running the enrichment pipeline (adds tags, improves description).
- `image` is optional — if omitted, the site default image is used.
- `categories` and `tags` are free-form; try to reuse existing ones for consistency.
- `translated-by: Name` — optional, for translated articles. Displays "and translated by <name>" after the author. When translating an existing article, **keep the original `author`** and add `translated-by: Mister Maluco` to the translated version.
- `translated-by: Name` — optional, for translated articles. Displays "and translated by <name>" next to the author.

### Commit Convention

Commits for AI-authored content use the `MisterMal` identity:

```
Author: MisterMal <teskeslab@lucasteske.dev>
Co-Authored-By: Lucas Teske <lucas@teske.com.br>
```

Use `--author="MisterMal <teskeslab@lucasteske.dev>"` and append `Co-Authored-By` in the message body. Sign with the default GPG key.

### Article Content

- Written in Markdown (kramdown). Supports standard Markdown tables, code blocks, etc.
- **Mermaid diagrams**: Supported via mermaid.js (loaded from CDN in `_includes/footer.html`). Use ` ```mermaid ` code blocks — they render client-side with the dark theme.
- **Code blocks**: Use triple backticks with language tag (e.g. ` ```c `, ` ```python `).
- **Images**: Place in `/assets/<Article Title>/`. Reference with `/assets/<Article Title>/filename.ext`.

## Before Committing a New Article

Run these two scripts before the final commit (requires `OPENROUTER_API_KEY` env var):

1. **Enrich article metadata** — generates/updates categories, tags, and SEO description using AI:
   ```bash
   python3 enrich_article.py _i18n/en/_posts/YYYY-MM-DD-slug.md
   python3 enrich_article.py _i18n/pt/_posts/YYYY-MM-DD-slug.md
   ```
   This sets `enriched: true` in the frontmatter. Use `--force` to re-enrich, `--dry-run` to preview.

2. **Generate image alt text** — describes images in `assets/` using a vision model, saves to `_data/image_alt.json` (injected at build time by `_plugins/image_alt_injector.rb`):
   ```bash
   python3 describe_images.py
   ```
   Skips already-described images. Use `--force` to re-process, `--limit N` for testing.

## Build & Deploy

- **Workflow**: `.github/workflows/pages.yml`
- **Trigger**: Push to `master`
- **Process**: Jekyll builds `_site` → copies to gh-pages branch → pushes
- **Important**: The workflow uses `git add -A` (not `git commit -a`) to ensure new directories are included.
- **Local build**: `JEKYLL_ENV=production bundle exec jekyll build` (or `serve` for dev)

## Key Files

| Path | Purpose |
|------|---------|
| `_config.yml` | Jekyll config (plugins, excludes, languages) |
| `_layouts/post.html` | Article layout |
| `_layouts/default.html` | Base layout (matrix background, navigation) |
| `_includes/head.html` | HTML head (SEO, Open Graph, analytics) |
| `_includes/footer.html` | Footer scripts (search, anchors, mermaid.js) |
| `_i18n/en.yml` / `_i18n/pt.yml` | Translation strings |
| `_i18n/en/_posts/` | English articles |
| `_i18n/pt/_posts/` | Portuguese articles |
| `assets/` | Static assets (images, CSS, JS) |
| `.github/workflows/pages.yml` | CI/CD workflow |

## Languages

Managed by `jekyll-multiple-languages-plugin`. PT-BR content goes under `/pt/` URL prefix. Translation files are `_i18n/en.yml` and `_i18n/pt.yml`.
