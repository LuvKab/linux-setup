#!/usr/bin/env bash
# ======================================================
#  XYRAS - 模块化 Linux 初始化与运维工具
#  Author: LuvKab
#  Style : 菜单式 / 可扩展 / 模块驱动
# ======================================================

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------------- 基础能力 ----------------
source "$BASE_DIR/lib/logging.sh"
source "$BASE_DIR/lib/pkg.sh"

# ---------------- 模块加载 ----------------
source "$BASE_DIR/modules/zsh.sh"
# 未来扩展示例
# source "$BASE_DIR/modules/docker.sh"
# source "$BASE_DIR/modules/base.sh"

# ---------------- 初始化 ----------------
detect_pkg_mgr

# ---------------- UI ----------------

print_banner() {
  clear
  cat <<'EOF'

██╗  ██╗██╗   ██╗██████╗  █████╗ ███████╗
╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔══██╗██╔════╝
 ╚███╔╝  ╚████╔╝ ██████╔╝███████║███████╗
 ██╔██╗   ╚██╔╝  ██╔══██╗██╔══██║╚════██║
██╔╝ ██╗   ██║   ██║  ██║██║  ██║███████║
╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

XYRAS · 模块化 Linux 初始化工具
--------------------------------------
EOF
}

print_menu() {
  cat <<EOF
1. Zsh 开发环境（Oh My Zsh + P10k）
2. 基础环境（规划中）
3. Docker 环境（规划中）

00. 更新 XYRAS
0.  退出
--------------------------------------
EOF
}

pause() {
  read -rp "按 Enter 键返回菜单..." _
}

# ---------------- 业务逻辑 ----------------

handle_choice() {
  case "$1" in
    1)
      info "开始配置 Zsh 环境"
      setup_zsh
      pause
      ;;
    2)
      warn "基础环境模块尚未实现"
      pause
      ;;
    3)
      warn "Docker 模块尚未实现"
      pause
      ;;
    00)
      warn "更新功能预留（git pull）"
      pause
      ;;
    0)
      info "退出 XYRAS"
      exit 0
      ;;
    *)
      warn "无效选项"
      pause
      ;;
  esac
}

# ---------------- 主循环 ----------------

main_loop() {
  while true; do
    print_banner
    print_menu
    read -rp "请输入你的选择: " choice
    handle_choice "$choice"
  done
}

main_loop
