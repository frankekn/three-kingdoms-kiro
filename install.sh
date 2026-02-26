#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
KIRO_DIR="${HOME}/.kiro"

echo "🏯 三國 Kiro CLI Agent System — 安裝程式"
echo "=========================================="
echo ""
echo "來源: ${REPO_DIR}"
echo "目標: ${KIRO_DIR}"
echo ""

# --- helpers ---
backup_if_exists() {
  local target="$1"
  if [ -e "$target" ]; then
    local bak="${target}.bak.$(date +%Y%m%d%H%M%S)"
    echo "  ⚠️  備份: $(basename "$target") → $(basename "$bak")"
    cp -r "$target" "$bak"
  fi
}

copy_dir() {
  local src="$1" dst="$2" label="$3"
  mkdir -p "$dst"
  local count=0
  for f in "$src"/*; do
    [ -e "$f" ] || continue
    local name=$(basename "$f")
    if [ -d "$f" ]; then
      mkdir -p "$dst/$name"
      cp -r "$f"/* "$dst/$name"/ 2>/dev/null || true
    else
      backup_if_exists "$dst/$name"
      cp "$f" "$dst/$name"
    fi
    count=$((count + 1))
  done
  echo "  ✅ ${label}: ${count} 個項目"
}

# --- install ---
echo "📦 安裝中..."
echo ""

# Agents
copy_dir "$REPO_DIR/agents" "$KIRO_DIR/agents" "Agents"

# Steering
copy_dir "$REPO_DIR/steering" "$KIRO_DIR/steering" "Steering"

# Skills
for skill_dir in "$REPO_DIR/skills"/*/; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename "$skill_dir")
  mkdir -p "$KIRO_DIR/skills/$skill_name"
  cp "$skill_dir"/* "$KIRO_DIR/skills/$skill_name/" 2>/dev/null || true
done
echo "  ✅ Skills: $(ls -d "$REPO_DIR/skills"/*/ 2>/dev/null | wc -l | tr -d ' ') 個項目"

echo ""
echo "=========================================="
echo "🎉 安裝完成！"
echo ""
echo "使用方式:"
echo "  kiro-cli chat              # 開始對話"
echo "  說「眾將聽令」              # 啟動完整工作流"
echo "  說「叫趙雲來寫這個功能」    # 呼叫特定將領"
echo ""
echo "將領一覽:"
echo "  諸葛亮(zhuge)    策劃全局    關羽(guanyu)    Code Review"
echo "  趙雲(zhaoyun)    核心實作    張飛(zhangfei)  Bug 獵殺"
echo "  周瑜(zhouyu)     UI/UX      小喬(xiaoqiao)  視覺/文案"
echo "  曹操(caocao)     自動化部署  龐統(pangtong)  架構審計"
echo "  郭嘉(guojia)     研究/模型   荀彧(xunyu)     任務整合"
echo "  黃忠(huangzhong) Staff審查   魯肅(lusu)      UX流程"
echo "=========================================="
