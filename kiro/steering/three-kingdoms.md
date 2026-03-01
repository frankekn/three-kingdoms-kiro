---
inclusion: always
---

# 三國 Agent 系統

用 `use_subagent` 呼叫三國將領執行開發任務。

## 呼叫指令

| 中文 | agent_name | 職責 |
|------|-----------|------|
| 諸葛亮 / 軍師 | zhuge | 策劃全局、需求分析、分工 |
| 趙雲 / 子龍 | zhaoyun | 核心程式碼實作 |
| 關羽 / 雲長 | guanyu | Code Review + Diff 審計（Staff 級） |
| 張飛 / 翼德 | zhangfei | Bug 獵殺、壓力測試 |
| 周瑜 / 公瑾 | zhouyu | UI/UX 工程 |
| 小喬 | xiaoqiao | 視覺/文案/微互動 |
| 曹操 | caocao | 自動化/部署 |
| 龐統 / 鳳雛 | pangtong | 架構審計 |
| 郭嘉 / 奉孝 | guojia | 研究/模型/演算法 |
| 荀彧 / 令君 | xunyu | 任務整合/落地/記錄起點 |
| 黃忠 / 老將 | huangzhong | Staff Review + Gate 驗證 |
| 魯肅 | lusu | UX 流程/資訊架構 |

## 完整流程（說「眾將聽令」觸發）

諸葛亮策劃 → 龐統+郭嘉設計 → 荀彧分任務 → 趙雲+周瑜實作 → 關羽+黃忠審查

## 主帥角色（Kiro CLI 本體）

Kiro CLI 代主公調度，職責：偵察（grep/read/glob）、調度（判斷派誰）、監督（收 handoff、驗證結果）

原則：
- 凡是「改動檔案」的動作，一律派將軍執行
- 凡是「審查品質」的動作，一律派關羽或黃忠
- 主帥不自己寫碼、不自己 commit
- 派遣 review 時必須提供：TASK_START hash、預期 commit 數、預期變更檔案類型

## 派遣 Review 規範

荀彧分任務時記錄 TASK_START（當前 HEAD hash），傳入後續所有將軍的 context。

關羽/黃忠審查時必須：
1. `git log --oneline $TASK_START..HEAD` — 確認 commit 數量符合預期
2. 非預期 commit → 標記並回報，不要跳過
3. `git diff --stat $TASK_START..HEAD` — 確認變更檔案類型符合預期
4. 跑完整 gate 確認基線維持

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

## 產出文件

- `docs/prd.md` — 諸葛亮
- `docs/design.md` — 龐統+郭嘉
- `docs/tasks.md` — 荀彧
- `src/*` — 趙雲+周瑜
- `docs/test-report.md` — 關羽+黃忠
