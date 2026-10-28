# Agent Skills Quiz: 30 Questions

The quiz has three sections: concepts (questions 1 to 12), the spec and file structure (13 to 20), and scenarios (21 to 30). The answer key is at the end.

## Section A: Concepts

**1. What is an agent skill?**
A) A fine-tuned model
B) Reusable procedural knowledge packaged so an agent can discover and load it when relevant
C) A single API endpoint
D) A vector database

**2. Which statement best describes the difference between tools and skills?**
A) Tools are expertise; skills are verbs
B) Both are the same thing
C) Tools are verbs (actions); skills are expertise (how to use them)
D) Skills replace tools

**3. Which company first introduced Agent Skills and published them as an open standard?**
A) OpenAI  B) Google  C) Anthropic  D) Microsoft

**4. What is the core efficiency pattern of skills called?**
A) Lazy compilation  B) Progressive disclosure  C) Prompt chaining  D) Context caching

**5. Roughly how many tokens does each skill cost when it is only advertised?**
A) About 10  B) About 100  C) About 5,000  D) The whole file

**6. What is the main weakness of RAG compared with skills?**
A) It cannot retrieve facts
B) It is passive and rarely encodes multi-step procedures
C) It requires GPUs
D) It only works offline

**7. Why aren't skills just fine-tuning?**
A) Fine-tuning is cheap
B) Fine-tuning is costly, can drift and is hard to combine; skills are files you can swap
C) Skills change model weights
D) There is no difference

**8. What does an MCP server mainly provide to an agent?**
A) Atomic, callable tools  B) Model weights  C) Full domain playbooks  D) UI themes

**9. What does "composability" mean for skills?**
A) Skills compile to binaries
B) Several skills, such as code review and security review, can be combined without one giant prompt
C) Skills write music
D) Only one skill can ever be active

**10. What is a key security risk of third-party skills?**
A) Slow loading
B) Prompt injection or malicious scripts inside `SKILL.md` or `scripts/`
C) Too few tokens
D) Font licensing

**11. In the skill lifecycle, what comes right after Discovery?**
A) Execution  B) Fallback  C) Matching  D) Deployment

**12. Why do good skills include a "fallback" or "when not to use" section?**
A) To increase the token count
B) So the agent knows when to stop or back out safely and avoids misfiring
C) It is required by law
D) To disable other skills

## Section B: Spec and file structure

**13. Which file is required in every skill?**
A) `README.md`  B) `skill.json`  C) `SKILL.md`  D) `index.py`

**14. Which two frontmatter fields are required?**
A) `name`, `version`  B) `name`, `description`  C) `title`, `author`  D) `description`, `license`

**15. What is the maximum length of `name`?**
A) 32  B) 64  C) 128  D) 1024 characters

**16. What is the maximum length of `description`?**
A) 256  B) 512  C) 1024  D) 4096 characters

**17. Which of these is a valid skill `name`?**
A) `My Skill`  B) `my_skill!`  C) `pdf-form-filler`  D) `PDFFiller`

**18. Which optional folder holds executable helpers?**
A) `assets/`  B) `scripts/`  C) `references/`  D) `bin-skill/`

**19. In Cursor, where do the built-in skills live?**
A) `.cursor/rules/`  B) `~/.cursor/skills-cursor/`  C) `node_modules/`  D) `C:\Program Files\`

**20. What are Microsoft Agent Framework's three skill tools?**
A) `get`, `put`, `delete`
B) `load_skill`, `read_skill_resource`, `run_skill_script`
C) `init`, `train`, `infer`
D) `fetch_skill`, `exec`, `close`

## Section C: Scenarios

**21. Your team repeats a 7-step release checklist that uses two scripts and a policy document. What should you build?**
A) A rule  B) A single MCP tool  C) An agent skill  D) A fine-tuned model

**22. You only need the convention "use 4 spaces in `.py` files". What is the best fit?**
A) A skill with scripts  B) A short Cursor rule (`.mdc`)  C) An MCP server  D) Fine-tuning

**23. You downloaded a skill from an unknown GitHub user, and its script sends data to an unfamiliar URL. What should you do?**
A) Install it globally
B) Review it as a supply-chain or prompt-injection risk before trusting it, and remove or sandbox it
C) Ignore it, since skills are always safe
D) Rename the folder

**24. You want one skill to work in both Cursor and OpenAI Codex. Where should you put it?**
A) `.claude/skills/`  B) `.agents/skills/`  C) `~/.cursor/skills-cursor/`  D) `/tmp`

**25. You wrote a skill, but the agent never uses it on its own. What is the most likely cause?**
A) The folder is too small
B) The `description` doesn't clearly say what the skill does and when to use it
C) Skills only run on Mondays
D) There are too many scripts

**26. Finance needs strictly ordered steps with checkpoints and retries, and no improvisation. What fits best?**
A) An agent skill  B) A deterministic workflow or orchestrator  C) RAG  D) A system prompt

**27. Your `SKILL.md` has grown to 3,000 lines of API detail. How should you fix it?**
A) Leave it as is
B) Keep the core steps in `SKILL.md` and move the details into `references/` to load on demand
C) Delete the details
D) Paste it into every chat

**28. In Cursor, you want to run the `pdf` skill right now without relying on automatic matching. What do you do?**
A) Restart Cursor
B) Type `/pdf` in Agent chat
C) Edit `settings.json`
D) Install Python

**29. The agent needs to click through a web page and take screenshots, following your team's QA steps. What combination should you use?**
A) RAG only
B) The Playwright MCP server for actions, plus a `webapp-testing` skill for the procedure
C) Fine-tuning only
D) A `.mdc` rule only

**30. Your Docx and Xlsx skills both trigger on "make a report with a table". How do you fix it?**
A) Delete one skill
B) Sharpen each description with "use when" and "do NOT use for" lines, based on the expected output file type
C) Rename the folders
D) Increase the `name` length

---

## Answer Key

| Q | Ans | Why |
|---|---|---|
| 1 | B | A skill is packaged procedural knowledge that is loaded on demand. |
| 2 | C | Tools are verbs; skills are expertise. |
| 3 | C | Anthropic published the open standard at agentskills.io. |
| 4 | B | Progressive disclosure: advertise, then load, then read resources, then run scripts. |
| 5 | B | Only the name and description, about 100 tokens. |
| 6 | B | RAG retrieves facts but doesn't encode workflows. |
| 7 | B | Fine-tuning is costly and hard to combine; skills are files. |
| 8 | A | MCP provides callable tools. |
| 9 | B | Several skills can be combined. |
| 10 | B | Malicious instructions or scripts. |
| 11 | C | Discovery, then Matching, Activation, Execution and Fallback. |
| 12 | B | Prevents misfires and allows a safe retreat. |
| 13 | C | `SKILL.md` is the only required file. |
| 14 | B | `name` and `description`. |
| 15 | B | 64 characters. |
| 16 | C | 1024 characters. |
| 17 | C | Lowercase letters, numbers and hyphens only. |
| 18 | B | `scripts/`. |
| 19 | B | `~/.cursor/skills-cursor/`; don't edit them. |
| 20 | B | `load_skill`, `read_skill_resource`, `run_skill_script`. |
| 21 | C | A multi-step procedure with scripts and policy is what skills are for. |
| 22 | B | A single convention needs only a rule. |
| 23 | B | Treat third-party skills like dependencies and review them. |
| 24 | B | `.agents/skills/` is the universal location. |
| 25 | B | Matching depends on the description. |
| 26 | B | Fixed steps with checkpoints call for a workflow. |
| 27 | B | Progressive disclosure through `references/`. |
| 28 | B | `/` calls a skill by name. |
| 29 | B | MCP provides the actions; the skill provides the procedure. |
| 30 | B | Clear scope boundaries in the descriptions, as the upstream docx and xlsx skills do. |
