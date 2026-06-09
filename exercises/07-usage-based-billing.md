# 7. Usage-Based Billing

> Since June 1 2026, Copilot usage is metered in GitHub AI Credits (tokens × model
> price), pooled at the enterprise level. The goal isn't to use Copilot less — it's to
> use it *intentionally*: the smallest model and context that reliably solves the task.

**Track:** Presentation & Demos · **Time:** ⏱10m · **Level:** 🟢 warm-up · discussion

---

## 🎯 Goal

Build cost intuition: see how task framing (narrow vs broad) and model choice change token
usage, and decide how you'd run the *other* exercises cost-consciously.

## 🏆 What you'll achieve

- A felt sense of what's cheap (scoped edits, read-only CLI) vs expensive (whole-repo
  review, long autonomous loops).
- A model/context plan for the remaining exercises and the reasoning behind it.

## 🧰 Tools you can use

- The model picker (lightweight models for simple work; stronger models for architecture,
  security, complex debugging).
- `/chronicle` in Copilot CLI for usage insights.
- Budget/usage dashboards (cost-center and enterprise budgets, user-level hard stops).
- Narrow context habits: scope prompts to the file/area that matters.

## 🔧 The exercise (reflection — no code change)

1. Run the **narrow** task from exercise 2 (*"fix this one endpoint's error shape"*) and
   the **broad** task (*"review the entire backend for issues"*). Notice how much context
   each pulls in.
2. Categorize exercises 1–10: which are cheap, which are expensive, and why?
3. Decide, per task type: when is a lightweight model enough, and when do you escalate?
   (Rule of thumb from the deck: escalate for architecture, security, and complex
   debugging.)
4. If using the CLI, try `/chronicle` to inspect usage.

### 💬 Prompts to use with Copilot

Run these two back to back and compare how much context each pulls in (and, in the CLI,
the credits each reports):

**Narrow & cheap:**
> In `apps/api/src/routes/services.routes.ts`, change only the not-found response in the
> get-service-by-id handler to use the `notFound` helper. Touch nothing else.

**Broad & expensive:**
> Review the entire backend under `apps/api/src` for correctness, security, architecture,
> and test gaps, and propose fixes.

Then, in Copilot CLI: `/chronicle` to inspect usage.

**Definition of done:** the group can justify a model + context choice for each remaining
exercise.

## 💡 Ideas & variations

- Estimate the relative cost of running the Ralph loop (exercise 9) for 2 vs 20
  iterations — what guardrails would you put on autonomous workflows?
- Discuss pooled credits: how does one heavy automated workflow affect the shared team
  pool, and what budget controls mitigate it?

## 🧠 Your turn — brainstorm

How would your team make Copilot usage "cost-aware" without slowing people down?

- Which tasks in your week are over-powered (using a big model for trivial work)?
- Where would a hard budget vs a soft alert be appropriate?
- What signals (top users/models/repos) would you monitor before Sep 1, 2026?

> _Your cost-aware usage rules:_
> -
> -
