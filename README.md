# Engineering Rules — The Apprenticeship

This repository is not a style guide and it is not a collection of programming tips.

It is an apprenticeship in how to think, work, and prove your work as an engineer.

The rules in this repository are written for both human engineers and coding agents. The apprenticeship is written for the human being who must understand *why those rules exist*.

---

## The Philosophy

> **A software engineer is someone who can take an idea and make it a reality.**
>
> — DJ Martin

The apprenticeship begins at the beginning and teaches toward the end.

At the beginning, a student may only know how to write a script, copy a command, call an API, automate a repetitive task, or make a program print `Hello, World!`.

That is acceptable.

A script is already evidence of an important idea: instructions can change the behavior of a machine.

But the script is not the destination.

The end is understanding how instructions, programs, data, machines, people, constraints, and environments work together to produce a reliable outcome for the person or organization the system serves.

That is engineering.

Code is not confined to a text editor. Code is expressed through traffic systems, payment terminals, aircraft, hospital equipment, warehouse scanners, vehicles, phones, manufacturing lines, websites, networks, scheduling systems, and nearly every modern machine that responds to rules.

An engineer develops the habit of asking:

- What is this system supposed to accomplish?
- Who is it for?
- What makes it work?
- What are its parts?
- How do those parts communicate?
- What assumptions does it depend on?
- What happens when one part fails?
- What must never be allowed to happen?
- How do I know my change actually worked?
- Can another engineer understand what I did and why?

The purpose of this repository is to train that mind.

---

# The Beginning and the End

Every apprentice should understand the full journey before beginning it.

```text
BEGINNING

write a script
    ↓
understand the script
    ↓
read someone else's code
    ↓
trace a program
    ↓
understand interfaces and data
    ↓
understand a repository
    ↓
understand a system
    ↓
change the system safely
    ↓
verify the change with evidence
    ↓
operate within real constraints
    ↓
turn an idea into a dependable reality

END
```

The lessons in this repository follow that order.

Do not race through them.

The objective is not to finish the README. The objective is to develop engineering judgment.

---

# How This Apprenticeship Works

Each lesson has five parts:

1. **Principle** — the engineering idea being learned.
2. **Study** — the repository material that teaches the rule.
3. **Practice** — work the apprentice must perform.
4. **Evidence** — what must be produced or demonstrated.
5. **Gate** — the standard that must be met before moving forward.

An apprentice should keep an engineering notebook throughout the course. Markdown in a personal repository is sufficient.

For every exercise, record:

- the problem;
- what you inspected;
- what you believed before inspection;
- what the evidence showed;
- the change you made;
- how you verified it;
- what could still be wrong;
- what you would investigate next.

That notebook is not busywork. It is a record of engineering judgment developing over time.

---

# Stage 0 — Enter the Workshop

## Principle

Before an engineer changes a system, the engineer must know what system they are standing inside.

A repository is not merely a folder containing code. It is a record of decisions, boundaries, dependencies, contracts, tests, tools, and operating assumptions.

## Study

Read:

- `README.md`
- `AGENTS.md`
- `.github/copilot-instructions.md`
- the names of every top-level directory and file in this repository

Do not attempt to memorize the rules yet.

Your first job is orientation.

## Practice

Without modifying anything, answer:

1. What problem does this repository solve?
2. Who is expected to use it?
3. What are the major rule layers?
4. Which files contain general engineering rules?
5. Which files are intended to contain facts about a specific project?
6. What is the difference between a reusable rule and a project fact?

## Evidence

Produce a one-page repository map.

## Gate

You may continue when you can explain the repository without reading its description word-for-word.

---

# Stage 1 — The Script Kitty

## Principle

You are allowed to begin by making things happen.

A small script is one of the cleanest ways to learn the relationship between intent, instruction, input, state, output, and failure.

The mistake is not beginning with scripts.

The mistake is remaining dependent on scripts you do not understand.

## Practice

Create three small programs in a language you know or are learning:

1. a program that receives input and transforms it;
2. a program that reads or writes a file;
3. a program that calls another program, service, or local interface.

For each program, explain every line.

Then answer:

- What enters the program?
- What leaves it?
- What state changes?
- What can fail?
- What assumptions did you make?
- What would happen if the input were wrong?

## Evidence

You should be able to redraw each script as:

```text
INPUT → PROCESS → OUTPUT
             ↓
          FAILURE
```

## Gate

You are finished with this stage when you no longer treat code as magic.

You should be able to explain *why* the machine produced the result you observed.

---

# Stage 2 — Read Before You Write

## Principle

A beginner sees a task and starts writing.

An engineer sees a task and starts investigating.

In a real system, the existing implementation is evidence. The repository is the source of truth.

Do not invent an architecture because you have not inspected the one already present.

## Study

Read `AGENTS.md`, especially:

- **Required Context**
- **Operating Rules**
- **Completion Standard**

Then read:

- `.github/instructions/workflow-testing.instructions.md`
  - **Orient Before Editing**
  - **Establish the Change Boundary**

## Practice

Choose an unfamiliar repository.

Do not make a change.

Locate:

- application entry points;
- package boundaries;
- configuration;
- environment variables;
- database or persistence code;
- authentication and authorization;
- tests;
- build commands;
- linting and type-checking commands;
- CI configuration;
- deployment-related files.

Then choose one feature and trace where it begins and where it ends.

## Evidence

Produce a short **orientation report** containing only facts you can support from the repository.

Mark anything uncertain as uncertain.

## Gate

You may continue when you can distinguish:

- what you know;
- what you inferred;
- what you assumed;
- what you have not established.

That distinction is fundamental to engineering.

---

# Stage 3 — Trace the System

## Principle

Software is not a collection of files. It is a flow of responsibility.

The engineer must learn to follow behavior across boundaries.

A button can become an HTTP request. The request can become a service call. The service can query a database. The result can pass through authorization, serialization, networking, state management, and rendering before a human sees it.

The filename is not the system.

The path is the system.

## Study

Read:

- `docs/engineering/ARCHITECTURE.md`
- `docs/engineering/PRODUCT.md`
- the architecture portions of `AGENTS.md`

## Practice

Choose one real user action from an existing application.

Trace it end to end.

For example:

```text
Human intent
→ user interface
→ client state
→ request
→ route/controller
→ authorization
→ service/domain logic
→ persistence/integration
→ result
→ response
→ rendered outcome
```

Not every system has every layer. Discover the real path instead of forcing this diagram onto the repository.

## Evidence

Draw the actual path and identify:

- entry point;
- trust boundaries;
- state transitions;
- external dependencies;
- authoritative source of data;
- possible failure points;
- final user-visible outcome.

## Gate

You may continue when you can answer this question:

> If this feature breaks, where would I investigate first, and what evidence would I need?

---

# Stage 4 — Contracts, Data, and Boundaries

## Principle

Systems work because parts agree on meaning.

A function signature is a contract.
An API schema is a contract.
A database constraint is a contract.
An event is a contract.
A permission boundary is a contract.
A unit of money is a contract.
A timestamp is a contract.

Many serious software failures occur because two parts of a system disagree about what a value means.

## Study

Read `.github/instructions/code-style.instructions.md`, especially:

- **Types and Contracts**
- **Error Handling**
- **Configuration**
- **SQL and Persistence**

## Practice

Choose one domain object in a real project.

Examples:

- User
- Appointment
- Payment
- Order
- Message
- Invoice
- Device

Trace every representation of that object that you can find:

```text
UI representation
API request
API response
domain model
database model
event/integration representation
```

Document where the representations intentionally differ and where they must remain synchronized.

## Evidence

Produce a contract map.

Identify at least one invariant: a fact that must remain true for the system to remain valid.

## Gate

You may continue when you stop seeing IDs, timestamps, status values, money, nullability, and enums as "just fields."

They carry domain meaning.

---

# Stage 5 — Production Code Is Contextual

## Principle

There is no universal "best" implementation independent of the system around it.

A technically clever solution can still be the wrong engineering decision if it violates the repository's established patterns, introduces unnecessary dependencies, duplicates an existing abstraction, weakens typing, or expands the change beyond the requirement.

## Study

Read all of:

- `.github/instructions/code-style.instructions.md`

Pay particular attention to:

- **Existing Style Wins**
- **Implementation Quality**

## Practice

Find a small function or feature you believe could be improved.

Before changing it, identify:

- local naming conventions;
- error conventions;
- type conventions;
- module boundaries;
- existing utilities;
- test conventions;
- dependency choices.

Implement the smallest coherent improvement without replacing the surrounding system with your preferred style.

## Evidence

Show the before and after diff and defend every changed line.

## Gate

You may continue when your explanation includes more than "this code is cleaner."

You must be able to explain why the change belongs in *this system*.

---

# Stage 6 — Architecture and Safety

## Principle

Once other people depend on a system, engineering becomes stewardship.

A change can compile and still be dangerous.

It can expose another tenant's data.
It can bypass authorization.
It can duplicate a payment.
It can destroy a migration path.
It can erase user work.
It can leak credentials.
It can corrupt historical records.

Engineering requires understanding blast radius before action.

## Study

Read all of:

- `.github/instructions/safety-architecture.instructions.md`

Study these domains carefully:

- architecture discovery;
- scope control;
- dirty worktrees and user work;
- authentication and authorization;
- multi-tenant safety;
- migrations;
- secrets;
- external integrations;
- financial operations;
- destructive actions.

## Practice

Take a hypothetical request:

> "Make this data show up for the user."

List at least five unsafe ways a programmer could satisfy that sentence.

Then design a safe investigation sequence that establishes:

- who the user is;
- what they are authorized to access;
- which tenant/account/location owns the data;
- where the data originates;
- whether the query is wrong or the data is absent;
- what change has the smallest blast radius.

## Evidence

Produce a **change-risk assessment** before writing code.

## Gate

You may continue when you understand that "it works" and "it is safe" are different claims.

Both require evidence.

---

# Stage 7 — Testing Is Evidence

## Principle

Engineering claims must be supported by evidence.

"It should work" is not evidence.

"The code looks right" is not evidence.

"The model said it passed" is not evidence.

A test result is evidence only if the correct test was actually executed against the relevant behavior.

## Study

Read:

- `.github/instructions/workflow-testing.instructions.md`
- `docs/engineering/TESTING.md`

Focus on:

- **Testing Requirements**
- **Verification Ladder**
- **Never Fake Verification**
- frontend verification;
- backend/API verification;
- completion reporting.

## Practice

Introduce a controlled bug into a disposable practice project.

Then:

1. reproduce the failure;
2. write or identify a test that catches it;
3. repair the implementation;
4. run the smallest relevant test;
5. broaden verification;
6. record the actual commands and outcomes.

Restore the repository when finished.

## Evidence

Produce a completion report containing:

- failure reproduced;
- root cause;
- changed files;
- targeted verification;
- broader verification;
- remaining uncertainty.

## Gate

You may continue when you refuse to claim a result that you have not actually established.

---

# Stage 8 — Change Discipline

## Principle

Professional engineering is controlled change.

The question is not simply:

> Can I make this work?

The better questions are:

> What is the smallest coherent change that makes this work?
>
> What must remain unchanged?
>
> How will I know I did not damage something that already worked?

## Study

Re-read:

- `AGENTS.md`
- `.github/instructions/safety-architecture.instructions.md`
- `.github/instructions/workflow-testing.instructions.md`

This time, read them as one operating system rather than three documents.

## Practice

Take a real defect or small feature request.

Before editing, write a **change boundary**:

```text
MUST CHANGE:
- ...

MUST NOT CHANGE:
- ...

AUTHORITATIVE PATH:
- ...

RISKS:
- ...

VERIFICATION:
- ...
```

Implement the work.

Compare the final diff against the boundary you declared.

## Evidence

Show that every materially changed file is justified by the requirement, test coverage, documentation, migration, or required generated artifact.

## Gate

You may continue when unrelated cleanup begins to feel suspicious rather than productive.

Scope is an engineering control.

---

# Stage 9 — The Whole Machine

## Principle

A system is useful because many pieces cooperate for a purpose.

The apprentice must now move beyond isolated code and reason about the entire operating path.

Consider:

- user intent;
- product behavior;
- source code;
- data;
- APIs;
- security;
- infrastructure;
- external providers;
- deployment;
- observability;
- failure recovery;
- maintenance;
- cost;
- human operation.

The engineer's responsibility does not end where their favorite programming language ends.

## Practice

Choose a working application.

Explain what must happen from the moment a user expresses an intent until the intended result becomes real.

For example, if the product schedules an appointment, do not stop at the `POST /appointments` handler.

Consider:

- input and validation;
- identity;
- authorization;
- availability rules;
- persistence;
- conflicts/concurrency;
- notifications;
- external integrations;
- retries;
- user feedback;
- audit/history;
- deployment environment;
- monitoring;
- failure handling.

## Evidence

Produce a system diagram and a written explanation that a new engineer could use to begin investigating the feature.

## Gate

You may continue when you can explain how separate programs and components work together for the good of the person the system was built to serve.

This is the transition from programmer to systems thinker.

---

# Stage 10 — Idea to Reality

## Principle

This is the end the apprenticeship has been teaching toward from the beginning.

An engineer must be able to receive an idea that does not yet exist and systematically turn it into something real.

Not by immediately coding.

By reducing uncertainty.

## The Engineering Sequence

```text
IDEA
  ↓
WHO IS IT FOR?
  ↓
WHAT PROBLEM MUST CHANGE?
  ↓
WHAT DOES SUCCESS LOOK LIKE?
  ↓
WHAT CONSTRAINTS ARE REAL?
  ↓
WHAT SYSTEM OR COMPONENTS ARE REQUIRED?
  ↓
WHAT CONTRACTS AND BOUNDARIES MUST EXIST?
  ↓
WHAT IS THE SMALLEST USEFUL IMPLEMENTATION?
  ↓
BUILD
  ↓
VERIFY
  ↓
INTEGRATE
  ↓
OPERATE
  ↓
OBSERVE
  ↓
IMPROVE
  ↓
REALITY
```

## Capstone

Build something for another person.

The person must have a real problem or need.

The project does not need to be large. It does need to be complete enough that another human can use it.

You must:

1. interview or observe the person;
2. state the problem in plain language;
3. define the desired outcome;
4. identify constraints;
5. design the smallest coherent system;
6. document the architecture;
7. implement it;
8. test it;
9. let the person use it;
10. observe what actually happens;
11. repair the difference between your assumptions and reality;
12. produce an engineering completion report.

## Capstone Evidence

Your final submission should contain:

- problem statement;
- user and use case;
- system boundary;
- architecture diagram;
- important contracts and invariants;
- implementation;
- tests;
- verification results;
- operating instructions;
- known risks;
- what changed after real use;
- what you would build next and why.

## Final Gate

You have completed this apprenticeship when you can defend the following statement with evidence:

> I was given an idea. I investigated the problem, understood the system and its constraints, built the required change, verified it, and delivered a working reality without pretending to know what I had not established.

That is the standard.

---

# The Engineer's Operating Doctrine

The rule files in this repository can be reduced to a working doctrine:

1. **Inspect before you assume.**
2. **Understand the system before changing the system.**
3. **Treat existing architecture as evidence.**
4. **Know the boundary of the requested change.**
5. **Preserve what already works unless change is required.**
6. **Respect contracts, data, authorization, and ownership.**
7. **Prefer the smallest coherent implementation.**
8. **Do not confuse cleverness with engineering quality.**
9. **Test the behavior you changed.**
10. **Never manufacture evidence.**
11. **Report uncertainty instead of hiding it.**
12. **Understand the human outcome the machine exists to produce.**

---

# Rule Layers

The apprenticeship teaches the reasoning behind these repository-native engineering controls:

1. `AGENTS.md` — cross-agent operating contract and context router.
2. `.github/copilot-instructions.md` — VS Code/Copilot adapter and workspace entry point.
3. `.github/instructions/code-style.instructions.md` — code quality and implementation conventions.
4. `.github/instructions/safety-architecture.instructions.md` — architecture preservation, security, tenancy, data, and change-safety rules.
5. `.github/instructions/workflow-testing.instructions.md` — inspection, implementation, verification, and reporting workflow.
6. `docs/engineering/` — project-specific system-of-record documents that engineers and agents must read instead of guessing.

These are not substitutes for engineering judgment. They are controls designed to enforce it.

---

# Applying the Rules to a Real Project

After completing the earlier stages, install this repository's policy files into a practice or production repository and populate the project-specific engineering documents from evidence.

Do **not** write architecture documentation from memory, marketing language, or assumptions.

Derive it from:

- source code;
- configuration;
- schemas;
- migrations;
- tests;
- CI;
- infrastructure;
- deployment topology;
- authoritative product behavior.

## Windows / PowerShell

```powershell
./scripts/install-rules.ps1 -TargetRepo "C:\path\to\project"
```

## macOS / Linux / Git Bash

```bash
./scripts/install-rules.sh /path/to/project
```

The installers refuse to overwrite existing files unless `-Force` or `--force` is explicitly provided.

---

# VS Code

Open the target project root as the VS Code workspace. The included `.vscode/settings.json` enables the relevant instruction mechanisms for the workspace.

To confirm the rules are loaded:

1. Open Chat in VS Code.
2. Open the Chat customization diagnostics view.
3. Verify that `AGENTS.md`, `.github/copilot-instructions.md`, and the matching `.instructions.md` files appear in the applied context.

---

# Project-Specific Overrides

The baseline is deliberately conservative.

A project may define stricter rules in its own `AGENTS.md` or in additional `.github/instructions/*.instructions.md` files with narrow `applyTo` patterns.

Project facts belong in project documentation, not in this reusable baseline.

When documentation conflicts with executable code, configuration, migrations, or tests, investigate and report the conflict. Do not silently choose whichever source is more convenient.

---

# For Mentors

Do not grade apprentices primarily on speed or line count.

Grade their reasoning.

Ask:

- Did they inspect before acting?
- Can they trace the system?
- Can they distinguish fact from assumption?
- Did they preserve existing boundaries?
- Did they understand the data and contracts?
- Did they identify risk?
- Did they keep the change scoped?
- Did they verify the result?
- Can they explain failures without hiding them?
- Can they connect the implementation to the human outcome?

A student who produces fewer lines of code but demonstrates stronger control of the system is progressing toward engineering.

A student who produces large amounts of code without understanding the system is not.

---

# For Apprentices

You are not here to memorize rules.

You are here to become the kind of person who understands why the rules are necessary.

Start small.

Make the computer do something.

Then learn what made it happen.

Then learn how the pieces work together.

Then learn how to change them without breaking what other people depend on.

Then learn to prove your work.

Then take an idea that exists only in someone's mind and make it real.

That is the work.
