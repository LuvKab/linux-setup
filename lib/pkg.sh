command_exists() {
  command -v "$1" >/dev/null 2>&1
}

detect_pkg_mgr() {
  if command_exists pacman; then
    PKG_MGR="pacman"
  elif command_exists apt-get; then
    PKG_MGR="apt"
  elif command_exists dnf; then
    PKG_MGR="dnf"
  elif command_exists yum; then
    PKG_MGR="yum"
  else
    error "未检测到支持的包管理器"
    exit 1
  fi

  info "包管理器：$PKG_MGR"
}

install_pkg() {
  case "$PKG_MGR" in
    pacman) sudo pacman -Sy --noconfirm "$@" ;;
    apt)    sudo apt-get update -y && sudo apt-get install -y "$@" ;;
    dnf)    sudo dnf install -y "$@" ;;
    yum)    sudo yum install -y "$@" ;;
  esac
}
