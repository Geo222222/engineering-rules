# Zoo Code Engineering Agent System

This repository is the canonical source for the reusable Zoo Code engineering-role system used across projects.

## Contents

1. [Purpose](#purpose)
2. [Role model](#role-model)
3. [Delegation flow](#delegation-flow)
4. [Model routing](#model-routing)
5. [Project overlays](#project-overlays)
6. [Installation](#installation)
7. [Definition of done](#definition-of-done)

## Purpose

The system separates engineering authority into explicit roles instead of relying on one general-purpose coding agent to plan, implement, test, review, document, and approve its own work.

The canonical project-mode definition is `.roomodes`. Shared engineering behavior lives under `.roo/rules/`.

Zoo Code currently supports project-specific `.roomodes`, custom modes, tool-group restrictions, project rules, task delegation through Orchestrator/Boomerang workflows, and sticky model selection per mode. The repository configuration therefore focuses on role boundaries while leaving provider credentials and model selection outside version control.

## Role model

| Role | Primary responsibility | Writes production code? |
|---|---|---:|
| Engineering Orchestrator | Decompose, delegate, integrate, and enforce completion criteria | No |
| Repository Auditor | Establish repository/Git/system state | No |
| System Architect | Define interfaces, contracts, migrations, and sequencing | No |
| Production Implementer | Implement approved bounded changes | Yes |
| Test Engineer | Independently verify behavior and regressions | Tests only |
| Debugger | Reproduce, isolate, and repair root causes | Yes, narrowly |
| Code Reviewer | Review exact diffs and surrounding contracts | No |
| Integration Engineer | Join verified components and preserve compatibility | Yes |
| Documentation & Lifecycle Steward | Synchronize docs and lifecycle truth | Docs/metadata only |
| Security & Boundary Reviewer | Verify trust, authorization, secrets, destructive actions, and authority | No |
| Release & Qualification Agent | Qualify an exact candidate commit | No |
| Research Agent | Gather current external evidence | No |
| Frontend Specialist | UI/client implementation and verification | Yes |
| Backend & Data Specialist | Services, persistence, migrations, pipelines, and integrations | Yes |
| Domain Governance Specialist | Enforce repository-specific constitutional/business boundaries | No |

The list is intentionally composable rather than exhaustive. Add a new specialist only when a recurring responsibility has a distinct authority boundary, tool requirement, or verification contract.

## Delegation flow

For consequential work, the expected flow is:

```text
Engineering Orchestrator
        |
        +--> Repository Auditor
        |
        +--> Domain Governance Specialist (when applicable)
        |
        +--> System Architect (when architecture changes)
        |
        +--> Production Implementer / Frontend / Backend specialist
        |
        +--> Test Engineer
        |
        +--> Debugger (only when evidence shows a failure)
        |
        +--> Code Reviewer
        |
        +--> Security & Boundary Reviewer (when risk warrants it)
        |
        +--> Integration Engineer (when multiple components meet)
        |
        +--> Documentation & Lifecycle Steward
        |
        `--> Release & Qualification Agent
```

Not every task needs every role. The orchestrator should select the minimum role set that preserves independence where it matters.

### Delegation contract

Every subtask should include:

- goal and bounded scope;
- authoritative inputs;
- files or interfaces the agent may change;
- prohibited changes;
- expected outputs;
- verification requirements;
- completion criteria;
- escalation conditions.

Agents should not be asked to approve their own consequential implementation.

## Model routing

Model assignment is intentionally not committed to the repository because API credentials, prices, provider availability, and model quality change independently of engineering policy.

Recommended routing principle:

- Orchestrator / Architect / Reviewer / difficult Debugger: strongest reasoning model justified by task risk.
- Implementer / Frontend / Backend / Integration: strong coding model with reliable tool use.
- Test / Documentation / Research: cost-efficient model that remains reliable for the assigned contract.
- Release Qualifier / Security Reviewer: favor correctness and conservatism over token cost.

Zoo Code's sticky-model behavior can retain the last model used for each mode. Configure provider profiles locally and never commit API keys.

## Project overlays

Global engineering rules are not enough for systems with domain-specific authority boundaries.

Each active repository should retain its own `AGENTS.md` and/or `docs/engineering/PROJECT_OVERRIDES.md` describing project truth such as:

- component ownership;
- domain invariants;
- data authority;
- irreversible or destructive actions;
- provider boundaries;
- required qualification suites;
- forbidden scope expansion;
- deployment/runtime distinctions.

For capital-management repositories, preserve explicit separation between observation, economic judgment, authorization/governance, evidence, and execution. A tool's capability to perform an action never grants authority to originate or approve the action.

For service/SaaS repositories, preserve tenant/location/user authorization, data lineage, provider contracts, and production-vs-demo separation.

## Installation

### Project-local installation

Copy `.roomodes` and `.roo/rules/` into the target repository. Project-specific instructions take precedence when they explicitly narrow the shared rules.

### Global installation

Zoo Code global modes and rules live outside Git, in the user's Zoo configuration directories. Use the repository's bootstrap script as a controlled starting point rather than committing credentials or machine-specific settings.

On Windows:

```powershell
pwsh ./scripts/install-zoo-code-rules.ps1
```

By default the script installs a reusable copy of the shared rules and mode configuration into the current user's `.roo` directory after creating backups of conflicting files. Review the diff before replacing any existing customized configuration.

### Provider setup

Provider profiles and API keys must be configured locally in Zoo Code. Do not commit secrets. Use separate profiles for inexpensive bulk engineering models and expensive escalation/review models.

## Definition of done

The agent system is operational for a repository when:

- Zoo Code loads the custom modes without schema errors;
- shared rules are visible to the modes;
- provider credentials remain outside Git;
- a non-destructive test task can be delegated from Orchestrator to a specialist and returned successfully;
- implementation and verification can be assigned to different roles;
- the repository's domain-specific boundaries are documented and discoverable;
- an exact commit can be independently qualified without relying on conversational memory.

The canonical source remains this repository. Project repositories may narrow behavior but should not silently fork the shared engineering policy.

---

Parent: [Engineering Rules README](../README.md)
