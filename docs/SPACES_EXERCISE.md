# Copilot Spaces Exercise

A Copilot Space bundles curated context so Copilot can answer grounded questions about a
domain. AccessHub provides ready-to-add documents.

## Flow

1. Create or open a Copilot Space for AccessHub.
2. Add the curated docs:
   - `docs/COPILOT_SPACES_CONTEXT.md`
   - `docs/DOMAIN_RULES.md`
   - `docs/ARCHITECTURE.md`
   - `docs/API_GUIDELINES.md`
   - `docs/SECURITY.md`
   - `docs/PRD.md`
   - `.github/copilot-instructions.md`
3. Ask questions grounded in the Space.
4. Compare answers with and without the Space context.

## Example prompts

```
Using the AccessHub space, explain who is allowed to approve access requests.
```

```
Using the AccessHub space, where should access expiration logic be implemented?
```

```
Using the AccessHub space, what files should be updated when API key lifecycle rules change?
```

## What to observe

With the Space, answers should cite the domain rules and point at the right layers
(services for logic, repositories for data, authz.service for permissions). Without it,
answers tend to be generic.
