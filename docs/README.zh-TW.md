# 三國 Kiro CLI Agent 系統

[English](../README.md)

為 [Kiro CLI](https://kiro.dev) 打造的多角色開發系統，以三國為主題。12 個專業 AI agent 透過結構化工作流協作，從策劃到部署一條龍。

設計靈感來自 [everything-claude-code](https://github.com/affaan-m/everything-claude-code)，針對 Kiro CLI 架構重新設計，嚴格控制 token 預算。

---

## 安裝

```bash
git clone https://github.com/frankekn/three-kingdoms-kiro.git
cd three-kingdoms-kiro
./install.sh
```

將 agents、steering、skills 複製到 `~/.kiro/`。已存在的同名檔案會自動備份（`.bak`）。

### 移除

```bash
./uninstall.sh
```

只移除三國系統的檔案，不影響其他 Kiro 設定。

---

## 將領

| 名稱 | Agent | 職責 | Hooks |
|------|-------|------|-------|
| 諸葛亮 / 軍師 | `zhuge` | 策劃全局、需求分析、分工調度 | stop |
| 趙雲 / 子龍 | `zhaoyun` | 核心程式碼實作 | postToolUse, stop |
| 關羽 / 雲長 | `guanyu` | Staff 級 Code Review | agentSpawn |
| 張飛 / 翼德 | `zhangfei` | Bug 獵殺、壓力測試 | preToolUse |
| 周瑜 / 公瑾 | `zhouyu` | UI/UX 前端體驗工程 | postToolUse |
| 小喬 | `xiaoqiao` | 視覺 / 文案 / 微互動 | postToolUse |
| 曹操 | `caocao` | 自動化 / CI-CD / 部署 | preToolUse |
| 龐統 / 鳳雛 | `pangtong` | 架構審計、依賴邊界檢查 | — |
| 郭嘉 / 奉孝 | `guojia` | 研究 / 模型 / 演算法 | — |
| 荀彧 / 令君 | `xunyu` | 任務整合 / 最小切片落地 | — |
| 黃忠 / 老將 | `huangzhong` | Staff Review 獨立把關 | agentSpawn |
| 魯肅 | `lusu` | UX 流程 / 資訊架構 | postToolUse |

---

## 使用方式

### 觸發完整工作流

```
你：眾將聽令，我要做一個用戶認證功能
```

諸葛亮會自動按 feature 工作流分工：

```
諸葛亮（策劃）--> 郭嘉（研究）--> 龐統（審計）
--> 荀彧（分任務）--> 趙雲+周瑜（TDD 實作）
--> 關羽+黃忠（審查）--> 曹操（部署）
```

### 呼叫特定將領

```
你：叫趙雲來實作這個 API
你：讓關羽 review 一下
你：張飛去獵殺這個 bug
```

### 工作流模板

| 場景 | 流程 |
|------|------|
| 新功能 | 諸葛亮 --> 郭嘉 --> 龐統 --> 荀彧 --> 趙雲+周瑜（TDD）--> 關羽+黃忠 --> 曹操 |
| 修 Bug | 諸葛亮 --> 張飛 --> 趙雲（TDD）--> 關羽 |
| 重構 | 龐統 --> 諸葛亮 --> 趙雲 --> 關羽+黃忠 |
| 安全審查 | 黃忠+關羽 --> 龐統 --> 趙雲 |

---

## Skills

Skills 會在請求匹配 description 時自動啟用，也可以用 `/` 手動觸發。

| Skill | 觸發關鍵字 | 來源 |
|-------|-----------|------|
| `verify-pipeline` | 驗證、PR 前檢查 | ECC verification-loop |
| `tdd-flow` | TDD、先寫測試 | ECC tdd-workflow |
| `security-audit` | 安全、secrets、注入 | ECC security-review |
| `search-before-code` | 有沒有現成的、先搜尋 | ECC search-first |
| `refactor-clean` | 清理、dead code | ECC refactor-clean |
| `deploy-checklist` | 部署、CI/CD | ECC deployment-patterns |
| `prd-template` | PRD、需求文件 | — |
| `design-template` | 架構設計 | — |
| `task-template` | 任務分解 | — |
| `review-template` | Code Review 報告 | — |

---

## 架構

```
~/.kiro/
  steering/                      # 永遠載入（< 2.5KB）
    three-kingdoms.md            #   將領呼叫指令表
    dev-standards.md             #   開發標準 + 工作流模板
  skills/                        # 按需載入（每個 < 1.2KB）
    verify-pipeline/             #   build > type > lint > test > security
    tdd-flow/                    #   RED > GREEN > REFACTOR
    security-audit/              #   安全檢查清單
    search-before-code/          #   先搜後寫
    refactor-clean/              #   Dead code 清理
    deploy-checklist/            #   CI/CD 檢查清單
    prd-template/                #   PRD 格式模板
    design-template/             #   架構設計模板
    task-template/               #   任務清單模板
    review-template/             #   Review 報告模板
  agents/                        # 12 個三國將領
    zhuge.json
    zhaoyun.json
    ...
```

### Token 預算

| 層級 | 大小 | 載入時機 |
|------|------|---------|
| Steering | ~2.3KB | 每次對話 |
| Skills | 每個 ~1KB | 匹配時 |
| Agent prompt | 每個 ~0.6KB | 呼叫時 |
| Hooks | 0 | Shell 命令，不佔 context |

---

## Handoff Protocol（交接協議）

當將領串接執行工作流時，每個 agent 完成任務後會以結構化格式回傳摘要，避免 context 爆炸。

```
---HANDOFF---
outcome: [一句話總結]
files_changed: [變更檔案路徑，最多 10 個]
decisions: [關鍵技術決策，最多 3 點]
risks: [風險或缺口，最多 2 點]
next: [下一個 agent 應關注什麼]
---END---
```

規則：
- 交接摘要不超過 200 字
- 程式碼寫進檔案，不放在交接摘要裡
- 諸葛亮（調度者）只擷取 handoff 區塊傳給下一個 agent
- 累積超過 5 個 handoff 時，只保留第一個和最近 3 個

---

## Hooks

在 agent 生命週期事件中自動觸發的檢查，不佔 context。

| 將領 | 事件 | 行為 |
|------|------|------|
| 趙雲 | `stop` | 提醒跑驗證管線 |
| 趙雲 | `postToolUse` | 寫檔後 UX-Guard 檢查 |
| 關羽 | `agentSpawn` | 提醒先讀 git diff |
| 張飛 | `preToolUse` | 執行命令前提醒三思 |
| 曹操 | `preToolUse` | 部署前提醒 dry-run |
| 諸葛亮 | `stop` | 進度檢查提醒 |
| 黃忠 | `agentSpawn` | 啟動時審查提醒 |

---

## 致謝

- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — 工作流與 skill 設計靈感
- [Kiro CLI](https://kiro.dev) — Agent 平台

## 授權

MIT
