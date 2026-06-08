# .apm — Agent Package Manager assets

This directory demonstrates how a team can **package and share** Copilot setup across
repositories: instructions, prompts, skills, and agents bundled into a versioned
package.

## Layout

```
.apm/
  packages/
    accesshub-copilot-pack/
      apm.yml                 package manifest
      instructions/           api-style, security
      prompts/                service-review, test-generation
      skills/                 secure-api-key-handling, api-error-standardization
      agents/                 security-reviewer
```

The root `apm.yml` declares a dependency on this local package.

## Using it in the workshop

- Show that the same asset (e.g. a skill) can live in a shared pack and be consumed by
  many repos, rather than copy-pasted.
- "Install" an asset by copying it from the pack into `.github/skills` (or `prompts`,
  `agents`) for use in this repository.

See `docs/APM_EXERCISE.md`.
