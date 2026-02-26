# 🏯 三國 Kiro CLI Agent System

12 個三國將領 AI agent，為 [Kiro CLI](https://kiro.dev) 打造的多角色開發系統。

靈感來自 [everything-claude-code](https://github.com/affaan-m/everything-claude-code) 的最佳實踐，針對 Kiro CLI 架構重新設計，嚴格控制 token 預算。

## 特色

- 🎭 **12 個專業角色** — 從策劃到部署，每個將領各司其職
- 🧠 **Token 精算** — Steering < 2.5KB（永遠載入），Skills < 1.2KB each（按需載入）
- 🔄 **4 種工作流** — feature / bugfix / refactor / security，一句話觸發
- 🪝 **自動化 Hooks** — 實作完提醒驗證、部署前提醒 dry-run、審查前提醒讀 diff
- 📋 **10 個 Skills** — TDD、驗證管線、安全審計、重構清理等，自動匹配啟用

## 安裝

```bash
git clone https://github.com/anthropic-frank/three-kingdoms-kiro.git
cd three-kingdoms-kiro
./install.sh
```

安裝腳本會將 agents、steering、skills 複製到 `~/.kiro/`。已存在的同名檔案會自動備份（`.bak`）。

### 移除

```bash
./uninstall.sh
```

## 將領一覽

| 中文 | Agent | 職責 | Hooks |
|------|-------|------|-------|
| 諸葛亮 / 軍師 | `zhuge` | 策劃全局、需求分析、分工調度 | stop |
| 趙雲 / 子龍 | `zhaoyun` | 核心程式碼實作 | postToolUse, stop |
| 關羽 / 雲長 | `guanyu` | Staff-level Code Review | agentSpawn |
| 張飛 / 翼德 | `zhangfei` | Bug 獵殺、壓力測試 | preToolUse |
| 周瑜 / 公瑾 | `zhouyu` | UI/UX 工程 | postToolUse |
| 小喬 | `xiaoqiao` | 視覺 / 文案 / 微互動 | postToolUse |
| 曹操 | `caocao` | 自動化 / 部署 / CI-CD | preToolUse |
| 龐統 / 鳳雛 | `pangtong` | 架構審計、依賴邊界檢查 | — |
| 郭嘉 / 奉孝 | `guojia` | 研究 / 模型 / 演算法 | — |
| 荀彧 / 令君 | `xunyu` | 任務整合 / 最小切片落地 | — |
| 黃忠 / 老將 | `huangzhong` | Staff Review 獨立把關 | agentSpawn |
| 魯肅 | `lusu` | UX 流程 / 資訊架構 | postToolUse |

## 使用方式

### 觸發完整工作流

```
你：眾將聽令，我要做一個用戶認證功能
```

諸葛亮會自動按 **feature 工作流** 分工：

```
諸葛亮策劃 → 郭嘉研究 → 龐統審計 → 荀彧分任務
→ 趙雲+周瑜實作（TDD）→ 關羽+黃忠審查 → 曹操部署
```

### 呼叫特定將領

```
你：叫趙雲來實作這個 API
你：讓關羽 review 一下
你：張飛去獵殺這個 bug
```

### 4 種工作流模板

| 場景 | 流程 |
|------|------|
| **新功能** | 諸葛亮 → 郭嘉 → 龐統 → 荀彧 → 趙雲+周瑜(TDD) → 關羽+黃忠 → 曹操 |
| **修 Bug** | 諸葛亮 → 張飛 → 趙雲(TDD) → 關羽 |
| **重構** | 龐統 → 諸葛亮 → 趙雲 → 關羽+黃忠 |
| **安全審查** | 黃忠+關羽 → 龐統 → 趙雲 |

### Skills 自動啟用

提到相關關鍵字時，對應 skill 會自動載入：

| 關鍵字 | Skill |
|--------|-------|
| 驗證、PR 前檢查 | `verify-pipeline` |
| TDD、先寫測試 | `tdd-flow` |
| 安全、secrets、注入 | `security-audit` |
| 有沒有現成的、先搜尋 | `search-before-code` |
| 清理、dead code | `refactor-clean` |
| 部署、CI/CD | `deploy-checklist` |
| PRD、需求文件 | `prd-template` |
| 架構設計 | `design-template` |
| 任務分解 | `task-template` |
| Code Review 報告 | `review-template` |

## 架構

```
~/.kiro/
├── steering/                    # 永遠載入（< 2.5KB total）
│   ├── three-kingdoms.md        #   將領呼叫指令表
│   └── dev-standards.md         #   開發標準 + 工作流模板
├── skills/                      # 按需載入（每個 < 1.2KB）
│   ├── verify-pipeline/         #   build→type→lint→test→security
│   ├── tdd-flow/                #   RED→GREEN→REFACTOR
│   ├── security-audit/          #   安全檢查清單
│   ├── search-before-code/      #   先搜後寫
│   ├── refactor-clean/          #   dead code 清理
│   ├── deploy-checklist/        #   部署檢查清單
│   ├── prd-template/            #   PRD 格式模板
│   ├── design-template/         #   架構設計模板
│   ├── task-template/           #   任務清單模板
│   └── review-template/         #   Review 報告模板
└── agents/                      # 12 個三國將領
    ├── zhuge.json               #   諸葛亮 — 總調度
    ├── zhaoyun.json             #   趙雲 — 核心實作
    ├── guanyu.json              #   關羽 — Code Review
    └── ...                      #   （共 12 個）
```

### Token 預算設計

| 層級 | 大小 | 載入時機 | 說明 |
|------|------|---------|------|
| Steering | ~2.3KB | 每次對話 | 極精簡，只放核心標準 |
| Skills | ~1KB each | 按需匹配 | Progressive disclosure |
| Agent prompt | ~0.6KB each | 呼叫時 | 只載入被呼叫的 agent |
| Hooks | 0 | 不佔 context | Shell echo 命令 |

## 致謝

- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — Skills、Hooks、工作流的靈感來源
- [Kiro CLI](https://kiro.dev) — Agent 平台

## License

MIT
