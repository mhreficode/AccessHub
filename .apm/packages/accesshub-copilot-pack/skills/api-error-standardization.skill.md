---
name: api-error-standardization
description: Reusable approach to standardizing API error responses.
---

# Skill: API Error Standardization

Reusable across internal developer-platform repositories.

## Target shape

```json
{ "error": { "code": "ERROR_CODE", "message": "Human readable message", "details": {} } }
```

## Steps

1. Find responses that set a non-2xx status with an ad-hoc body (`{ message }`,
   `{ error: "..." }`, or a bare string).
2. Throw a typed application error and let one central error handler serialize it.
3. Use stable UPPER_SNAKE_CASE codes; keep the list documented.
4. Add or update a test asserting `error.code` and the status.
5. Update the API guidelines when adding a new code.
