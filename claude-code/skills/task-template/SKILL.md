---
name: task-template
description: "任務清單格式模板。當需要分解任務、排定開發順序、建立 task list 時使用。"
---

# 任務清單輸出格式

## 結構

每個任務包含：
- **ID** — TASK-001 格式
- **標題** — 一句話描述
- **依賴** — 前置任務 ID
- **負責人** — 對應的三國 agent
- **預估** — 時間估算
- **驗收** — 完成條件

## 範例

```markdown
## TASK-001: 建立資料庫 schema
- 依賴: 無
- 負責人: 趙雲 (zhaoyun)
- 預估: 1h
- 驗收: migration 可執行，表結構符合 design.md
- [ ] 建立 users 表
- [ ] 建立 sessions 表
- [ ] 撰寫 migration script

## TASK-002: 實作登入 API
- 依賴: TASK-001
- 負責人: 趙雲 (zhaoyun)
- 預估: 2h
- 驗收: POST /login 回傳 JWT，錯誤回傳 401
- [ ] 實作 auth.controller
- [ ] 實作 auth.service
- [ ] 單元測試
```
