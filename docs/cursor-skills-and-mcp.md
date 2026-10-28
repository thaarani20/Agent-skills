# Skills and MCP in Cursor

## Skills

**Where Cursor looks for skills**

| Scope | Paths |
| --- | --- |
| Project | `.cursor/skills/`, `.agents/skills/` |
| User | `~/.cursor/skills/`, `~/.agents/skills/` |
| Built-in (do not edit) | `~/.cursor/skills-cursor/` |

**Using skills**
- Cursor chooses a skill automatically when your request matches its `description`.
- Type `/` in Agent chat and pick a skill by name to call it directly.
- To view them, open **Cursor Settings > Rules, Skills, Subagents**.

**Adding a skill**
1. Create `.cursor/skills/<skill-name>/SKILL.md` with `name` and `description` frontmatter.
2. Or copy a folder from this repo or from [anthropics/skills](https://github.com/anthropics/skills).
3. Or ask the agent to use the built-in `create-skill` skill.

## MCP (Model Context Protocol)

An MCP server gives the agent tools such as browser control, GitHub or a database. A skill supplies the procedure for using them.

**Adding a server**
1. Open **Cursor Settings > Tools & MCP > Add Custom MCP**. Cursor opens `mcp.json`.
2. Project config goes in `.cursor/mcp.json`; global config goes in `~/.cursor/mcp.json`.
3. Save the file. The server should show a green dot and a list of its tools. Toggle individual tools on or off as needed.

**Example config** (the same as [.cursor/mcp.json](../.cursor/mcp.json))

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    },
    "github": {
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": { "Authorization": "Bearer ${env:GITHUB_PERSONAL_ACCESS_TOKEN}" }
    }
  }
}
```

**Transports**
- `stdio`: a local process, started with `command` and `args`.
- Streamable HTTP or SSE: a remote server, reached with `url`. Some remote servers use OAuth.

## Skills and MCP together

| | Skill | MCP server |
| --- | --- | --- |
| Provides | Procedure and expertise | Callable tools |
| Format | `SKILL.md` folder | A server process or URL |
| Loaded | On demand, from its description | Tool schemas are always available once enabled |
| Example | `webapp-testing` explains how to test | Playwright MCP clicks and takes screenshots |

Docs: [cursor.com/docs/skills](https://cursor.com/docs/skills), [cursor.com/docs/context/mcp](https://cursor.com/docs/context/mcp)
