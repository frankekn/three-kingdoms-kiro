---
name: verify-pipeline
description: "驗證管線。完成功能、提交 PR 前、重構後使用。執行 build→type→lint→test→security 檢查。"
---

# 驗證管線

依序執行六步驗證，任一步失敗即停止修復：

## 1. Build
```bash
npm run build 2>&1 | tail -20   # 或 pnpm build
```

## 2. Type Check
```bash
npx tsc --noEmit 2>&1 | head -30   # TS
pyright . 2>&1 | head -30          # Python
```

## 3. Lint
```bash
npm run lint 2>&1 | head -30
```

## 4. Test（目標 80%+）
```bash
npm run test -- --coverage 2>&1 | tail -50
```

## 5. Security Scan
```bash
grep -rn "sk-\|api_key\|password" --include="*.ts" --include="*.js" src/ 2>/dev/null | head -10
grep -rn "console.log" --include="*.ts" --include="*.tsx" src/ 2>/dev/null | head -10
```

## 6. Git Status
```bash
git diff --stat
```

## 輸出格式
```
VERIFICATION: [PASS/FAIL]
Build:    [OK/FAIL]
Types:    [OK/X errors]
Lint:     [OK/X issues]
Tests:    [X/Y passed, Z% coverage]
Security: [OK/X issues]
Ready for PR: [YES/NO]
```
