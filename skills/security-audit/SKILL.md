---
name: security-audit
description: 安全審計。處理認證、用戶輸入、API、secrets、敏感資料時使用。
---

# 安全審計清單

## 必查項目

### Secrets
- [ ] 無硬編碼 API keys / passwords / tokens
- [ ] secrets 用環境變數或 secret manager
- [ ] 啟動時驗證必要 secrets 存在

### 注入防護
- [ ] SQL：使用 parameterized queries
- [ ] XSS：sanitize HTML output
- [ ] Command injection：不拼接用戶輸入到 shell
- [ ] Path traversal：驗證檔案路徑

### 認證授權
- [ ] 所有端點有 auth 檢查
- [ ] CSRF protection 啟用
- [ ] Rate limiting 設定

### 資料保護
- [ ] 錯誤訊息不洩漏內部資訊
- [ ] 日誌不記錄敏感資料
- [ ] 傳輸加密（HTTPS）

## 發現問題時
1. **立即停止**開發
2. 修復 CRITICAL 問題
3. 輪換已暴露的 secrets
4. 搜尋 codebase 是否有類似問題
