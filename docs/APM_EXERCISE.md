# APM Exercise (Agent Package Manager)

APM-style packaging lets teams share Copilot assets — instructions, prompts, skills,
and agents — across repositories.

## Files

- `apm.yml` — the project manifest; declares a dependency on a local package.
- `.apm/packages/accesshub-copilot-pack/` — an example shareable package containing:
  - `instructions/` — API style and security instructions
  - `prompts/` — a service-review prompt and a test-generation prompt
  - `skills/` — secure API key handling and API error standardization
  - `agents/` — a security reviewer agent

## Flow

1. Show `apm.yml` and the `.apm/packages/accesshub-copilot-pack` layout.
2. Explain that a team could publish this pack and consume it from many repos.
3. Add a reusable asset to the pack.
4. Optionally copy an asset into `.github/skills` to "install" it locally.

## Instructor task

```
Create a reusable skill called access-expiration-review.skill.md. The skill should tell
Copilot how to review access-expiration implementations for correctness, security,
auditability, and tests.
```

Place it under `.apm/packages/accesshub-copilot-pack/skills/`, then copy it into
`.github/skills/` to use it in this repo.

## Discussion points

- What belongs in a shared pack vs a single repo.
- Versioning shared agent assets and keeping them in sync.
