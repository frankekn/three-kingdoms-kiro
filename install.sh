#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

install_kiro() {
  echo "[Kiro CLI] Installing..."
  mkdir -p ~/.kiro/agents ~/.kiro/steering ~/.kiro/skills
  cp "$SCRIPT_DIR"/kiro/agents/*.json ~/.kiro/agents/
  cp "$SCRIPT_DIR"/kiro/steering/*.md ~/.kiro/steering/
  for d in "$SCRIPT_DIR"/kiro/skills/*/; do
    name=$(basename "$d")
    mkdir -p ~/.kiro/skills/"$name"
    cp "$d"SKILL.md ~/.kiro/skills/"$name"/
  done
  echo "[Kiro CLI] Done. Files installed to ~/.kiro/"
}

install_claude_code() {
  echo "[Claude Code] Installing..."
  mkdir -p ~/.claude/agents ~/.claude/skills
  cp "$SCRIPT_DIR"/claude-code/agents/*.md ~/.claude/agents/
  cp "$SCRIPT_DIR"/claude-code/CLAUDE.md ~/.claude/CLAUDE.md
  for d in "$SCRIPT_DIR"/claude-code/skills/*/; do
    name=$(basename "$d")
    mkdir -p ~/.claude/skills/"$name"
    cp "$d"SKILL.md ~/.claude/skills/"$name"/
  done
  echo "[Claude Code] Done. Files installed to ~/.claude/"
}

show_menu() {
  echo "Three Kingdoms Agent System - Install"
  echo "--------------------------------------"
  echo "Select platform:"
  echo "  [1] Kiro CLI only"
  echo "  [2] Claude Code only"
  echo "  [3] Both"
  echo "  [q] Quit"
  echo ""
  printf "Choice: "
  read -r choice
  case "$choice" in
    1) install_kiro ;;
    2) install_claude_code ;;
    3) install_kiro; echo ""; install_claude_code ;;
    q|Q) echo "Cancelled."; exit 0 ;;
    *) echo "Invalid choice."; exit 1 ;;
  esac
}

case "${1:-}" in
  --kiro)        install_kiro ;;
  --claude-code) install_claude_code ;;
  --both)        install_kiro; echo ""; install_claude_code ;;
  --help|-h)
    echo "Usage: ./install.sh [--kiro|--claude-code|--both]"
    echo "  No arguments: interactive menu"
    ;;
  "") show_menu ;;
  *)  echo "Unknown option: $1"; echo "Usage: ./install.sh [--kiro|--claude-code|--both]"; exit 1 ;;
esac
