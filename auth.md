---
layout: default
title: auth.md
description: Authentication and agent registration status for Let's Hack It.
permalink: /auth
---

# auth.md

Let's Hack It is a public website with read-only discovery resources. Automated agents may access the public site and its documented public APIs anonymously.

## Registration and provisioning

Agent registration and account provisioning are not supported. There is no registration endpoint, authorization server, OAuth flow, token issuer, or credential provisioning process.

Do not probe or send requests to `/agent/auth`; that endpoint does not exist.

## Supported access method

- Anonymous HTTPS `GET` and `HEAD` requests
- No OAuth scopes
- No API keys, bearer tokens, identity assertions, cookies, or other credentials

## Credential use

Do not send credentials or an `Authorization` header. Public resources return the same representation without authentication.

Machine-readable API discovery is available through the [API catalog](/.well-known/api-catalog), and the public search API contract is available in its [OpenAPI description](/openapi.json).
