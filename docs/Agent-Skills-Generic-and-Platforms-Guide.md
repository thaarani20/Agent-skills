# Agent Skills: From Concept to Cursor, Claude, and Beyond

A practical guide to what agent skills are in general, how they differ from tools and prompts, and how major AI coding products implement them.

*Last updated: October 2026*

---

## Part 1 — Agent Skills in General (Platform-Agnostic)

### 1. What is an agent skill?

An **agent skill** is reusable procedural knowledge packaged so an AI agent can discover it, load it when relevant, and follow it across a task. Unlike a single API call or a one-off prompt, a skill typically declares what domain it covers, how to work through that domain step by step, what to do when things fail, and optionally bundles scripts, templates, and reference files.

Research and industry docs often describe skills as a **recipe** for the agent: they do not replace the model's general intelligence or your tools, but they specify how to combine tools, files, and judgment to complete a class of real-world work reliably.

### 2. Why skills exist

- General LLMs know a lot but lack your org's procedures, brand rules, internal APIs, and compliance steps.
- Fine-tuning is expensive and hard to compose; pasting long instructions into every chat does not scale.
- RAG retrieves facts but rarely encodes multi-step workflows, permissions, or executable helpers in one package.
- MCP and function tools give atomic actions (search, send email, run SQL) but not full domain playbooks.

### 3. Skills vs related ideas

| Concept | What it is | Strength | Limitation |
| --- | --- | --- | --- |
| Tool / function | One callable action with a schema | Precise execution | No workflow or policy |
| System prompt / rule | Always-on or file-scoped text | Simple conventions | Poor for long workflows |
| RAG | Retrieved document chunks | Fresh factual context | Passive; weak procedure |
| Fine-tuning | Weight changes | Style/habit in model | Cost, drift, not composable |
| Workflow / orchestrator | Fixed graph of steps | Deterministic, checkpointable | Less adaptive |
| Agent skill | `SKILL.md` + optional scripts/refs | Portable expertise on demand | Agent must choose when to load |

**Mnemonic:** Tools are **verbs**; skills are **expertise** (how to use verbs and resources for a domain).

### 4. Typical anatomy of a skill

The open [Agent Skills specification](https://agentskills.io/specification) defines a common shape:

```
skill-name/
├── SKILL.md          # Required: metadata + instructions
├── scripts/          # Optional: executable code
├── references/       # Optional: documentation
└── assets/           # Optional: templates, resources
```

- **SKILL.md** — required YAML frontmatter (`name`, `description`) + markdown instructions
- **scripts/** — optional code the agent runs (validate, transform, deploy helpers)
- **references/** or `reference.md` — deeper docs loaded only when needed
- **assets/** — templates, images, lookup tables
- Optional frontmatter: `license`, `compatibility`, `metadata`, `allowed-tools` (experimental)

**Progressive disclosure** is the core efficiency pattern:

1. **Advertise** — short name + description in context (~100 tokens per skill)
2. **Load** — full `SKILL.md` when the task matches
3. **Read resources** — supplementary files only as needed
4. **Run scripts** — bundled executables when needed

Microsoft Agent Framework documents this as: advertise → `load_skill` → `read_skill_resource` → `run_skill_script`.

### 5. Skill lifecycle (generic)

1. **Discovery** — Agent sees catalog of skill metadata at session start.
2. **Matching** — User request or agent reasoning aligns with a skill's description (scope).
3. **Activation** — Full instructions (and sometimes tool permissions) enter context.
4. **Execution** — Agent follows steps, uses tools, runs bundled scripts.
5. **Fallback** — Good skills state when **not** to apply and how to retreat safely.

### 6. Benefits

- **Consistency** — Same review, deploy, or reporting process every time.
- **Composability** — Mix skills (e.g. code-review + security-review) without one giant prompt.
- **Portability** — Same folder can work across products that implement the open standard.
- **Version control** — Skills live in git like code; teams review changes.
- **Context efficiency** — Pay token cost only when a skill is actually used.
- **Governance** — Scope, `allowed-tools`, and security review treat skills like dependencies.

### 7. Risks and open questions

- Prompt injection via malicious `SKILL.md` or scripts — review before trusting third-party skills.
- Over-broad skills waste context; too-narrow skills duplicate tool wrappers.
- **Composition** — how skills interact when multiple match is still evolving.
- **Evaluation** — measuring skill quality across sessions is harder than unit-testing a function.

### 8. Minimal generic example

```markdown
---
name: expense-report
description: Validate and file expense reports per company policy. Use when user mentions expenses, receipts, or reimbursement.
---

# Expense report

1. Collect amount, date, category, receipt.
2. Run `scripts/validate_policy.py`.
3. If over limit, stop and cite policy section in `references/policy.md`.
4. Draft submission email using `assets/template.txt`.
```

---

## Part 2 — The Open Agent Skills Standard

Anthropic introduced Agent Skills for Claude and published the format as an **open standard** ([agentskills.io](https://agentskills.io/specification), December 2025). The spec requires `SKILL.md` with `name` and `description`; optional directories for scripts, references, and assets.

- **name** — lowercase alphanumeric + hyphens, max 64 characters; should match folder name
- **description** — what the skill does and when to use it, max 1024 characters

**Ecosystem:** [anthropics/skills](https://github.com/anthropics/skills) on GitHub, skills CLI installers, [Azure Agent Skills](https://learn.microsoft.com/training/support/agent-skills) (Microsoft Learn indexes), and compatibility matrices across dozens of coding agents.

---

## Part 3 — How Major Products Use Agent Skills

### Claude (Anthropic)

- **Claude.ai** — bundled and custom skills for document, analysis, and workflow tasks.
- **Claude Code** — `.claude/skills/` (project) and `~/.claude/skills/` (user).
- Often the **richest** implementation: hooks, `context: fork` (isolated runs), `allowed-tools`.
- Skills reshape **preparation** (instructions + permissions) before the model acts; not the same as a single tool return value.
- Docs: [Agent Skills overview](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview)

### Cursor

- Implements the **open standard** plus Cursor-specific built-in skills (`create-skill`, `canvas`, `autopilot`, etc.).
- Discovery paths: `.agents/skills/`, `.cursor/skills/`, `~/.agents/skills/`, `~/.cursor/skills/`.
- Agent auto-selects skills from descriptions; type **`/`** in Agent chat to invoke by name.
- Custom modes (Option+Enter / Alt+Enter) can keep a skill active for a session.
- Built-ins live in `~/.cursor/skills-cursor/` — do not edit.
- Docs: [cursor.com/docs/skills](https://cursor.com/docs/skills)

### OpenAI Codex

- Universal `.agents/skills/` (project) and `~/.codex/skills/` (user).
- Same `SKILL.md` format; basic skills and `allowed-tools` per compatibility tables.
- Share skills with Cursor/OpenCode via `.agents/skills/`.

### GitHub Copilot

- Supports basic Agent Skills (`SKILL.md`) per open-standard compatibility lists.
- **Azure Agent Skills** — Microsoft-authored Azure-focused skills installable for Copilot, Cursor, Claude Code, Gemini CLI, Codex, etc.
- Skills complement Copilot tools/MCP for Azure best practices and troubleshooting.

### Microsoft Agent Framework

- Programmatic agents (C#, Python, Go) register skills via `SkillsProvider`.
- Explicit tools: `load_skill`, `read_skill_resource`, `run_skill_script`.
- **Skills** = agent decides how; **workflows** = you define deterministic steps with checkpointing.
- [Agent Framework skills](https://learn.microsoft.com/agent-framework/agents/skills)

### Other agents (representative)

- OpenCode, Cline, Roo Code, Gemini CLI, Amp, Replit — often `.agents/skills/` (universal layout).
- Claude Code — `.claude/skills/` (can symlink to universal copy).
- Feature support varies: `allowed-tools` widely supported; hooks and `context:fork` mainly Claude Code / Cline.
- AgentSkills CLI and `npx skills` install the same skill package to multiple agents.

### Platform comparison (summary)

| Product | Typical skill locations | Notes |
| --- | --- | --- |
| Claude Code | `.claude/skills/`, `~/.claude/skills/` | Richest skill features (hooks, fork) |
| Cursor | `.cursor/skills/`, `.agents/skills/`, `~/.cursor/skills/` | Built-in `/` skills; cloud sync nuances |
| Codex | `.agents/skills/`, `~/.codex/skills/` | Universal directory |
| Copilot + Azure skills | Project + Microsoft catalog | Azure Learn-backed indexes |
| Agent Framework (custom apps) | Code + filesystem | `load_skill` API in your agent |

---

## Part 4 — When to Create a Skill

Create a skill when:

- You have a **multi-step domain workflow** (onboarding, release, incident response).
- **Team standards** should live in the repo (`.cursor/skills` or `.agents/skills`).
- **Procedure + scripts + policy docs** belong together.
- You want the **same package** in Cursor and Claude without rewriting.

Prefer a **short rule** or **single tool** when: one file-type convention (`.mdc` rules) or one API call suffices.

---

## Part 5 — References

- https://agentskills.io/specification
- https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills
- https://cursor.com/docs/skills
- https://learn.microsoft.com/agent-framework/agents/skills
- https://learn.microsoft.com/training/support/agent-skills
- https://github.com/anthropics/skills
