---
inclusion: always
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

## Diff 審計（推送前）
- 推送前：`git log --oneline $TASK_START..HEAD` 確認 commit 清單符合預期
- 非預期 commit → 跑 gate 確認基線 → 標記來源 → 決定是否一起推

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
commits: [hash + 簡述, max 5]
decisions: [max 3 bullets]
risks: [max 2 bullets]
next: [what next agent should focus on]
---END---

Rules:
- Keep handoff under 200 words
- Code belongs in files, not in handoff
- If no files changed, state what was analyzed or decided
