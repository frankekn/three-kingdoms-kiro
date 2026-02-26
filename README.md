# Three Kingdoms Kiro CLI Agent System

[繁體中文說明](docs/README.zh-TW.md)

A multi-agent development system for [Kiro CLI](https://kiro.dev), inspired by the Three Kingdoms era. 12 specialized AI agents collaborate through structured workflows — from planning to deployment.

Design principles from [everything-claude-code](https://github.com/affaan-m/everything-claude-code), re-engineered for Kiro CLI's architecture with strict token budget control.

---

## Install

```bash
git clone https://github.com/frankekn/three-kingdoms-kiro.git
cd three-kingdoms-kiro
./install.sh
```

Copies agents, steering, and skills into `~/.kiro/`. Existing files are backed up automatically (`.bak`).

### Uninstall

```bash
./uninstall.sh
```

Removes only Three Kingdoms files. Your other Kiro settings are untouched.

---

## Agents

| Name | Agent | Role | Hooks |
|------|-------|------|-------|
| Zhuge Liang | `zhuge` | Strategy and orchestration | stop |
| Zhao Yun | `zhaoyun` | Core implementation | postToolUse, stop |
| Guan Yu | `guanyu` | Staff-level code review | agentSpawn |
| Zhang Fei | `zhangfei` | Bug hunting and stress testing | preToolUse |
| Zhou Yu | `zhouyu` | UI/UX engineering | postToolUse |
| Xiao Qiao | `xiaoqiao` | Visual, copy, micro-interaction | postToolUse |
| Cao Cao | `caocao` | Automation, CI/CD, deploy | preToolUse |
| Pang Tong | `pangtong` | Architecture audit | — |
| Guo Jia | `guojia` | Research, models, algorithms | — |
| Xun Yu | `xunyu` | Task integration and delivery | — |
| Huang Zhong | `huangzhong` | Independent staff review | agentSpawn |
| Lu Su | `lusu` | UX flow, information architecture | postToolUse |

---

## Usage

### Full workflow

Say "Assemble the generals" or the Chinese equivalent to trigger the full pipeline:

```
Zhuge Liang (plan) --> Guo Jia (research) --> Pang Tong (audit)
--> Xun Yu (task breakdown) --> Zhao Yun + Zhou Yu (implement with TDD)
--> Guan Yu + Huang Zhong (review) --> Cao Cao (deploy)
```

### Call a specific agent

```
Get Zhao Yun to implement this API
Have Guan Yu review this
Send Zhang Fei to hunt this bug
```

### Workflow templates

| Scenario | Pipeline |
|----------|----------|
| Feature | Zhuge --> Guo Jia --> Pang Tong --> Xun Yu --> Zhao Yun+Zhou Yu (TDD) --> Guan Yu+Huang Zhong --> Cao Cao |
| Bugfix | Zhuge --> Zhang Fei --> Zhao Yun (TDD) --> Guan Yu |
| Refactor | Pang Tong --> Zhuge --> Zhao Yun --> Guan Yu+Huang Zhong |
| Security | Huang Zhong+Guan Yu --> Pang Tong --> Zhao Yun |

---

## Skills

Skills activate automatically when your request matches their description. You can also invoke them manually with `/`.

| Skill | Trigger keywords | Source |
|-------|-----------------|--------|
| `verify-pipeline` | verify, pre-PR check | ECC verification-loop |
| `tdd-flow` | TDD, write tests first | ECC tdd-workflow |
| `security-audit` | security, secrets, injection | ECC security-review |
| `search-before-code` | existing solution, search first | ECC search-first |
| `refactor-clean` | cleanup, dead code | ECC refactor-clean |
| `deploy-checklist` | deploy, CI/CD | ECC deployment-patterns |
| `prd-template` | PRD, requirements | — |
| `design-template` | architecture, design doc | — |
| `task-template` | task breakdown | — |
| `review-template` | code review report | — |

---

## Architecture

```
~/.kiro/
  steering/                      # Always loaded (< 2.5KB total)
    three-kingdoms.md            #   Agent dispatch table
    dev-standards.md             #   Dev standards + workflow templates
  skills/                        # Loaded on demand (< 1.2KB each)
    verify-pipeline/             #   build > type > lint > test > security
    tdd-flow/                    #   RED > GREEN > REFACTOR
    security-audit/              #   Security checklist
    search-before-code/          #   Research before coding
    refactor-clean/              #   Dead code removal
    deploy-checklist/            #   CI/CD checklist
    prd-template/                #   PRD format
    design-template/             #   Architecture doc format
    task-template/               #   Task list format
    review-template/             #   Review report format
  agents/                        # 12 Three Kingdoms agents
    zhuge.json
    zhaoyun.json
    ...
```

### Token budget

| Layer | Size | When loaded |
|-------|------|-------------|
| Steering | ~2.3KB | Every conversation |
| Skills | ~1KB each | On match |
| Agent prompt | ~0.6KB each | On invocation |
| Hooks | 0 | Shell commands, no context cost |

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

| Agent | Event | Behavior |
|-------|-------|----------|
| Zhao Yun | `stop` | Reminds to run verify pipeline |
| Zhao Yun | `postToolUse` | UX-Guard check after file write |
| Guan Yu | `agentSpawn` | Reminds to read git diff first |
| Zhang Fei | `preToolUse` | Caution before bash execution |
| Cao Cao | `preToolUse` | Reminds dry-run before deploy |
| Zhuge Liang | `stop` | Progress check reminder |
| Huang Zhong | `agentSpawn` | Review reminder on spawn |

---

## Credits

- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — Workflow and skill design inspiration
- [Kiro CLI](https://kiro.dev) — Agent platform

## License

MIT
