---
name: refactor-clean
description: 重構清理。移除 dead code、清理未使用的 exports/dependencies 時使用。
---

# 重構清理

## 步驟

### 1. 偵測 Dead Code
```bash
npx knip          # JS/TS unused exports/files/deps
npx depcheck      # unused npm deps
```
找不到工具時用 grep 搜尋 exports 有無被 import。

### 2. 分級
| 級別 | 範例 | 處理 |
|------|------|------|
| **SAFE** | 未使用的 utility、test helper | 直接刪 |
| **CAUTION** | component、API route、middleware | 先確認無動態 import |
| **DANGER** | config、entry point、type def | 調查後再動 |

### 3. 逐一刪除（每次一個）
1. 跑全部測試 → 確認 baseline 全綠
2. 刪除一個 dead code
3. 重跑測試 → 通過就繼續，失敗就 `git checkout -- <file>`

### 4. 合併重複
- 相似度 >80% 的函式 → 合併
- 無用的 re-export → 移除
- 只是 wrapper 沒加值 → inline

## 原則
- 一次刪一個，不確定就跳過
- 清理和重構分開做
