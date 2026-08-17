---
name: Workflow and Testing
description: Repository inspection, implementation workflow, test discipline, evidence, and completion reporting.
applyTo: "**"
---

# Workflow and Testing Directives

## 1. Orient Before Editing

Before material code changes:

- identify the repository root and active package/application;
- inspect relevant source, tests, configuration, schemas/migrations, and adjacent implementation;
- identify the existing command(s) for linting, formatting, type checking, unit tests, integration tests, build, and end-to-end tests;
- inspect Git status/diff when shell access exists;
- determine whether the requested behavior already exists partially elsewhere.

Do not start by generating a generic implementation from the task description alone.

## 2. Establish the Change Boundary

- State internally what must change and what must not change.
- Trace the real call/data path end to end when the task spans layers.
- Reuse existing interfaces and extension points where possible.
- If behavior is unclear, inspect callers, tests, migrations, and runtime configuration before deciding.

## 3. Implement Narrowly

- Change only files required by the solution or its tests/docs.
- Preserve unrelated user modifications.
- Do not fix unrelated failures unless they block verification; report them separately.
- Keep generated artifacts, lockfiles, migrations, and snapshots intentional.

## 4. Testing Requirements

- Add or update tests for changed behavior when the repository has a relevant test layer.
- Prefer the smallest relevant test first, then broaden verification.
- For bug fixes, add a regression test when practical.
- For authorization or tenancy changes, test both allowed and denied/cross-tenant behavior.
- For data migrations, test upgrade behavior against representative pre-existing data when tooling permits.
- For external integrations, test adapter behavior and idempotency without making uncontrolled real-world side effects.

## 5. Verification Ladder

Use the repository's actual commands. A typical order is:

1. targeted unit/integration tests for changed behavior;
2. formatter/linter on changed scope;
3. type checking or static analysis;
4. relevant package/application test suite;
5. build/compile/package verification;
6. end-to-end or smoke tests when the change affects a critical user flow.

Do not invent commands if the repository defines them in package scripts, task runners, Makefiles, CI, pyproject configuration, or documentation.

## 6. Never Fake Verification

- Never say tests passed if they were not run.
- Never equate “code looks correct” with runtime verification.
- Never hide a failing test by deleting it, weakening assertions, skipping it, or changing unrelated configuration unless the test itself is proven wrong.
- If verification cannot run, report the exact command attempted and the blocking condition.
- Distinguish failures caused by the change from known/pre-existing failures when evidence supports that distinction.

## 7. Frontend Verification

For UI changes when browser tooling is available:

- verify the affected route/state, not only compilation;
- check loading, empty, success, error, and permission states relevant to the change;
- verify responsive behavior when the existing product supports multiple breakpoints;
- preserve accessibility semantics and keyboard behavior where applicable;
- avoid approving a UI solely from source inspection if it can be rendered.

## 8. Backend/API Verification

- Verify status codes, response contracts, authorization, validation, persistence, and error behavior.
- Confirm database writes and side effects occur exactly once where required.
- Check boundary cases such as missing tenant/user context, nonexistent resources, duplicate requests, and invalid input.

## 9. Completion Report

At completion, report concrete evidence:

- summary of behavior implemented;
- material files changed;
- tests/checks run with pass/fail results;
- known failures or verification gaps;
- migrations/configuration/deployment steps if any;
- meaningful risks or follow-up work.

Avoid vague completion language such as “should work,” “looks good,” or “production ready” without supporting evidence.
