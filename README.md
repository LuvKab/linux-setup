# 🧰 linux-setup

一个 **模块化、可扩展、可反复执行** 的 Linux 初始化工具框架，
用于快速搭建开发 / 运维 / 云服务器环境。

> 一次写好，以后所有服务器都能用。

---

## ✨ 特性

- ✅ 模块化设计（zsh / docker / node / …）
- ✅ 支持 Amazon Linux / Ubuntu / Arch / CentOS
- ✅ 可重复执行（幂等设计，多次运行不破坏环境）
- ✅ 不强制修改系统配置（不强制 chsh）
- ✅ 统一入口，长期维护

---

## 🚀 快速开始

```bash
git clone git@github.com:LuvKab/linux-setup.git
cd linux-setup
chmod +x setup.sh
```

### 默认执行（安装所有模块）

```bash
./setup.sh
```

---

## 🧩 按需安装模块

你可以只安装你需要的模块：

```bash
./setup.sh zsh
```

未来支持示例：

```bash
./setup.sh zsh docker node
```

---

## 🧭 交互式安装（推荐新手）

```bash
./setup.sh --interactive
```

终端中会出现可选模块列表，按编号选择即可。

---

## 📦 当前支持模块

| 模块 | 说明 |
|----|----|
| zsh | Zsh + Oh My Zsh + Powerlevel10k + 常用插件 |

> 🚧 docker / node / base 等模块正在规划中

---

## 🖥️ Zsh 模块说明

Zsh 模块将自动完成以下工作：

- 安装 zsh
- 安装 Oh My Zsh
- 安装 Powerlevel10k 主题
- 安装常用插件：
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - zsh-completions
- 安装 fzf（自动处理跨发行版差异）

### 安装完成后你需要做的事

```bash
zsh
p10k configure
```

⚠️ 注意：`p10k configure` **只能在 zsh 中运行**，在 bash 中无法使用。

---

## 🎨 字体提示（非常重要）

Powerlevel10k 依赖 Nerd Font 才能正确显示图标。

推荐字体：

- MesloLGS NF

如果终端中图标显示为乱码或方块，请在 **本地终端** 安装 Nerd Font。

---

## 🧠 项目结构与设计理念

```text
linux-setup/
├── setup.sh        # 唯一入口，负责任务调度
├── lib/            # 通用能力（日志 / 包管理器等）
├── modules/        # 功能模块（每个模块只做一件事）
└── README.md
```

设计原则：

- `lib/`：提供能力，不做决策
- `modules/`：只做具体事情
- `setup.sh`：统一调度入口

---

## 📈 Roadmap

- [ ] base 模块（git / curl / wget 等）
- [ ] docker 模块
- [ ] node 模块
- [ ] 配置文件支持（config/options.conf）
- [ ] cloud-init / user-data 场景支持

---

## 🎬 演示（规划中）

后续将补充终端演示 GIF：

```text
./setup.sh --interactive
```

---

## 🤝 贡献

欢迎 Issue / PR / 讨论。

这是一个为 **长期使用、可维护、可扩展** 而设计的工具。