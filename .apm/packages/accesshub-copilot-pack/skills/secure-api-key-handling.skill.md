---
name: secure-api-key-handling
description: Reusable rules for generating, hashing, masking, storing, and showing API keys.
---

# Skill: Secure API Key Handling

Reusable across internal developer-platform repositories.

## Rules

- Generate keys with a CSPRNG; return `{ raw, prefix, hash }`.
- Store only the prefix and a strong hash (e.g. SHA-256). Never persist the raw key.
- Show the raw key to the user exactly once, at creation.
- Mask keys for display; never return the stored hash.
- Never log raw keys (console, audit, error messages).
- Validate by hashing the input and comparing; reject revoked (and expired) keys.

## Checklist

- [ ] No log statement includes a raw key/token/secret.
- [ ] No response includes the stored hash.
- [ ] Raw key returned only at creation.
- [ ] Revoked keys do not validate.
