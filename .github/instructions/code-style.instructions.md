---
name: Production Code Style
description: Production-grade code quality, consistency, typing, error handling, and implementation conventions.
applyTo: "**"
---

# Code Style Directives

## Existing Style Wins

- Infer style from the repository before writing code.
- Follow existing formatter, linter, import, naming, module, and file-layout conventions.
- Do not introduce a new formatter, linter, type checker, framework, state library, ORM, HTTP client, test library, or utility dependency merely because it is familiar.
- Do not perform unrelated formatting or mass cleanup while implementing a scoped change.

## Implementation Quality

- Write production code, not illustrative snippets, placeholders, pseudo-implementations, or tutorial scaffolding.
- Prefer explicit, readable control flow over clever compression.
- Keep functions and modules cohesive. Split only when there is a real responsibility boundary.
- Reuse existing domain objects and contracts rather than duplicating shapes in new layers.
- Avoid speculative abstractions. Introduce an abstraction when the current design demonstrably needs one.
- Remove dead branches introduced by the change; do not leave commented-out alternatives.
- Do not leave `TODO`, `FIXME`, stub returns, hard-coded sample values, or temporary bypasses unless the task explicitly calls for tracked follow-up work.

## Types and Contracts

- Preserve and strengthen existing type guarantees.
- Do not use `any`, untyped dictionaries, broad casts, `# type: ignore`, `@ts-ignore`, or equivalent suppressions to hide a design problem unless the repository already requires it and the reason is documented.
- Keep API/request/response/domain/database contracts synchronized across layers.
- Validate external and user-controlled data at trust boundaries.
- Treat nullability, optional fields, enums, IDs, timestamps, money, and status values as domain contracts, not incidental strings.

## Error Handling

- Use the repository's established error model.
- Preserve actionable context when wrapping or translating errors.
- Never swallow exceptions silently.
- Never convert a failure into an apparently successful response just to keep a flow moving.
- Distinguish expected domain failures from infrastructure/programming failures when the architecture supports that distinction.
- Do not leak secrets, tokens, credentials, internal stack traces, or sensitive records to client-facing responses or logs.

## Configuration

- Use the existing configuration system and environment-variable conventions.
- Never hard-code environment-specific URLs, credentials, tenant IDs, user IDs, API keys, phone numbers, or production identifiers.
- Add configuration defaults only when a safe and intentional default exists.
- Fail clearly when required production configuration is missing; do not silently switch to mock or insecure behavior.

## Python

When working in Python:

- Follow the project's Python version and packaging configuration.
- Preserve typing conventions and use type hints for new public interfaces when the project is typed.
- Prefer existing Pydantic/dataclass/domain-model patterns rather than introducing parallel representations.
- Preserve async boundaries; do not casually mix blocking I/O into async request/worker paths.
- Use parameterized database operations through the project's existing data-access layer.

## TypeScript / JavaScript

When working in TypeScript or JavaScript:

- Preserve the project's module system, compiler settings, and strictness.
- Do not weaken `tsconfig`, ESLint, or build settings to suppress an implementation error.
- Prefer typed domain/API contracts already present in the codebase.
- Preserve React/server/client boundaries and existing state-management patterns.
- Avoid unnecessary `useEffect`, duplicated derived state, and ad-hoc global state when existing patterns solve the problem.

## SQL and Persistence

- Use migrations for schema changes when the project uses migrations.
- Never edit historical migrations that may already have run unless the project explicitly permits it.
- Parameterize values. Do not construct SQL from raw user-controlled strings.
- Preserve constraints, foreign keys, indexes, audit fields, soft-delete semantics, and tenant keys.
- Treat money and precise numeric values with the project's established decimal/integer strategy; do not introduce floating-point financial arithmetic casually.
