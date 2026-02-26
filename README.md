# Three Kingdoms Kiro CLI Agent System

**三國 Kiro CLI Agent 系統**

A multi-agent development system for [Kiro CLI](https://kiro.dev), inspired by the Three Kingdoms era. 12 specialized AI agents collaborate through structured workflows — from planning to deployment.

為 [Kiro CLI](https://kiro.dev) 打造的多角色開發系統，以三國為主題。12 個專業 AI agent 透過結構化工作流協作，從策劃到部署一條龍。

Design principles from [everything-claude-code](https://github.com/affaan-m/everything-claude-code), re-engineered for Kiro CLI's architecture with strict token budget control.

設計靈感來自 [everything-claude-code](https://github.com/affaan-m/everything-claude-code)，針對 Kiro CLI 架構重新設計，嚴格控制 token 預算。

---

## Install | 安裝

```bash
git clone https://github.com/frankekn/three-kingdoms-kiro.git
cd three-kingdoms-kiro
./install.sh
```

Copies agents, steering, and skills into `~/.kiro/`. Existing files are backed up automatically (`.bak`).

將 agents、steering、skills 複製到 `~/.kiro/`。已存在的同名檔案會自動備份。

### Uninstall | 移除

```bash
./uninstall.sh
```

Removes only Three Kingdoms files. Your other Kiro settings are untouched.

只移除三國系統的檔案，不影響其他 Kiro 設定。

---

## Agents | 將領

| Name 名稱 | Agent | Role 職責 | Hooks |
|-----------|-------|----------|-------|
| Zhuge Liang 諸葛亮 | `zhuge` | Strategy & orchestration 策劃全局、分工調度 | stop |
| Zhao Yun 趙雲 | `zhaoyun` | Core implementation 核心程式碼實作 | postToolUse, stop |
| Guan Yu 關羽 | `guanyu` | Staff-level code review 代碼審查 | agentSpawn |
| Zhang Fei 張飛 | `zhangfei` | Bug hunting & stress testing 獵殺 Bug | preToolUse |
| Zhou Yu 周瑜 | `zhouyu` | UI/UX engineering 前端體驗工程 | postToolUse |
| Xiao Qiao 小喬 | `xiaoqiao` | Visual / copy / micro-interaction 視覺文案 | postToolUse |
| Cao Cao 曹操 | `caocao` | Automation / CI-CD / deploy 自動化部署 | preToolUse |
| Pang Tong 龐統 | `pangtong` | Architecture audit 架構審計 | — |
| Guo Jia 郭嘉 | `guojia` | Research / models / algorithms 研究演算法 | — |
| Xun Yu 荀彧 | `xunyu` | Task integration / delivery 任務整合落地 | — |
| Huang Zhong 黃忠 | `huangzhong` | Independent staff review 獨立審查把關 | agentSpawn |
| Lu Su 魯肅 | `lusu` | UX flow / information architecture UX 流程 | postToolUse |

---

## Usage | 使用方式

### Full workflow | 完整工作流

```
You:  眾將聽令，我要做一個用戶認證功能
You:  Assemble the generals — build a user auth feature
```

Zhuge Liang automatically dispatches agents following the **feature workflow**:

諸葛亮會自動按 feature 工作流分工：

```
Zhuge Liang (plan) --> Guo Jia (research) --> Pang Tong (audit)
--> Xun Yu (task breakdown) --> Zhao Yun + Zhou Yu (implement with TDD)
--> Guan Yu + Huang Zhong (review) --> Cao Cao (deploy)
```

### Call a specific agent | 呼叫特定將領

```
You:  叫趙雲來實作這個 API
You:  Get Zhao Yun to implement this API
You:  讓關羽 review 一下
You:  Have Guan Yu review this
```

### Workflow templates | 工作流模板

| Scenario 場景 | Pipeline 流程 |
|--------------|--------------|
| **Feature** 新功能 | Zhuge --> Guo Jia --> Pang Tong --> Xun Yu --> Zhao Yun+Zhou Yu (TDD) --> Guan Yu+Huang Zhong --> Cao Cao |
| **Bugfix** 修 Bug | Zhuge --> Zhang Fei --> Zhao Yun (TDD) --> Guan Yu |
| **Refactor** 重構 | Pang Tong --> Zhuge --> Zhao Yun --> Guan Yu+Huang Zhong |
| **Security** 安全審查 | Huang Zhong+Guan Yu --> Pang Tong --> Zhao Yun |

---

## Skills

Skills activate automatically when your request matches their description. You can also invoke them manually with `/`.

Skills 會在請求匹配 description 時自動啟用，也可以用 `/` 手動觸發。

| Skill | Trigger keywords 觸發關鍵字 | Source 來源 |
|-------|---------------------------|-----------|
| `verify-pipeline` | verify, pre-PR check 驗證、PR 前檢查 | ECC verification-loop |
| `tdd-flow` | TDD, write tests first 先寫測試 | ECC tdd-workflow |
| `security-audit` | security, secrets, injection 安全、注入 | ECC security-review |
| `search-before-code` | existing solution, search first 先搜後寫 | ECC search-first |
| `refactor-clean` | cleanup, dead code 清理 | ECC refactor-clean |
| `deploy-checklist` | deploy, CI/CD 部署 | ECC deployment-patterns |
| `prd-template` | PRD, requirements 需求文件 | — |
| `design-template` | architecture, design doc 架構設計 | — |
| `task-template` | task breakdown 任務分解 | — |
| `review-template` | code review report 審查報告 | — |

---

## Architecture | 架構

```
~/.kiro/
  steering/                      # Always loaded | 永遠載入 (< 2.5KB total)
    three-kingdoms.md            #   Agent dispatch table | 將領呼叫指令表
    dev-standards.md             #   Dev standards + workflow templates | 開發標準
  skills/                        # Loaded on demand | 按需載入 (< 1.2KB each)
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
  agents/                        # 12 Three Kingdoms agents | 12 個三國將領
    zhuge.json                   #   Zhuge Liang | 諸葛亮
    zhaoyun.json                 #   Zhao Yun | 趙雲
    ...
```

### Token budget | Token 預算

| Layer 層級 | Size 大小 | When loaded 載入時機 |
|-----------|----------|-------------------|
| Steering | ~2.3KB | Every conversation 每次對話 |
| Skills | ~1KB each | On match 匹配時 |
| Agent prompt | ~0.6KB each | On invocation 呼叫時 |
| Hooks | 0 | Shell commands, no context cost 不佔 context |

---

## Hooks

Automated checks that fire on agent lifecycle events. No context window cost.

在 agent 生命週期事件中自動觸發的檢查，不佔 context。

| Agent | Event | Behavior 行為 |
|-------|-------|--------------|
| Zhao Yun 趙雲 | `stop` | Reminds to run verify pipeline 提醒跑驗證管線 |
| Zhao Yun 趙雲 | `postToolUse` | UX-Guard check after file write 寫檔後 UX 檢查 |
| Guan Yu 關羽 | `agentSpawn` | Reminds to read git diff first 提醒先讀 diff |
| Zhang Fei 張飛 | `preToolUse` | Caution before bash execution 執行前提醒三思 |
| Cao Cao 曹操 | `preToolUse` | Reminds dry-run before deploy 部署前提醒 dry-run |
| Zhuge Liang 諸葛亮 | `stop` | Progress check reminder 進度檢查提醒 |
| Huang Zhong 黃忠 | `agentSpawn` | Review reminder on spawn 啟動時審查提醒 |

---

## Credits | 致謝

- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — Workflow and skill design inspiration
- [Kiro CLI](https://kiro.dev) — Agent platform

## License

MIT
