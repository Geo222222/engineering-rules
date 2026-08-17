# Engineering Rules

A reusable, repo-native AI engineering policy for VS Code, Codex, Copilot, Claude-compatible agents, and other coding agents that honor `AGENTS.md` or VS Code instruction files.

The objective is simple: **make agents behave like engineers operating inside an existing production system, not tutorial generators building from assumptions.**

## Rule Layers

1. `AGENTS.md` — cross-agent operating contract and context router.
2. `.github/copilot-instructions.md` — VS Code/Copilot adapter and workspace entry point.
3. `.github/instructions/code-style.instructions.md` — code quality and implementation conventions.
4. `.github/instructions/safety-architecture.instructions.md` — architecture preservation, security, tenancy, data, and change-safety rules.
5. `.github/instructions/workflow-testing.instructions.md` — inspection, implementation, verification, and reporting workflow.
6. `docs/engineering/` — project-specific system-of-record documents that agents must read instead of guessing.

## Recommended Per-Project Use

Copy this repository's policy files into the target project, then replace the template content in `docs/engineering/` with facts from the real codebase.

Do **not** fill architecture documentation from memory or a product pitch. Derive it from the repository, configuration, migrations, tests, and deployment topology.

### Windows / PowerShell

```powershell
./scripts/install-rules.ps1 -TargetRepo "C:\path\to\project"
```

### macOS / Linux / Git Bash

```bash
./scripts/install-rules.sh /path/to/project
```

The installers refuse to overwrite existing files unless `-Force` / `--force` is explicitly provided.

## VS Code

Open the project root as the VS Code workspace. The included `.vscode/settings.json` enables the relevant instruction mechanisms for the workspace.

To confirm the rules are loaded:

1. Open Chat in VS Code.
2. Open the Chat customization diagnostics view.
3. Verify `AGENTS.md`, `.github/copilot-instructions.md`, and the matching `.instructions.md` files appear in the applied context.

## Project-Specific Overrides

The baseline is deliberately conservative. A project can add stricter rules by editing its own `AGENTS.md` or adding additional `.github/instructions/*.instructions.md` files with narrow `applyTo` patterns.

Project facts always belong in project documentation, not in this reusable baseline.
