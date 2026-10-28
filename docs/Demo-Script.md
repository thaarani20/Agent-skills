# Demo Script: Skills and MCP in Cursor (about 10 minutes)

## Before the session
- Clone this repo and open it in Cursor.
- Run `node -v`; the Playwright MCP server needs Node 18 or later.
- Optional: set `GITHUB_PERSONAL_ACCESS_TOKEN` for the GitHub MCP server.
- Keep a sample PDF and a small web page or URL ready.

## Part 1: Skills (5 minutes)
1. **Show the files.** Open `.cursor/skills/pdf/SKILL.md` and point out the frontmatter (`name`, `description`), the instructions, and the bundled `scripts/`.
2. **Show Settings.** Open Cursor Settings > Rules, Skills, Subagents. Point out the project skills from this repo, your user skills (`~/.cursor/skills`) and the built-in skills.
3. **Call a skill by name.** In Agent chat, type `/pdf` and ask "extract the text from sample.pdf".
4. **Let Cursor pick a skill.** Without `/`, ask "Create a 3-slide deck about agent skills". The agent should load the `pptx` skill because the request matches its description.
5. **Create a skill live (optional).** Ask "Create a skill that writes standup notes"; the built-in `create-skill` skill runs. Show the new folder.

## Part 2: MCP (4 minutes)
1. Open Cursor Settings > Tools & MCP. Show `.cursor/mcp.json` from this repo.
2. Turn on **playwright** and wait for the green dot. Expand it to show its tools (`browser_navigate`, `browser_take_screenshot` and others).
3. In Agent chat, ask "Open https://example.com and take a screenshot". Approve the tool call and show the result.
4. Combine the two: "Use the webapp-testing skill to check example.com loads and its heading is visible". The skill provides the procedure and MCP provides the actions.

## Wrap-up (1 minute)
- A skill is expertise: how to do the work, loaded on demand.
- MCP provides tools: the actions the agent can take.
- Both are plain files in git, so they can be reviewed, shared and versioned.

## Backup plan
- If MCP fails to start, run `npx @playwright/mcp@latest` in a terminal to see the error, or show screenshots of a working run.
- If the agent doesn't pick the skill, call it explicitly with `/`.
