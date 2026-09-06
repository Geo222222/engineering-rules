# Git Repository Control — The Operator's Apprenticeship

This course teaches a skill that sits between programming and production operations:

> **Knowing exactly what code you have, what changed, what you are about to publish, and whether it is safe to integrate and deploy.**

A developer can write a correct fix and still damage a project by working from stale code, editing the wrong branch, losing uncommitted work, pushing unrelated files, merging before tests finish, or deploying an image that does not contain the commit they believe it contains.

Git is therefore not merely a place to save code. It is a system for preserving and comparing versions of a repository, coordinating independent changes, proving how a system evolved, and controlling how work becomes canonical.

GitHub is not Git. Git is the distributed version-control system on your computer. GitHub is a remote collaboration platform that stores Git repositories and adds pull requests, code review, CI, issues, releases, permissions, and other team controls.

This course is written for both individual engineers and team leads. The commands are important, but the goal is judgment: you should know **which question must be answered before taking the next action**.

---

# The Mental Model

A useful simplified model is:

```text
WORKING TREE
files you are currently editing
      ↓ git add
STAGING AREA / INDEX
exact changes selected for the next commit
      ↓ git commit
LOCAL REPOSITORY
commits and branches stored on your machine
      ↓ git push
REMOTE REPOSITORY
GitHub's copy of branches and commits
      ↓ pull request + CI + review
CANONICAL MAIN
accepted integrated history
      ↓ deployment
RUNNING SYSTEM
what users or operators actually execute
```

These are different states. A change existing in one does not prove it exists in the next.

Examples:

- A file can be edited but not staged.
- A change can be committed locally but not pushed.
- A branch can be pushed but not merged.
- A commit can be merged into `main` but not deployed.
- `main` can be deployed but Docker may still be running an older image.

Your job is to establish which state is true.

---

# How This Course Works

Every lesson follows the apprenticeship structure used throughout this repository:

1. **Principle** — what must be understood.
2. **Study** — concepts and commands to inspect.
3. **Practice** — work to perform.
4. **Evidence** — what proves you understood or completed the work.
5. **Gate** — the standard required before moving forward.

Keep a notebook. For every repository operation, record the command, what you expected, what actually happened, and why the result did or did not justify the next action.

---

# Lesson 0 — What Git Is and Why Engineers Use It

## Principle

Software changes over time. Engineers need a durable way to answer:

- What did the repository look like before this change?
- Who changed it?
- Why was it changed?
- What exactly changed?
- Can two people work independently without overwriting one another?
- Can a failed change be located, compared, or reverted?
- Which version is authoritative?

Git records repository history as commits. Branches let different lines of work progress independently. Remotes let independent machines exchange those commits.

For one engineer, Git protects you from your own uncertainty. For a team, Git becomes a coordination protocol.

## Study

Learn these terms before memorizing commands:

- **repository** — the project plus Git history;
- **working tree** — the files currently checked out on disk;
- **commit** — an immutable snapshot reference with metadata and parent history;
- **branch** — a movable name pointing at a commit;
- **HEAD** — what you currently have checked out;
- **remote** — another Git repository, commonly named `origin`;
- **fetch** — learn what the remote has without changing your working tree;
- **pull** — fetch plus integration into the current branch;
- **push** — publish local commits to a remote branch;
- **merge** — integrate histories;
- **pull request** — GitHub review/integration workflow around a proposed branch change;
- **working-tree dirt** — tracked modifications, staged changes, or untracked files not represented by the current commit.

Useful orientation commands:

```bash
git --version
git rev-parse --show-toplevel
git remote -v
git status
```

## Practice

Open a real repository and identify:

- repository root;
- current branch;
- configured remote;
- current HEAD commit;
- whether there are local changes.

## Evidence

Write a short explanation of the difference between Git, GitHub, a branch, a commit, and your working tree.

## Gate

You may continue when you no longer use "GitHub," "Git," "branch," and "folder" as interchangeable concepts.

---

# Lesson 1 — What Branch Am I On?

## Principle

Before changing files, know which line of history will receive the work.

## Study

Primary command:

```bash
git branch --show-current
```

Supporting commands:

```bash
git status -sb
git rev-parse --abbrev-ref HEAD
git log -1 --oneline --decorate
```

If `git branch --show-current` prints nothing, you may be in a detached-HEAD state. Do not assume you are safely on a feature branch.

## Practice

Switch between two disposable branches and run the commands above after each switch.

## Evidence

You can state the current branch and current commit before editing anything.

## Gate

Never begin a change because "this looks like the right folder." Establish the branch and HEAD.

---

# Lesson 2 — Is My Working Tree Clean?

## Principle

A clean working tree means the checked-out commit fully accounts for the repository files Git is tracking and there are no untracked additions waiting locally. A dirty tree means local state exists that may be valuable, unrelated, generated, or dangerous to overwrite.

## Study

Primary commands:

```bash
git status
git status --short
```

Interpret common short-status codes:

```text
 M file.py   tracked file modified in working tree
M  file.py   tracked file staged
MM file.py   staged version exists and file changed again afterward
?? file.txt  untracked file
D  file.py   deletion staged
```

Inspect changes before deciding what they mean:

```bash
git diff
git diff --staged
```

## Practice

Modify one tracked file, create one new file, stage only one of them, and observe how status changes.

## Evidence

Explain exactly which changes are staged, unstaged, and untracked.

## Gate

Do not run destructive cleanup, checkout, reset, or blind pull operations against a dirty tree until the dirt has been classified.

---

# Lesson 3 — Has GitHub Changed Since I Last Worked?

## Principle

Your local repository does not automatically know about new remote commits. `fetch` updates your knowledge without integrating those commits into your working branch.

## Study

Safe first synchronization command:

```bash
git fetch origin
```

Then inspect:

```bash
git status -sb
git log --oneline --decorate --graph --all -20
```

To see remote commits that are not in your local `main`:

```bash
git log --oneline main..origin/main
```

To see local commits not present on remote `main`:

```bash
git log --oneline origin/main..main
```

## Practice

Fetch a repository that has a remote and compare local and remote tracking refs.

## Evidence

You can answer whether `origin/main` changed without modifying your working files.

## Gate

Develop the habit:

```text
STATUS → FETCH → INSPECT → INTEGRATE
```

not:

```text
PULL FIRST → FIGURE OUT WHAT HAPPENED AFTERWARD
```

---

# Lesson 4 — Am I Ahead, Behind, or Diverged?

## Principle

A branch relationship is evidence about history, not a feeling.

- **ahead**: your branch contains commits its upstream does not;
- **behind**: upstream contains commits your branch does not;
- **diverged**: both sides contain unique commits;
- **up to date**: both refs identify the same reachable history.

## Study

Start with:

```bash
git fetch origin
git status -sb
```

Count unique commits on each side:

```bash
git rev-list --left-right --count HEAD...@{upstream}
```

Example output:

```text
2	5
```

means two commits unique to `HEAD` and five unique to the upstream branch: the histories diverged.

For explicit `main` comparison:

```bash
git rev-list --left-right --count main...origin/main
```

Visualize:

```bash
git log --oneline --decorate --graph --boundary HEAD...@{upstream}
```

## Practice

Use disposable branches to create an ahead-only case and a diverged case.

## Evidence

State the relationship and identify the exact unique commits.

## Gate

Do not merge, rebase, reset, or force-push until you can explain the divergence you are trying to resolve.

---

# Lesson 5 — Is This Fix Isolated?

## Principle

A good fix should have a defensible change boundary. An unrelated file in a diff is not harmless merely because the intended fix also works.

## Study

Inspect working changes:

```bash
git status --short
git diff --stat
git diff
```

Inspect what is staged for commit:

```bash
git diff --staged --stat
git diff --staged
```

Inspect branch changes relative to canonical main:

```bash
git fetch origin
git diff --stat origin/main...HEAD
git diff origin/main...HEAD
```

List changed paths only:

```bash
git diff --name-status origin/main...HEAD
```

## Practice

Create one intended change and one unrelated change. Prove you can identify and exclude the unrelated work from the commit.

## Evidence

For every changed file, answer: **Why is this file required by the requested change?**

## Gate

If you cannot defend a changed file, it does not belong in the fix yet.

---

# Lesson 6 — Did the Tests Actually Pass?

## Principle

Git does not know whether your program works. Tests, builds, linters, type checks, integration checks, and runtime probes are separate evidence systems.

A statement such as "tests passed" is meaningful only when you can identify:

- the command;
- the code revision tested;
- the environment;
- the result;
- any skipped, flaky, or unexecuted checks.

## Study

There is no universal test command. Discover the repository's authoritative commands from files such as:

```text
README.md
AGENTS.md
package.json
pyproject.toml
Makefile
justfile
.github/workflows/*
```

After local testing, record your exact HEAD:

```bash
git rev-parse HEAD
```

For GitHub Actions, inspect the pull request checks and confirm they ran against the current PR head commit, not an older commit.

Useful GitHub CLI commands when available:

```bash
gh pr checks
gh run list --branch "$(git branch --show-current)"
gh run view <run-id>
```

## Practice

Run a focused test, then the repository's broader required verification. Change the code afterward and explain why the earlier result no longer proves the new HEAD.

## Evidence

A verification record containing the exact commit SHA, commands, and outcomes.

## Gate

Never convert "I ran tests earlier" into "this commit passed" without proving they refer to the same revision.

---

# Lesson 7 — What Exactly Am I About to Push?

## Principle

`git push` publishes commits, not your intention. Know which commits and branch ref will move before you push.

## Study

Identify branch and upstream:

```bash
git status -sb
git branch -vv
```

Inspect commits that would be new to the upstream:

```bash
git log --oneline @{upstream}..HEAD
```

If the branch has no upstream yet, compare against the intended remote base, commonly:

```bash
git log --oneline origin/main..HEAD
git diff --stat origin/main...HEAD
```

Preview ref updates without sending them:

```bash
git push --dry-run
```

For a new branch:

```bash
git push --dry-run -u origin HEAD
```

Then publish intentionally:

```bash
git push -u origin HEAD
```

## Practice

Before every practice push, predict the branch name and commits that will be published. Run dry-run and compare reality with your prediction.

## Evidence

You can name the remote branch and every local commit that is about to become remotely visible.

## Gate

Do not use push as a diagnostic command.

---

# Lesson 8 — Is This Safe to Merge?

## Principle

Merge safety is a conclusion assembled from several independent facts. "The PR is green" is necessary in many projects but not sufficient by itself.

## Study

Before merge, establish:

- correct base branch;
- intended head branch;
- current head SHA;
- clean and scoped diff;
- no unexpected generated files or secrets;
- required reviews complete;
- required CI checks green on the current head;
- no unresolved review threads or merge conflicts;
- branch includes or is compatible with current canonical `main` according to repository policy;
- deployment/migration implications understood.

Local comparison:

```bash
git fetch origin
git diff --name-status origin/main...HEAD
git diff origin/main...HEAD
git log --oneline origin/main..HEAD
```

With GitHub CLI:

```bash
gh pr view
gh pr diff
gh pr checks
```

## Practice

Review a real or disposable pull request and write a merge decision: MERGE, BLOCK, or NEEDS EVIDENCE. Support the decision with facts.

## Evidence

A merge checklist with links or command output supporting each material claim.

## Gate

You may merge when uncertainty has been reduced to an acceptable, explicit level — not merely because the change looks good.

---

# Lesson 9 — Is `main` Deployable Right Now?

## Principle

`main` being current does not automatically mean `main` is deployable. Deployability depends on the repository's contract.

A deployable `main` commonly requires:

- the intended commit is actually on `origin/main`;
- required CI for that commit passed;
- build artifacts can be produced;
- required configuration/migrations are understood;
- no known release blocker is open;
- deployment process targets that commit or artifact;
- rollback or recovery path is understood.

## Study

Synchronize knowledge:

```bash
git fetch origin
```

Inspect canonical remote HEAD:

```bash
git rev-parse origin/main
git log -1 --oneline --decorate origin/main
```

If your local `main` is intended to match exactly:

```bash
git switch main
git pull --ff-only origin main
git rev-parse HEAD
git rev-parse origin/main
```

Those final two SHAs should match after a successful fast-forward synchronization.

Then inspect the CI/build evidence attached to that exact SHA using the repository's workflow tools.

## Practice

Pick a repository and write a deployability decision for its current remote `main`. Separate facts you established from checks you could not perform.

## Evidence

A deployability report with the exact canonical SHA.

## Gate

Never deploy "latest" as an abstract concept. Know the exact revision or artifact identity being released.

---

# Lesson 10 — Is Docker Running the Code I Think It Is Running?

## Principle

Source control state and runtime state are separate systems.

Docker can keep running an old image even after Git has newer code. A bind-mounted source tree may update immediately while code copied into an image requires rebuilding. Tags such as `latest` are names, not proof of source identity.

## Study

First establish the source commit you intend to run:

```bash
git rev-parse HEAD
```

Inspect running containers:

```bash
docker compose ps
docker ps --no-trunc
```

Inspect images and container configuration:

```bash
docker compose images
docker inspect <container>
docker image inspect <image>
```

See the effective Compose configuration:

```bash
docker compose config
```

If the Dockerfile uses `COPY` for application source, a Git update generally requires an image rebuild before the container contains the new source:

```bash
docker compose build
docker compose up -d
```

Or explicitly rebuild while starting:

```bash
docker compose up -d --build
```

If Compose bind-mounts source code into the container, source visibility may update without rebuilding, but dependencies, build steps, compiled assets, or image metadata may still require a rebuild/restart. Inspect the actual Compose and Dockerfile rather than assuming.

Strong production practice is to stamp the source commit into an image label or environment variable during build, for example `org.opencontainers.image.revision=<git-sha>`, then expose that revision through a health/version endpoint. That turns runtime identity into something directly testable.

## Practice

Build a disposable image from one commit, change the repository, and prove that the already-running container did not magically acquire code copied at build time. Rebuild and verify the change.

## Evidence

Record:

- expected Git SHA;
- image ID;
- container ID;
- effective Compose configuration;
- runtime version/health evidence;
- whether rebuild and/or restart was required.

## Gate

You may claim "the new code is running" only after verifying runtime identity or behavior, not merely after `git pull` succeeds.

---

# The Daily Repository Control Sequence

For ordinary work, use this decision sequence before editing:

```text
1. Where am I?
2. What branch/commit am I on?
3. Is the tree clean?
4. Has the remote changed?
5. What is my relationship to the upstream?
6. Is it safe to begin from this state?
```

A practical command sequence is:

```bash
git rev-parse --show-toplevel
git branch --show-current
git status -sb
git fetch origin
git status -sb
git log -1 --oneline --decorate HEAD
git log -1 --oneline --decorate origin/main
```

For new work from canonical `main`, once the tree/state is safe:

```bash
git switch main
git pull --ff-only origin main
git switch -c active/<campaign-name>
```

Before publishing:

```bash
git status --short
git diff --check
git diff --staged
# run the repository's authoritative tests
git log --oneline origin/main..HEAD
git diff --stat origin/main...HEAD
git push --dry-run -u origin HEAD
git push -u origin HEAD
```

Then use a pull request, CI, review, and an explicit merge decision rather than making direct-to-`main` implementation pushes the default workflow.

---

# Final Practical Examination

Use a disposable repository or a real low-risk change.

You receive this situation:

> Another engineer or agent changed GitHub while you were away. You also have local edits. A fix has been implemented, Docker is already running, and someone asks whether the fix can be merged and deployed.

Without destroying any work, establish answers to all ten operator questions:

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

Produce a short evidence report containing the commands used, the important outputs, and your final action recommendation.

## Final Gate

The apprentice passes when they can make the following statement and support every word:

> **I know what repository state I have, what changed, what has been verified, what will be published, what is canonical, and what is actually running.**

That is repository control.