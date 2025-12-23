#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BASE_DIR/lib/logging.sh"
source "$BASE_DIR/lib/pkg.sh"
source "$BASE_DIR/modules/zsh.sh"

detect_pkg_mgr

info "开始初始化系统环境"
setup_zsh
info "全部模块执行完成"
