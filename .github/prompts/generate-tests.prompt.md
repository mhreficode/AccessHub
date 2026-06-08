# Prompt: Generate missing tests

Add the tests that are missing for a given area of AccessHub.

Please:

1. Inspect the implementation under test and the existing tests in
   `apps/api/src/tests` (or `apps/web/src/tests`).
2. Identify the missing cases — especially authorization edge cases, error paths, and
   domain rules (e.g. a revoked key must not validate; rejecting access must audit).
3. Add tests **before** changing production code, so a real gap fails first.
4. Keep test names readable and behavior-focused.
5. Avoid over-mocking; prefer the existing Supertest + fixture approach
   (`src/tests/helpers.ts`) on the backend.

Run the relevant suite and report pass/fail with the command you used.
