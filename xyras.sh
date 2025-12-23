#!/usr/bin/env bash
# ======================================================
#  XYRAS - 模块化 Linux 初始化与运维工具
#  Author: LuvKab
# ======================================================

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------------- 基础能力 ----------------
source "$BASE_DIR/lib/logging.sh"
source "$BASE_DIR/lib/pkg.sh"

# ---------------- 模块加载 ----------------
source "$BASE_DIR/modules/zsh.sh"
# 未来可扩展模块
# source "$BASE_DIR/modules/base.sh"
# source "$BASE_DIR/modules/docker.sh"

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

0.  退出
--------------------------------------
EOF
}

pause() {
  read -rp "按 Enter 键继续..." _
}

# ---------------- Shell 管理 ----------------

# ---------------- Shell 管理 ----------------

ask_switch_to_zsh() {
  if ! command -v zsh >/dev/null 2>&1; then
    error "未检测到 zsh，请先安装 zsh"
    return
  fi

  if [ "$SHELL" = "/usr/bin/zsh" ]; then
    info "当前默认 Shell 已是 zsh"
    return
  fi

  warn "Zsh 环境已安装完成"
  warn "是否将 zsh 设置为默认 Shell？（重新登录后生效）"

  read -rp "确认切换为 zsh？[y/N]: " confirm
  [[ "$confirm" =~ ^[Yy]$ ]] || return

  # ---- 确保 /etc/shells ----
  if ! grep -q "/usr/bin/zsh" /etc/shells 2>/dev/null; then
    warn "/usr/bin/zsh 未在 /etc/shells 中，尝试添加"
    echo "/usr/bin/zsh" | sudo tee -a /etc/shells >/dev/null
  fi

  # ---- 确保 chsh 命令存在 ----
  if ! command -v chsh >/dev/null 2>&1; then
    warn "系统中未检测到 chsh，尝试安装所需工具包"

    case "$PKG_MGR" in
      dnf|yum)
        sudo "$PKG_MGR" install -y util-linux passwd || {
          error "无法自动安装 chsh（util-linux/passwd）"
          warn "你可以手动执行：sudo $PKG_MGR install util-linux passwd"
          return
        }
        ;;
      *)
        error "当前系统无法自动安装 chsh，请手动处理"
        return
        ;;
    esac
  fi

  # ---- 再次确认 chsh ----
  if ! command -v chsh >/dev/null 2>&1; then
    error "chsh 仍不可用，已中止修改默认 Shell"
    return
  fi

  chsh -s /usr/bin/zsh "$USER"
  info "已设置 zsh 为默认 Shell，请重新登录或重新连接 SSH"
}


# ---------------- 业务逻辑 ----------------

handle_choice() {
  case "$1" in
    1)
      info "开始配置 Zsh 环境"
      setup_zsh
      ask_switch_to_zsh
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
