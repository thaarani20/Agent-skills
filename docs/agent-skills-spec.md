# Agent Skills Specification (Summary)

Official spec: <https://agentskills.io/specification>. The upstream template is in [upstream/template/SKILL.md](../upstream/template/SKILL.md).

## Folder layout

```
skill-name/
├── SKILL.md          # required
├── scripts/          # optional executable helpers
├── references/       # optional docs, loaded on demand
└── assets/           # optional templates, images, data
```

## Frontmatter

| Field | Required | Rules |
| --- | --- | --- |
| `name` | Yes | Lowercase letters, numbers and hyphens; max 64 characters; should match the folder name |
| `description` | Yes | What the skill does and when to use it; max 1024 characters |
| `license` | No | License name or a pointer to `LICENSE.txt` |
| `compatibility` | No | Environment requirements |
| `metadata` | No | Arbitrary key/value pairs |
| `allowed-tools` | No (experimental) | Tools the skill may use without asking |

## Minimal example

```markdown
---
name: my-skill-name
description: A clear description of what this skill does and when to use it
---

# My Skill Name

Instructions the agent follows when this skill is active.
```

## Progressive disclosure

1. **Advertise**: only `name` and `description` are in context, about 100 tokens per skill.
2. **Load**: the full `SKILL.md` body is read when a task matches.
3. **Read resources**: files in `references/` and `assets/` are opened only if needed.
4. **Run scripts**: scripts in `scripts/` are run rather than loaded into context.

## Writing a good description

- Say both **what** the skill does and **when** to use it, including trigger words.
- Say when **not** to use it if it overlaps with other skills (see `docx` and `xlsx`).
- Write in the third person, and keep the body under about 500 lines; move details into `references/`.
