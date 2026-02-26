---
name: tdd-flow
description: TDD 測試驅動開發。寫新功能、修 bug、重構時使用。先寫測試再寫實作。
---

# TDD 工作流

## 循環：RED → GREEN → REFACTOR

### RED — 先寫失敗的測試
1. 定義 interface / types
2. 寫測試案例（happy path + edge cases + error scenarios）
3. 跑測試，確認**失敗**（且失敗原因正確）

### GREEN — 最小實作讓測試通過
1. 寫剛好能通過測試的程式碼
2. 不多寫，不提前優化
3. 跑測試，確認**全部通過**

### REFACTOR — 改善但不改行為
1. 提取常數、消除重複、改善命名
2. 跑測試，確認**仍然通過**
3. 檢查 coverage ≥ 80%

## 測試類型（全部需要）
- **Unit**：函式、工具、component 邏輯
- **Integration**：API、DB、service 互動
- **E2E**：關鍵用戶流程

## 禁止事項
- ❌ 先寫實作再補測試
- ❌ 跳過 RED 階段
- ❌ 一次寫太多程式碼
- ❌ 修改測試來遷就實作（除非測試本身有錯）
