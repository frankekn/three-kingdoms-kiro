# Three Kingdoms Agent System

A multi-agent development system themed after the Three Kingdoms era, with 12 specialized AI agents for software development workflows.

Supports both **Kiro CLI** and **Claude Code**.

[Traditional Chinese / 繁體中文](docs/README.zh-TW.md)

---

## Platforms

| Feature | Kiro CLI | Claude Code |
|---------|----------|-------------|
| Agents | 12 JSON files | 12 Markdown files |
| Steering / Memory | `steering/*.md` (always-on) | `CLAUDE.md` (always-on) |
| Skills | 10 skill directories | 10 skill directories |
| Subagent tool | `use_subagent` | `Task` |
| Install path | `~/.kiro/` | `~/.claude/` |

---

## Install

```bash
git clone https://github.com/frankekn/three-kingdoms-kiro.git
cd three-kingdoms-kiro
./install.sh
```

Interactive menu lets you choose:
- [1] Kiro CLI only
- [2] Claude Code only
- [3] Both

Or use CLI flags:

```bash
./install.sh --kiro          # Kiro CLI only
./install.sh --claude-code   # Claude Code only
./install.sh --both          # Both platforms
```

## Uninstall

```bash
./uninstall.sh               # Interactive menu
./uninstall.sh --both        # Remove from both platforms
```

---

## Agents

| Chinese | Agent Name | Role |
|---------|-----------|------|
| Zhuge Liang / 諸葛亮 | zhuge | Strategy, orchestration, task delegation |
| Zhao Yun / 趙雲 | zhaoyun | Core code implementation |
| Guan Yu / 關羽 | guanyu | Staff-level code review |
| Zhang Fei / 張飛 | zhangfei | Bug hunting, stress testing |
| Zhou Yu / 周瑜 | zhouyu | UI/UX engineering |
| Xiao Qiao / 小喬 | xiaoqiao | Visual design, copy, micro-interactions |
| Cao Cao / 曹操 | caocao | CI/CD, automation, deployment |
| Pang Tong / 龐統 | pangtong | Architecture audit |
| Guo Jia / 郭嘉 | guojia | Research, algorithms, models |
| Xun Yu / 荀彧 | xunyu | Task integration, breakdown |
| Huang Zhong / 黃忠 | huangzhong | Staff review gatekeeper |
| Lu Su / 魯肅 | lusu | UX flow, information architecture |

---

## Workflows

### Feature
Zhuge Liang plans -> Guo Jia researches -> Pang Tong audits -> Xun Yu breaks down tasks -> Zhao Yun + Zhou Yu implement (TDD) -> Guan Yu + Huang Zhong review -> Cao Cao deploys

### Bugfix
Zhuge Liang locates -> Zhang Fei hunts -> Zhao Yun fixes (TDD) -> Guan Yu reviews

### Refactor
Pang Tong audits architecture -> Zhuge Liang plans -> Zhao Yun refactors -> Guan Yu + Huang Zhong review

### Security
Huang Zhong + Guan Yu review -> Pang Tong audits architecture -> Zhao Yun fixes

---

## Skills

| Skill | Description |
|-------|-------------|
| verify-pipeline | Build, type check, lint, test, security scan |
| tdd-flow | Test-driven development workflow |
| security-audit | Security review checklist |
| search-before-code | Search existing solutions before writing new code |
| refactor-clean | Dead code removal, dependency cleanup |
| deploy-checklist | Deployment verification checklist |
| prd-template | Product requirements document template |
| design-template | System design document template |
| task-template | Task breakdown template |
| review-template | Code review report template |

---

## Handoff Protocol

When agents are chained in a workflow, each agent ends its response with a structured handoff block. This keeps inter-agent context compact and prevents context window overflow.

```
---HANDOFF---
outcome: [one sentence summary]
files_changed: [file paths, max 10]
decisions: [max 3 bullets]
risks: [max 2 bullets]
next: [what the next agent should focus on]
---END---
```

Rules:
- Handoff must be under 200 words
- Code belongs in files, not in the handoff
- Zhuge Liang (orchestrator) extracts only the handoff block when relaying context to the next agent
- When more than 5 handoffs accumulate, only the first and last 3 are kept

---

## Hooks

Automated checks on agent lifecycle events. No context window cost.

| Agent | Event | Action |
|-------|-------|--------|
| Zhao Yun | stop | Verify pipeline reminder |
| Guan Yu | agentSpawn | Read diff first |
| Zhang Fei | preToolUse (shell) | Caution before destructive commands |
| Cao Cao | preToolUse (shell) | Dry-run reminder |
| Zhuge Liang | stop | Progress check |

---

## Repo Structure

```
three-kingdoms-kiro/
  kiro/                      # Kiro CLI files
    agents/*.json            # 12 agent definitions
    steering/*.md            # Always-on context
    skills/*/SKILL.md        # 10 reusable skills
  claude-code/               # Claude Code files
    agents/*.md              # 12 agent definitions
    CLAUDE.md                # Always-on context
    skills/*/SKILL.md        # 10 reusable skills
  install.sh                 # Interactive installer
  uninstall.sh               # Interactive uninstaller
```

---

## License

MIT
