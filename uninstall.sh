#!/usr/bin/env bash
set -euo pipefail

KIRO_DIR="${HOME}/.kiro"
ITEMS=(
  "agents/caocao.json" "agents/guanyu.json" "agents/guojia.json"
  "agents/huangzhong.json" "agents/lusu.json" "agents/pangtong.json"
  "agents/xiaoqiao.json" "agents/xunyu.json" "agents/zhangfei.json"
  "agents/zhaoyun.json" "agents/zhouyu.json" "agents/zhuge.json"
  "steering/three-kingdoms.md" "steering/dev-standards.md"
  "skills/verify-pipeline" "skills/tdd-flow" "skills/security-audit"
  "skills/search-before-code" "skills/refactor-clean" "skills/deploy-checklist"
  "skills/prd-template" "skills/design-template" "skills/task-template"
  "skills/review-template"
)

echo "🗑️  三國 Kiro CLI Agent System — 移除程式"
echo ""

for item in "${ITEMS[@]}"; do
  target="$KIRO_DIR/$item"
  if [ -e "$target" ]; then
    rm -rf "$target"
    echo "  ✅ 已移除: $item"
  fi
done

echo ""
echo "移除完成。你的其他 Kiro 設定不受影響。"
