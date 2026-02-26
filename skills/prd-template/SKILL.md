---
name: prd-template
description: PRD 產品需求文件格式模板。當需要撰寫 PRD、產品需求、用戶故事、競品分析時使用。
---

# PRD 輸出格式

## 結構

1. **產品概述** — 一段話描述產品目標
2. **目標用戶** — 用戶角色與痛點
3. **用戶故事**（EARS 格式）
   ```
   WHEN [condition/event]
   THE SYSTEM SHALL [expected behavior]
   ```
4. **驗收標準** — 每個用戶故事的可測試條件
5. **非功能需求** — 效能、安全、可用性
6. **競品分析**（如適用）
7. **優先級排序** — P0/P1/P2
8. **風險與假設**

## 範例

### 用戶故事
```
US-001: 用戶登入
WHEN a registered user submits valid credentials
THE SYSTEM SHALL authenticate the user and redirect to dashboard within 2 seconds

驗收標準:
- [ ] 支援 email + password 登入
- [ ] 錯誤時顯示明確錯誤訊息
- [ ] 連續 5 次失敗鎖定帳號 15 分鐘
```
