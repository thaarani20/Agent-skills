# Agent Skills

A session kit for **Agent Skills**: the full set of open-source skills from [anthropics/skills](https://github.com/anthropics/skills), a custom skill, Cursor MCP config, and documentation, a demo script and a quiz.

## Contents

```
.cursor/skills/     19 Anthropic skills + code-reviewer (read by Cursor)
.agents/skills/     Same skills in the universal location (Cursor, Codex, OpenCode, ...)
.cursor/mcp.json    Playwright + GitHub MCP servers
docs/               Guide, spec summary, catalog, Cursor how-to, demo, quiz, deck
upstream/           Upstream README, spec pointer, template, third-party notices
```

## Documentation
- [Skills catalog](docs/skills-catalog.md): every skill, what it does and when to use it
- [Agent Skills spec summary](docs/agent-skills-spec.md)
- [Agent Skills guide](docs/Agent-Skills-Generic-and-Platforms-Guide.md): concepts and how each platform supports skills
- [Skills and MCP in Cursor](docs/cursor-skills-and-mcp.md)
- [Demo script](docs/Demo-Script.md)
- [Quiz: 30 questions with answers](docs/Agent-Skills-Quiz.md)
- [Preparation estimate](docs/Prep-Estimate.md)
- [References](docs/references.md)
- [Presentation deck](docs/agent-skills-deck.pptx)

## Quick start in Cursor
1. Clone the repo and open it in Cursor. The skills in `.cursor/skills/` are picked up automatically.
2. Check Cursor Settings > Rules, Skills, Subagents to see them listed.
3. In Agent chat, type `/` and choose a skill (for example `/pdf`), or just describe your task.
4. Open Cursor Settings > Tools & MCP and turn on `playwright` from `.cursor/mcp.json`.

## Credits and licenses
Skills under `.cursor/skills/` and `.agents/skills/` (except `code-reviewer`) are copied unchanged from [anthropics/skills](https://github.com/anthropics/skills) at commit `dbd4588`. Most are Apache-2.0. `docx`, `pdf`, `pptx` and `xlsx` are **source-available, not open source**. Each skill keeps its own `LICENSE.txt`; see [upstream/THIRD_PARTY_NOTICES.md](upstream/THIRD_PARTY_NOTICES.md). These skills are for demonstration and educational use.
