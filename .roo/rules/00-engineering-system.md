# Engineering System Rules

These rules apply to every Zoo Code mode in this repository unless a more specific project rule explicitly narrows behavior.

## Source of truth

The repository is the source of truth. Inspect executable code, tests, migrations, configuration, CI, and authoritative project documentation before changing behavior.

Read `AGENTS.md` first when present. Also inspect `docs/engineering/PRODUCT.md`, `docs/engineering/ARCHITECTURE.md`, `docs/engineering/TESTING.md`, and `docs/engineering/PROJECT_OVERRIDES.md` when they exist.

If documentation conflicts with executable behavior, report the conflict instead of silently choosing one.

## Git discipline

Before material work, establish the repository, branch, current HEAD, and worktree state when tooling permits.

Treat all pre-existing uncommitted changes as user-owned work. Never discard, reset, clean, overwrite, or reformat unrelated changes.

For nontrivial changes, prefer an isolated branch or worktree. Fetch before integrating when remote access is available. Review the final diff before qualification.

Never claim that a local state, remote branch, canonical main, deployed artifact, and running runtime are equivalent. Name the exact lifecycle state being discussed.

## Change discipline

Prefer the smallest coherent production-grade change.

Reuse existing abstractions, schemas, services, utilities, conventions, and dependencies before creating new ones. Do not create a parallel implementation because the existing one was not inspected deeply enough.

Do not weaken authentication, authorization, tenant isolation, validation, typing, tests, data-integrity controls, security boundaries, auditability, or error handling to make a task pass.

Do not add fake data, mocks, bypasses, hidden fallbacks, or demo-only behavior to production paths unless explicitly required and clearly isolated.

## Evidence and verification

Separate claims into observed fact, inference, hypothesis, and unresolved unknown when material.

Run relevant executable verification whenever available. Record exact commands and outcomes. A passing unrelated suite is not evidence for the changed contract.

Independent review and qualification should inspect the actual diff or exact commit, not rely solely on another agent's narrative.

A task is not complete when code is merely written. It is complete only when the declared acceptance criteria are satisfied, relevant verification has passed or a precise blocker is documented, documentation/lifecycle state is synchronized when needed, and residual risks are explicit.

## Delegation

The orchestrator should delegate by responsibility rather than duplicate the same broad task across multiple agents.

Each delegated task must state:

- scope and goal;
- authoritative inputs;
- files or boundaries the agent may change;
- prohibited changes;
- expected outputs;
- required verification;
- completion criteria;
- escalation conditions.

Parallelize only when write surfaces and authority domains do not conflict. Otherwise sequence work.

Implementation, testing, review, security review, and release qualification should remain independently accountable for consequential changes.

## Documentation quality

Documentation must describe the actual system and provide a coherent reader journey. Use clear hierarchy, navigation, canonical links, prerequisites, commands, ownership, lifecycle state, and Definition of Done where useful.

Do not leave a future human or agent dependent on undocumented conversational context.
