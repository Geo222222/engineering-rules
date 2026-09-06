# Repository Control Command Reference

This sheet answers the operational questions an engineer should be able to answer before changing, pushing, merging, or deploying a repository.

Use it as a reference, not as a substitute for understanding the course in `README.md`.

## 0. What branch am I on?

Primary:

```bash
git branch --show-current
```

Also useful:

```bash
git status -sb
git log -1 --oneline --decorate
```

If the branch name is empty, investigate detached `HEAD` before editing.

## 1. Is my working tree clean?

```bash
git status
git status --short
```

Inspect dirt:

```bash
git diff
git diff --staged
```

A clean tree is evidence that the checked-out commit accounts for the current tracked state and no untracked files are waiting locally.

## 2. Has GitHub changed since I last worked?

First update remote knowledge without integrating it:

```bash
git fetch origin
```

Then inspect remote-only commits:

```bash
git log --oneline HEAD..origin/main
```

If you specifically want local `main` versus GitHub `main`:

```bash
git log --oneline main..origin/main
```

## 3. Am I ahead, behind, or diverged?

```bash
git fetch origin
git status -sb
git rev-list --left-right --count HEAD...@{upstream}
```

Interpret the count as:

```text
LEFT  = commits unique to HEAD
RIGHT = commits unique to upstream
```

So:

```text
0 0 = synchronized
3 0 = ahead by 3
0 4 = behind by 4
2 5 = diverged: 2 local-only and 5 upstream-only
```

Visualize divergence:

```bash
git log --oneline --decorate --graph --boundary HEAD...@{upstream}
```

## 4. Is this fix isolated?

Working tree:

```bash
git status --short
git diff --stat
git diff
```

Staged commit:

```bash
git diff --staged --stat
git diff --staged
```

Whole branch compared with canonical main:

```bash
git fetch origin
git diff --name-status origin/main...HEAD
git diff --stat origin/main...HEAD
git diff origin/main...HEAD
```

Every changed path should have a reason to exist in the change.

## 5. Did the tests actually pass?

There is no universal Git command for this. Run the repository's authoritative test/build/validation commands and bind the evidence to the exact revision:

```bash
git rev-parse HEAD
```

If GitHub CLI is available:

```bash
gh pr checks
gh run list --branch "$(git branch --show-current)"
gh run view <run-id>
```

The relevant question is not just "were tests run?" but "did the required checks pass against this exact commit?"

## 6. What exactly am I about to push?

```bash
git status -sb
git branch -vv
```

If upstream exists:

```bash
git log --oneline @{upstream}..HEAD
```

For a new feature branch based on `main`:

```bash
git log --oneline origin/main..HEAD
git diff --stat origin/main...HEAD
```

Dry run before publication:

```bash
git push --dry-run
```

New branch:

```bash
git push --dry-run -u origin HEAD
```

## 7. Is this safe to merge?

Local evidence:

```bash
git fetch origin
git diff --name-status origin/main...HEAD
git diff origin/main...HEAD
git log --oneline origin/main..HEAD
```

GitHub PR evidence when `gh` is available:

```bash
gh pr view
gh pr diff
gh pr checks
```

A merge decision should consider scope, tests, review, conflicts, current head SHA, secrets/generated files, migrations, and deployment consequences.

## 8. Is `main` deployable right now?

Establish exact canonical remote commit:

```bash
git fetch origin
git rev-parse origin/main
git log -1 --oneline --decorate origin/main
```

If synchronizing a clean local `main`:

```bash
git switch main
git pull --ff-only origin main
git rev-parse HEAD
git rev-parse origin/main
```

Then verify the repository's required CI/build/release evidence for that exact SHA.

## 9. Is Docker running the code I think it is running?

First establish expected source identity:

```bash
git rev-parse HEAD
```

Then inspect runtime:

```bash
docker compose ps
docker compose images
docker compose config
docker ps --no-trunc
docker inspect <container>
docker image inspect <image>
```

If application source is copied into the image during build, rebuild after source changes:

```bash
docker compose build
docker compose up -d
```

or:

```bash
docker compose up -d --build
```

Do not infer runtime code identity from a successful `git pull`.

---

# Safe Default Sequences

## Before starting new work

```bash
git branch --show-current
git status -sb
git fetch origin
git status -sb
git log -1 --oneline --decorate HEAD
git log -1 --oneline --decorate origin/main
```

If your intended starting point is clean canonical `main`:

```bash
git switch main
git pull --ff-only origin main
git switch -c active/<campaign-name>
```

## Before committing

```bash
git status --short
git diff
git add <intended-paths>
git diff --staged --check
git diff --staged
```

## Before pushing

```bash
# run authoritative tests first
git rev-parse HEAD
git log --oneline origin/main..HEAD
git diff --stat origin/main...HEAD
git push --dry-run -u origin HEAD
git push -u origin HEAD
```

## Before merging

```bash
git fetch origin
git diff --name-status origin/main...HEAD
git log --oneline origin/main..HEAD
gh pr checks
```

Then inspect the PR itself and make an explicit merge/block decision.