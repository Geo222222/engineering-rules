# Git Repository Control Lab — From Dirty Worktree to Verified Deployment

This lab is the practical examination for the Git Repository Control course.

The objective is not to memorize commands. The objective is to establish repository truth without destroying work.

## Scenario

You return to a project after another engineer or coding agent has been working on it.

You are told:

- GitHub may contain newer commits;
- your local checkout may contain uncommitted work;
- a feature branch contains a proposed fix;
- someone says the tests passed;
- a Docker container is already running;
- the team wants to know whether the fix can be pushed, merged, and deployed.

You are not allowed to assume any of those claims are true.

## Phase 1 — Orient

Answer:

1. Where is the repository root?
2. What branch are you on?
3. What exact commit is checked out?
4. What remotes are configured?
5. Is the working tree clean?

Suggested commands:

```bash
git rev-parse --show-toplevel
git branch --show-current
git rev-parse HEAD
git remote -v
git status -sb
```

### Evidence

Record the exact outputs that establish your answer.

### Gate

Do not fetch, pull, switch, reset, stash, clean, or edit until you understand the current local state.

---

## Phase 2 — Learn What GitHub Knows

Update remote-tracking information without integrating anything:

```bash
git fetch origin
```

Then answer:

- Is `origin/main` newer than your local knowledge was?
- Is your current branch ahead, behind, synchronized, or diverged from its upstream?
- Which commits exist only locally?
- Which commits exist only remotely?

Suggested commands:

```bash
git status -sb
git rev-list --left-right --count HEAD...@{upstream}
git log --oneline HEAD..@{upstream}
git log --oneline @{upstream}..HEAD
```

### Evidence

Write a one-paragraph state diagnosis.

### Gate

Do not integrate histories until you can name the relationship between them.

---

## Phase 3 — Classify the Dirt

If the worktree is dirty, classify every changed path as one of:

```text
INTENDED SOURCE CHANGE
INTENDED TEST CHANGE
CONFIGURATION CHANGE
GENERATED/RUNTIME DATA
UNRELATED USER WORK
UNKNOWN — REQUIRES INVESTIGATION
```

Use:

```bash
git status --short
git diff --stat
git diff
git diff --staged
```

### Evidence

Produce a table of changed paths and classifications.

### Gate

No destructive cleanup operation is allowed while any path remains `UNKNOWN`.

---

## Phase 4 — Prove the Fix Is Isolated

Compare the feature branch against canonical remote `main`:

```bash
git fetch origin
git diff --name-status origin/main...HEAD
git diff --stat origin/main...HEAD
git diff origin/main...HEAD
git log --oneline origin/main..HEAD
```

For every changed file, answer:

> Why is this file necessary to the requested fix?

### Evidence

Produce a change-boundary report:

```text
MUST CHANGE:
- ...

MUST NOT CHANGE:
- ...

ACTUAL CHANGED FILES:
- ...

UNEXPECTED FILES:
- ...
```

### Gate

Unexpected work must be removed from the proposed change or explicitly justified before proceeding.

---

## Phase 5 — Verify the Claim That Tests Passed

Discover the repository's authoritative test commands from its own documentation and CI configuration.

Run the required checks and record the exact tested commit:

```bash
git rev-parse HEAD
```

If GitHub CLI is available:

```bash
gh pr checks
gh run list --branch "$(git branch --show-current)"
```

### Evidence

Record:

- exact HEAD SHA;
- exact commands;
- pass/fail status;
- skipped checks;
- environment limitations;
- CI run identity if applicable.

### Gate

A test result that belongs to an older commit does not qualify the current commit.

---

## Phase 6 — Prove What Will Be Pushed

Before publishing anything:

```bash
git status -sb
git branch -vv
git log --oneline origin/main..HEAD
git diff --stat origin/main...HEAD
git push --dry-run -u origin HEAD
```

### Evidence

State:

- destination remote;
- destination branch;
- commits being introduced;
- whether any unexpected ref would move.

### Gate

Your prediction and the dry-run result must agree.

---

## Phase 7 — Make a Merge Decision

Inspect the pull request and answer:

- correct base?
- correct head?
- current head SHA?
- scoped diff?
- required tests green on that SHA?
- unresolved conflicts?
- unresolved review concerns?
- migrations/config/deployment consequences understood?

With GitHub CLI:

```bash
gh pr view
gh pr diff
gh pr checks
```

### Evidence

Issue one decision:

```text
MERGE
BLOCK
NEEDS MORE EVIDENCE
```

and justify it.

### Gate

Do not use "looks good" as a merge argument.

---

## Phase 8 — Establish Whether `main` Is Deployable

After an approved merge, establish canonical remote identity:

```bash
git fetch origin
git rev-parse origin/main
git log -1 --oneline --decorate origin/main
```

If the local `main` checkout is clean and intended for deployment:

```bash
git switch main
git pull --ff-only origin main
git rev-parse HEAD
git rev-parse origin/main
```

Then verify the required CI/build/release evidence for that exact SHA.

### Evidence

Record the deployable candidate SHA and why it is or is not qualified for deployment.

### Gate

`main` is not deployable merely because a merge completed.

---

## Phase 9 — Prove Docker Runtime Identity

Inspect the repository's Dockerfile and Compose configuration first. Determine whether source is copied into the image or bind-mounted at runtime.

Then inspect:

```bash
docker compose ps
docker compose images
docker compose config
docker ps --no-trunc
docker inspect <container>
docker image inspect <image>
```

If source is copied at build time and canonical source changed:

```bash
docker compose up -d --build
```

Then verify application health/version/behavior.

### Evidence

Record:

- expected Git SHA;
- image ID;
- container ID;
- rebuild/restart action;
- health/version evidence;
- final observed behavior.

### Gate

Do not claim the new code is running because Git is current. Prove the runtime state.

---

# Final Submission

Produce one concise operator report answering:

1. What branch am I on?
2. Is my working tree clean?
3. Has GitHub changed since I last worked?
4. Am I ahead, behind, or diverged?
5. Is this fix isolated?
6. Did the tests actually pass?
7. What exactly am I about to push?
8. Is this safe to merge?
9. Is `main` deployable right now?
10. Is Docker running the code I think it is running?

End with one explicit action recommendation:

```text
SAFE TO CONTINUE
SAFE TO PUSH ONLY
SAFE TO MERGE
SAFE TO DEPLOY
BLOCKED — <reason>
```

The lab is complete when every conclusion is backed by observable evidence rather than assumption.