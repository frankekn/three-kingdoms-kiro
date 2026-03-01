---
name: review-template
description: Code Review 完整 SOP。進行 code review、diff 審計、範圍確認、gate 驗證時使用。
---

# Code Review SOP

## Review 動作清單

### Phase 1: 範圍確認
```bash
git log --oneline $TASK_START..HEAD
```
比對預期 commit 數量，非預期 commit 立即回報。

### Phase 2: 變更審計
```bash
git diff --stat $TASK_START..HEAD
```
確認只有預期類型的檔案被修改（.md / .ts / .py）。

### Phase 3: 行為驗證
- 非文件類變更逐一確認是否改變行為
- 刪除的 code 用 grep 確認 0 imports

### Phase 4: Gate
跑完整測試套件，比對基線數字。

### Phase 5: 產出報告
使用下方輸出結構。

## 輸出結構

```markdown
# Code Review 報告

## 摘要
[一句話總結這次變更]

## 🚫 Blockers（必須修才能 merge）
| # | 檔案:行 | 問題 | 建議修法 |
|---|---------|------|----------|
| 1 | ... | ... | ... |

## ⚠️ Non-blocking（建議修，但不阻擋 merge）
| # | 檔案:行 | 問題 | 建議修法 |
|---|---------|------|----------|
| 1 | ... | ... | ... |

## 風險評估
- **整體風險：** [低/中/高]
- **影響範圍：** [列出受影響的系統/功能]
- **需要額外測試：** [是/否，說明]

## 測試缺口
- [ ] [缺少的測試案例]

## 👍 優點
- [值得稱讚的地方]
```

## 審查清單
- 正確性（邏輯錯誤、邊界案例、null/undefined）
- 跨邊界契約（request/response schema）
- 型別安全（runtime vs types 不符）
- 錯誤處理（失敗模式、retry/backoff）
- 併發（race conditions、resource cleanup）
- 安全（注入、XSS、SSRF、authz）
- 效能（N+1 查詢、unbounded loops）
