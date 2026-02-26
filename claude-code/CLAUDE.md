# 三國 Agent 系統

用 `Task tool` 呼叫三國將領執行開發任務。

## 呼叫指令

| 中文 | agent_name | 職責 |
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

## 完整流程（說「眾將聽令」觸發）

諸葛亮策劃 → 龐統+郭嘉設計 → 荀彧分任務 → 趙雲+周瑜實作 → 關羽+黃忠審查

## 產出文件

- `docs/prd.md` — 諸葛亮
- `docs/design.md` — 龐統+郭嘉
- `docs/tasks.md` — 荀彧
- `src/*` — 趙雲+周瑜
- `docs/test-report.md` — 關羽+黃忠

---

# 開發標準

## 程式碼規範
- **不可變性**：建立新物件，不修改既有物件
- **檔案大小**：200-400 行為佳，800 行為上限
- **錯誤處理**：每層都處理，UI 給友善訊息，server 記詳細 log
- **輸入驗證**：系統邊界一律驗證，不信任外部資料
- **禁止硬編碼**：secrets 用環境變數，magic number 用常數
- **函式精簡**：<50 行，巢狀 <4 層

## Git 規範
格式：`<type>: <description>`
類型：feat / fix / refactor / docs / test / chore / perf / ci

## 工作流模板

### 新功能（feature）
諸葛亮策劃 → 郭嘉研究 → 龐統審計 → 荀彧分任務 → 趙雲+周瑜實作（TDD）→ 關羽+黃忠審查 → 曹操部署

### 修 Bug（bugfix）
諸葛亮定位 → 張飛獵殺 → 趙雲修復（TDD）→ 關羽審查

### 重構（refactor）
龐統架構審計 → 諸葛亮策劃 → 趙雲重構 → 關羽+黃忠審查

### 安全審查（security）
黃忠+關羽審查 → 龐統架構審計 → 趙雲修復

### 驗證（任何交付前）
build → type check → lint → test(80%+) → security scan → git status

## Handoff Protocol

When completing a task as subagent, end your response with:

---HANDOFF---
outcome: [one sentence]
files_changed: [file paths, max 10]
decisions: [max 3 bullets]
risks: [max 2 bullets]
next: [what next agent should focus on]
---END---

Rules:
- Keep handoff under 200 words
- Code belongs in files, not in handoff
- If no files changed, state what was analyzed or decided
