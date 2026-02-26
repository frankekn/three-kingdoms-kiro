#!/bin/bash
set -e

uninstall_kiro() {
  echo "[Kiro CLI] Removing Three Kingdoms files..."
  rm -f ~/.kiro/agents/{zhuge,zhaoyun,guanyu,zhangfei,zhouyu,xiaoqiao,caocao,pangtong,guojia,xunyu,huangzhong,lusu}.json
  rm -f ~/.kiro/steering/{three-kingdoms,dev-standards}.md
  for s in deploy-checklist design-template prd-template refactor-clean review-template search-before-code security-audit task-template tdd-flow verify-pipeline; do
    rm -rf ~/.kiro/skills/"$s"
  done
  echo "[Kiro CLI] Done."
}

uninstall_claude_code() {
  echo "[Claude Code] Removing Three Kingdoms files..."
  rm -f ~/.claude/agents/{zhuge,zhaoyun,guanyu,zhangfei,zhouyu,xiaoqiao,caocao,pangtong,guojia,xunyu,huangzhong,lusu}.md
  rm -f ~/.claude/CLAUDE.md
  for s in deploy-checklist design-template prd-template refactor-clean review-template search-before-code security-audit task-template tdd-flow verify-pipeline; do
    rm -rf ~/.claude/skills/"$s"
  done
  echo "[Claude Code] Done."
}

show_menu() {
  echo "Three Kingdoms Agent System - Uninstall"
  echo "----------------------------------------"
  echo "Select platform:"
  echo "  [1] Kiro CLI only"
  echo "  [2] Claude Code only"
  echo "  [3] Both"
  echo "  [q] Quit"
  echo ""
  printf "Choice: "
  read -r choice
  case "$choice" in
    1) uninstall_kiro ;;
    2) uninstall_claude_code ;;
    3) uninstall_kiro; echo ""; uninstall_claude_code ;;
    q|Q) echo "Cancelled."; exit 0 ;;
    *) echo "Invalid choice."; exit 1 ;;
  esac
}

case "${1:-}" in
  --kiro)        uninstall_kiro ;;
  --claude-code) uninstall_claude_code ;;
  --both)        uninstall_kiro; echo ""; uninstall_claude_code ;;
  --help|-h)
    echo "Usage: ./uninstall.sh [--kiro|--claude-code|--both]"
    echo "  No arguments: interactive menu"
    ;;
  "") show_menu ;;
  *)  echo "Unknown option: $1"; echo "Usage: ./uninstall.sh [--kiro|--claude-code|--both]"; exit 1 ;;
esac
