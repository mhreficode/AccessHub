# Prompt: Security review

Perform a security review of AccessHub focused on the areas below.

Check:

1. **API key handling** — generation, hashing, storage, masking, display. Are raw keys
   ever stored or returned more than once? (`apps/api/src/utils/crypto.ts`,
   `apps/api/src/services/apiKey.service.ts`)
2. **Logging** — is any secret (raw key, hash, token) written to a log?
3. **Authorization** — is every privileged action enforced in the backend, not just
   hidden in the UI? (`apps/api/src/services/authz.service.ts`)
4. **Audit logs** — do they ever contain secrets? Are all lifecycle events audited?
5. **Markdown rendering** — is service-doc HTML sanitized?
   (`apps/web/src/utils/markdown.ts`)
6. **Data exposure** — do any responses leak `keyHash` or other internal fields?

For each issue: severity, the file/line, the impact, and the smallest safe fix. Suggest
a regression test or a `scripts/security-check.sh` rule where useful.
