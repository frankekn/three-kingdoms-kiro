---
name: deploy-checklist
description: 部署檢查清單。設定 CI/CD、寫部署腳本、環境管理時使用。
---

# 部署檢查清單

## CI/CD Pipeline
- [ ] build → test → lint → security scan → deploy
- [ ] 每個 stage 失敗即停止
- [ ] 環境變數不硬編碼在 pipeline 中

## 腳本要求
- [ ] 有 `--dry-run` 預覽模式
- [ ] 有 `--help` 使用說明
- [ ] 有錯誤處理（非零 exit code）
- [ ] 有日誌輸出（知道做了什麼）
- [ ] 破壞性操作有確認步驟

## 環境管理
- [ ] dev / staging / production 設定分離
- [ ] secrets 不進 git
- [ ] 有 rollback 方案

## 部署前驗證
- [ ] 跑 verify-pipeline（build→test→lint→security）
- [ ] DB migration 有 rollback script
- [ ] 有 health check endpoint
