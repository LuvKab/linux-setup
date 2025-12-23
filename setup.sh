#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# -------- 加载基础能力 --------
source "$BASE_DIR/lib/logging.sh"
source "$BASE_DIR/lib/pkg.sh"

# -------- 加载模块 --------
source "$BASE_DIR/modules/zsh.sh"
# 以后新增模块只需要加一行
# source "$BASE_DIR/modules/docker.sh"

detect_pkg_mgr

AVAILABLE_MODULES=("zsh")

run_module() {
  case "$1" in
    zsh) setup_zsh ;;
    *)
      error "未知模块：$1"
      exit 1
      ;;
  esac
}

interactive_select() {
  warn "进入交互模式，请选择要安装的模块："
  select module in "${AVAILABLE_MODULES[@]}"; do
    run_module "$module"
    break
  done
}

main() {
  if [ "$#" -eq 0 ]; then
    info "未指定模块，默认执行全部模块"
    for m in "${AVAILABLE_MODULES[@]}"; do
      run_module "$m"
    done
    return
  fi

  if [ "$1" = "--interactive" ]; then
    interactive_select
    return
  fi

  for arg in "$@"; do
    run_module "$arg"
  done
}

main "$@"

