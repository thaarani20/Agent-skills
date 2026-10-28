# Skills Catalog

All skills from [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills) (commit `dbd4588`), plus one custom skill. Each skill is in both `.cursor/skills/<name>/` and `.agents/skills/<name>/`.

## Document skills (source-available, not open source)

| Skill | What it does | Use when |
| --- | --- | --- |
| [docx](../.cursor/skills/docx/SKILL.md) | Create, read and edit Word documents and templates, including tracked changes and comments | The deliverable is a `.docx` report, memo or letter |
| [pdf](../.cursor/skills/pdf/SKILL.md) | Extract text and tables, merge, split, watermark, fill forms, OCR | Any task that reads or produces a PDF |
| [pptx](../.cursor/skills/pptx/SKILL.md) | Create, parse and edit slide decks, layouts and speaker notes | The user mentions a deck, slides or a `.pptx` file |
| [xlsx](../.cursor/skills/xlsx/SKILL.md) | Read, clean, build and format spreadsheets, formulas and charts | A spreadsheet is the main input or output |

## Creative and design

| Skill | What it does | Use when |
| --- | --- | --- |
| [algorithmic-art](../.cursor/skills/algorithmic-art/SKILL.md) | Generative art with p5.js and seeded randomness | Flow fields, particle systems, code art |
| [canvas-design](../.cursor/skills/canvas-design/SKILL.md) | Static visual art as `.png` or `.pdf` | Posters and static designs |
| [frontend-design](../.cursor/skills/frontend-design/SKILL.md) | Visual direction and typography for UI | Building or restyling a UI |
| [slack-gif-creator](../.cursor/skills/slack-gif-creator/SKILL.md) | Animated GIFs that meet Slack's limits | "Make me a GIF for Slack" |
| [theme-factory](../.cursor/skills/theme-factory/SKILL.md) | 10 preset themes, or a new one, for any artifact | Styling slides, docs or landing pages |
| [brand-guidelines](../.cursor/skills/brand-guidelines/SKILL.md) | Anthropic brand colors and typography | Applying company design standards |

## Development and technical

| Skill | What it does | Use when |
| --- | --- | --- |
| [mcp-builder](../.cursor/skills/mcp-builder/SKILL.md) | Guide to building MCP servers (Python FastMCP or TypeScript SDK) | Connecting an external API to an LLM |
| [webapp-testing](../.cursor/skills/webapp-testing/SKILL.md) | Test local web apps with Playwright: screenshots, logs | Checking frontend behavior |
| [web-artifacts-builder](../.cursor/skills/web-artifacts-builder/SKILL.md) | Multi-component HTML artifacts with React, Tailwind and shadcn/ui | Complex artifacts with state or routing |
| [claude-api](../.cursor/skills/claude-api/SKILL.md) | Claude API and SDK reference: models, pricing, tool use, caching | Code that calls Claude or Anthropic |
| [skill-creator](../.cursor/skills/skill-creator/SKILL.md) | Create, improve and evaluate skills, and tune descriptions | Writing or benchmarking a skill |

## Enterprise and communication

| Skill | What it does | Use when |
| --- | --- | --- |
| [internal-comms](../.cursor/skills/internal-comms/SKILL.md) | Status reports, leadership updates, newsletters, incident reports | Writing internal communications |
| [doc-coauthoring](../.cursor/skills/doc-coauthoring/SKILL.md) | Structured workflow for writing specs, proposals and decision docs | Drafting long-form documentation |
| [academy-guide](../.cursor/skills/academy-guide/SKILL.md) | Recommends Claude Academy courses and tutorials | "How do I use Claude for..." questions |
| [discernment-nudge](../.cursor/skills/discernment-nudge/SKILL.md) | Prompts the user to check advice, estimates or drafts before acting on them | After a substantive answer the user may rely on |

## Custom skill

| Skill | What it does | Use when |
| --- | --- | --- |
| [code-reviewer](../.cursor/skills/code-reviewer/SKILL.md) | Reviews FastAPI backends against a standardization guide covering layers, settings, JWT, response contract and tests | Reviewing backend PRs or diffs |

## Licenses

Most skills are Apache-2.0. `docx`, `pdf`, `pptx` and `xlsx` are source-available under Anthropic's terms. Each skill keeps its own `LICENSE.txt`; see also [upstream/THIRD_PARTY_NOTICES.md](../upstream/THIRD_PARTY_NOTICES.md).
