---
layout: default
title: Search API
description: Machine-readable access to the public Let's Hack It article index.
permalink: /api/search/
---

# Search API

The read-only Search API exposes the public article index used by this site's search interface. It requires no authentication.

## Request

```http
GET /search.json HTTP/1.1
Host: lucasteske.dev
Accept: application/json
```

A successful request returns HTTP 200 with a JSON array. Every array item contains:

| Field | Type | Description |
| --- | --- | --- |
| `title` | string | Article title. |
| `url` | string | Site-relative article URL. |
| `category` | string | Article category, or an empty string when uncategorized. |
| `tags` | string | Comma-separated article tags. |
| `date` | string | Publication date formatted as `Month DD, YYYY`. |
| `excerpt` | string | Plain-text article excerpt, truncated to 50 words. |

The complete machine-readable contract is available in the [OpenAPI description](/openapi.json). Service availability is reported by the [health endpoint](/health-check).
