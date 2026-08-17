---
name: Safety and Architecture
description: Architecture preservation, security boundaries, tenancy, data safety, integrations, migrations, and destructive-change rules.
applyTo: "**"
---

# Safety and Architecture Directives

## Architecture Is Discovered, Not Invented

- Inspect the current system before proposing structural changes.
- Identify the authoritative implementation for the behavior being changed.
- Follow existing service boundaries, dependency direction, persistence patterns, event flows, API conventions, and deployment topology.
- Do not create a second service, repository layer, state store, message path, auth path, data model, or configuration path because the existing one is inconvenient.
- Do not replace a working subsystem with a fashionable pattern unless the task explicitly requires migration and the tradeoff is justified.

## Scope Control

- Make the narrowest coherent change that solves the requested problem.
- Separate necessary refactors from opportunistic refactors.
- Do not rename public contracts, routes, database columns, environment variables, files, or exported symbols unless required.
- Preserve backward compatibility where the existing product or API expects it.
- For broad architecture work, establish a migration path rather than performing an unbounded rewrite.

## Dirty Worktree and User Work

- Treat all pre-existing modifications as user-owned.
- Never use destructive Git operations such as reset, checkout/restore of unrelated paths, clean, force push, or history rewriting without explicit authorization.
- Never overwrite a file wholesale when a narrow edit can preserve unrelated changes.
- If the task intersects existing uncommitted work, inspect the diff and adapt to it.

## Authentication and Authorization

- Never bypass authentication or authorization to make a feature work.
- Enforce authorization server-side at the correct trust boundary.
- Preserve role, permission, ownership, organization, salon/location, account, workspace, or tenant checks already used by the system.
- Do not rely on hidden UI elements as authorization.
- Do not trust client-supplied tenant/user/role identifiers without server-side validation.

## Multi-Tenant Safety

For multi-tenant systems:

- Every tenant-scoped read and write must be constrained by the correct tenant boundary.
- Preserve tenant keys through joins, background jobs, caches, events, exports, analytics, and integrations.
- Never broaden a query to “make data show up” without proving tenant isolation remains correct.
- Prefer deny-by-default behavior when tenant identity is missing or ambiguous.
- Add or update tenant-isolation tests when a change affects data access.

## Data and Migration Safety

- Do not drop, truncate, rewrite, or destructively migrate production data without explicit scope and a recovery plan.
- Schema changes must account for existing rows, rollout order, application compatibility, indexes, constraints, and rollback/forward-fix strategy.
- Avoid irreversible migrations when a staged migration is practical.
- Never fabricate production records or silently backfill assumptions as facts.

## Secrets and Sensitive Data

- Never commit credentials, API keys, private keys, access tokens, passwords, session secrets, or production connection strings.
- Do not print or echo secret values in logs, tests, documentation, terminal output, or generated examples.
- Use secret references/placeholders in documentation.
- If a secret is encountered accidentally, do not reproduce it; flag the exposure and recommend rotation when appropriate.

## External Integrations

- Use the project's established integration adapter/client boundary.
- Preserve idempotency, retries, timeout behavior, rate limits, webhook verification, signatures, and provider-specific identifiers.
- Do not silently fall back from a real provider to a mock provider in production code.
- Separate transport/provider failures from domain-state transitions.
- Avoid duplicate external side effects when retrying jobs or requests.

## Financial and High-Impact Operations

For payments, billing, trading, balances, credits, subscriptions, or other financially consequential behavior:

- Use exact numeric semantics defined by the project.
- Preserve idempotency and auditability.
- Do not infer successful settlement from request acceptance alone.
- Do not mutate balances or entitlements without an authoritative event or validated state transition.
- Keep test/sandbox and production modes unmistakably separated.

## Destructive or Irreversible Actions

Before destructive operations, schema deletion, credential rotation, mass updates, force operations, or production-impacting commands:

- establish the exact target and blast radius;
- prefer a reversible or dry-run path;
- require explicit authorization when the action would destroy user work, data, history, or production state.
