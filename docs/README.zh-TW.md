# 三國 Agent 系統

以三國為主題的多 Agent 開發系統，12 位專業 AI 將領協助軟體開發工作流。

同時支援 **Kiro CLI** 與 **Claude Code**。

[English](../README.md)

---

## 平台支援

| 功能 | Kiro CLI | Claude Code |
|------|----------|-------------|
| Agent 格式 | 12 個 JSON 檔 | 12 個 Markdown 檔 |
| 常駐指引 | `steering/*.md` | `CLAUDE.md` |
| 技能 | 10 個技能目錄 | 10 個技能目錄 |
| 子代理工具 | `use_subagent` | `Task` |
| 安裝路徑 | `~/.kiro/` | `~/.claude/` |

---

## 安裝

```bash
git clone https://github.com/frankekn/three-kingdoms-kiro.git
cd three-kingdoms-kiro
./install.sh
```

互動選單讓你選擇：
- [1] 只裝 Kiro CLI
- [2] 只裝 Claude Code
- [3] 兩個都裝

或使用參數：

```bash
./install.sh --kiro          # 只裝 Kiro CLI
./install.sh --claude-code   # 只裝 Claude Code
./install.sh --both          # 兩個都裝
```

## 移除

```bash
./uninstall.sh               # 互動選單
./uninstall.sh --both        # 從兩個平台移除
```

---

## 將領

| 中文 | Agent 名稱 | 職責 |
|------|-----------|------|
| 諸葛亮 / 軍師 | zhuge | 策劃全局、需求分析、分工 |
| 趙雲 / 子龍 | zhaoyun | 核心程式碼實作 |
| 關羽 / 雲長 | guanyu | Code Review（Staff 級） |
| 張飛 / 翼德 | zhangfei | Bug 獵殺、壓力測試 |
| 周瑜 / 公瑾 | zhouyu | UI/UX 工程 |
| 小喬 | xiaoqiao | 視覺/文案/微互動 |
| 曹操 | caocao | 自動化/部署 |
| 龐統 / 鳳雛 | pangtong | 架構審計 |
| 郭嘉 / 奉孝 | guojia | 研究/模型/演算法 |
| 荀彧 / 令君 | xunyu | 任務整合/落地 |
| 黃忠 / 老將 | huangzhong | Staff Review 把關 |
| 魯肅 | lusu | UX 流程/資訊架構 |

---

## 工作流

### 新功能
諸葛亮策劃 -> 郭嘉研究 -> 龐統審計 -> 荀彧分任務 -> 趙雲+周瑜實作（TDD）-> 關羽+黃忠審查 -> 曹操部署

### 修 Bug
諸葛亮定位 -> 張飛獵殺 -> 趙雲修復（TDD）-> 關羽審查

### 重構
龐統架構審計 -> 諸葛亮策劃 -> 趙雲重構 -> 關羽+黃忠審查

### 安全審查
黃忠+關羽審查 -> 龐統架構審計 -> 趙雲修復

---

## 技能

| 技能 | 說明 |
|------|------|
| verify-pipeline | 建置、型別檢查、lint、測試、安全掃描 |
| tdd-flow | 測試驅動開發流程 |
| security-audit | 安全審計檢查清單 |
| search-before-code | 先搜尋現有方案再寫新程式 |
| refactor-clean | 清除死碼、整理依賴 |
| deploy-checklist | 部署驗證清單 |
| prd-template | 產品需求文件模板 |
| design-template | 系統設計文件模板 |
| task-template | 任務分解模板 |
| review-template | Code Review 報告模板 |

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

| Agent | 事件 | 動作 |
|-------|------|------|
| 趙雲 | stop | 驗證管線提醒 |
| 關羽 | agentSpawn | 先讀 diff |
| 張飛 | preToolUse (shell) | 破壞性指令警告 |
| 曹操 | preToolUse (shell) | dry-run 提醒 |
| 諸葛亮 | stop | 進度檢查 |

---

## 授權

MIT

## 目錄結構

```
three-kingdoms-kiro/
  kiro/                      # Kiro CLI 檔案
    agents/*.json            # 12 個 agent 定義
    steering/*.md            # 常駐指引
    skills/*/SKILL.md        # 10 個可重用技能
  claude-code/               # Claude Code 檔案
    agents/*.md              # 12 個 agent 定義
    CLAUDE.md                # 常駐指引
    skills/*/SKILL.md        # 10 個可重用技能
  install.sh                 # 互動式安裝腳本
  uninstall.sh               # 互動式移除腳本
```

