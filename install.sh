#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
KIRO_DIR="${HOME}/.kiro"

echo "Three Kingdoms Kiro CLI Agent System"
echo "三國 Kiro CLI Agent 系統 — 安裝程式"
echo "======================================"
echo ""
echo "Source | 來源: ${REPO_DIR}"
echo "Target | 目標: ${KIRO_DIR}"
echo ""

backup_if_exists() {
  local target="$1"
  if [ -e "$target" ]; then
    local bak="${target}.bak.$(date +%Y%m%d%H%M%S)"
    echo "  [backup] $(basename "$target") -> $(basename "$bak")"
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
  echo "  [ok] ${label}: ${count} items"
}

echo "Installing..."
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
echo "  [ok] Skills: $(ls -d "$REPO_DIR/skills"/*/ 2>/dev/null | wc -l | tr -d ' ') items"

echo ""
echo "======================================"
echo "Done! | 安裝完成"
echo ""
echo "Usage | 使用方式:"
echo "  kiro-cli chat                # Start a conversation"
echo '  Say "眾將聽令"               # Trigger full workflow'
echo '  Say "叫趙雲來寫這個功能"     # Call a specific agent'
echo ""
echo "Agents | 將領:"
echo "  zhuge       Strategy        guanyu      Code Review"
echo "  zhaoyun     Implementation  zhangfei    Bug Hunting"
echo "  zhouyu      UI/UX           xiaoqiao    Visual/Copy"
echo "  caocao      CI/CD/Deploy    pangtong    Architecture"
echo "  guojia      Research        xunyu       Task Integration"
echo "  huangzhong  Staff Review    lusu        UX Flow"
echo "======================================"
