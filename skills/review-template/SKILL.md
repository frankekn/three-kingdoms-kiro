---
name: review-template
description: Code Review 報告格式模板。當需要進行 code review、PR review、品質審查時使用。
---

# Code Review 報告格式

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
