# Copilot Memory Exercise

Copilot Memory is repository-scoped and built up through interaction; it cannot be
fully prebuilt as a static file. This exercise tells you which conventions to teach
Copilot to remember.

## Memories to establish

1. Business logic belongs in service classes, not route handlers.
2. Database access belongs in repositories; services never import Prisma directly.
3. API errors must use the standard `{ error: { code, message, details } }` shape.
4. Raw API keys are shown once and must never be logged or stored.
5. Every access approval, rejection, and key revocation must create an audit event.
6. Tests should cover both role authorization and domain edge cases.

## Prompts to create the memories

```
Remember that this repository keeps business rules in services and database access in
repositories.
```

```
Remember that every access lifecycle event (request, approve, reject, key generate,
key revoke) must produce an audit log entry.
```

```
Remember that raw API keys are only shown once and must never be logged.
```

```
Remember that AccessHub API errors must use the shape { error: { code, message, details } }.
```

## What to observe

After establishing memories, repeat an earlier task (e.g. "fix this endpoint's error
shape"). Notice the prompt can be shorter because Copilot already holds the convention.
