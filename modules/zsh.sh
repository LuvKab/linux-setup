#!/usr/bin/env bash
# Zsh 环境模块（被 setup.sh 调用）

# -----------------------
# 基础软件
# -----------------------

install_base_packages() {
  info "检查并安装基础软件（zsh / git）"

  local pkgs=()
  command_exists zsh || pkgs+=(zsh)
  command_exists git || pkgs+=(git)

  if [ "${#pkgs[@]}" -gt 0 ]; then
    install_pkg "${pkgs[@]}"
  else
    info "zsh 和 git 已存在，跳过"
  fi
}

# -----------------------
# Oh My Zsh
# -----------------------

backup_zshrc() {
  if [ -f "$HOME/.zshrc" ] && [ ! -f "$HOME/.zshrc.bak" ]; then
    info "已备份现有 .zshrc → .zshrc.bak"
    cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
  fi
}

install_oh_my_zsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    info "Oh My Zsh 已安装，跳过"
    return
  fi

  info "安装 Oh My Zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# -----------------------
# Powerlevel10k
# -----------------------

install_p10k() {
  local theme_dir="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

  if [ -d "$theme_dir" ]; then
    info "Powerlevel10k 已存在，跳过"
    return
  fi

  info "安装 Powerlevel10k 主题"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$theme_dir"
}

configure_p10k_theme() {
  if ! grep -q 'powerlevel10k/powerlevel10k' "$HOME/.zshrc" 2>/dev/null; then
    info "设置 Powerlevel10k 为默认主题"
    sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$HOME/.zshrc"
  fi
}

# -----------------------
# 插件
# -----------------------

install_plugin() {
  local name="$1"
  local repo="$2"
  local dir="$HOME/.oh-my-zsh/custom/plugins/$name"

  if [ -d "$dir" ]; then
    info "插件 $name 已存在，跳过"
    return
  fi

  info "安装插件：$name"
  git clone "$repo" "$dir"
}

ensure_plugin_enabled() {
  local plugin="$1"
  grep -q "$plugin" "$HOME/.zshrc" && return
  sed -i "/^plugins=/ s/)/ $plugin)/" "$HOME/.zshrc"
}

install_plugins() {
  install_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
  install_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting
  install_plugin zsh-completions https://github.com/zsh-users/zsh-completions

  ensure_plugin_enabled zsh-autosuggestions
  ensure_plugin_enabled zsh-syntax-highlighting
  ensure_plugin_enabled zsh-completions
}

# -----------------------
# fzf（跨发行版）
# -----------------------

install_fzf_from_git() {
  if [ -d "$HOME/.fzf" ]; then
    info "fzf 目录已存在，跳过"
    return
  fi

  info "通过 GitHub 安装 fzf"
  git clone --depth=1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --all --no-bash --no-fish
}

ensure_fzf() {
  if command_exists fzf; then
    info "fzf 已安装"
    return
  fi

  info "尝试通过包管理器安装 fzf"
  if install_pkg fzf; then
    info "fzf 已通过包管理器安装"
    return
  fi

  warn "仓库中未找到 fzf，使用 GitHub 方式安装"
  install_fzf_from_git
}

ensure_fzf_in_zshrc() {
  grep -q 'fzf.zsh' "$HOME/.zshrc" 2>/dev/null && return

  cat >>"$HOME/.zshrc" <<'EOF'

# fzf（模糊搜索）
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
EOF
}

# -----------------------
# 模块入口（唯一对外接口）
# -----------------------

setup_zsh() {
  info "===== 配置 Zsh 环境 ====="

  install_base_packages
  backup_zshrc
  install_oh_my_zsh
  install_p10k
  configure_p10k_theme
  install_plugins
  ensure_fzf
  ensure_fzf_in_zshrc

  warn "Zsh 环境配置完成"
  warn "请在后续步骤中进入 zsh 并运行：p10k configure"
}
