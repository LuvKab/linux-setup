# 🧰 linux-setup

<p align="center">
  <img src="https://img.shields.io/badge/XYRAS-powered-blueviolet?style=for-the-badge" />
  <img src="https://img.shields.io/github/stars/LuvKab/linux-setup?style=for-the-badge" />
  <img src="https://img.shields.io/github/license/LuvKab/linux-setup?style=for-the-badge" />
</p>

一个 **模块化、可扩展、可反复执行** 的 Linux 初始化与运维工具框架，
核心入口工具名为 **XYRAS**。

> 一次写好，以后所有服务器都能用。

---

## 📚 目录

- [✨ 特性](#-特性)
- [🚀 快速开始](#-快速开始)
- [🧭 使用方式](#-使用方式)
- [📦 当前支持模块](#-当前支持模块)
- [🎬 演示](#-演示)
- [🧠 项目结构与设计理念](#-项目结构与设计理念)
- [📈 Roadmap](#-roadmap)
- [🤝 贡献](#-贡献)

---

## ✨ 特性

- ✅ 模块化设计（zsh / docker / node / …）
- ✅ 菜单式交互（XYRAS 主控入口）
- ✅ 支持 Amazon Linux / Ubuntu / Arch / CentOS
- ✅ 可重复执行（幂等设计，多次运行不破坏环境）
- ✅ 不强制修改系统配置（不强制 chsh）
- ✅ 统一入口，适合长期维护

---

## 🚀 快速开始

```bash
git clone git@github.com:LuvKab/linux-setup.git
cd linux-setup
chmod +x xyras.sh
```

启动 XYRAS 主控工具：

```bash
./xyras.sh
```

---

## 🧭 使用方式

### 1️⃣ 菜单式交互（推荐）

启动后你将看到类似菜单：

```text
1. Zsh 开发环境（Oh My Zsh + P10k）
2. 基础环境（规划中）
3. Docker 环境（规划中）

00. 更新 XYRAS
0.  退出
```

输入数字即可执行对应模块，执行完成后自动返回菜单。

---

## 📦 当前支持模块

| 模块 | 说明 |
|----|----|
| zsh | Zsh + Oh My Zsh + Powerlevel10k + 常用插件 |

---

## 🎬 演示

> 以下为示意演示（终端录屏 GIF 规划中）

```text
$ ./xyras.sh

██╗  ██╗██╗   ██╗██████╗  █████╗ ███████╗
╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔══██╗██╔════╝
 ╚███╔╝  ╚████╔╝ ██████╔╝███████║███████╗
 ██╔██╗   ╚██╔╝  ██╔══██╗██╔══██║╚════██║
██╔╝ ██╗   ██║   ██║  ██║██║  ██║███████║
╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

XYRAS · 模块化 Linux 初始化工具
--------------------------------------
```

---

## 🧠 项目结构与设计理念

```text
linux-setup/
├── xyras.sh        # 主控入口（菜单 / 交互）
├── setup.sh        # 自动化入口（可选）
├── lib/            # 通用能力（日志 / 包管理器等）
├── modules/        # 功能模块（每个模块只做一件事）
└── README.md
```

设计原则：

- `lib/`：提供能力，不做决策
- `modules/`：只做具体事情
- `xyras.sh`：面向用户的统一交互入口

---

## 📈 Roadmap

- [ ] base 模块（git / curl / wget / 系统信息）
- [ ] docker 模块
- [ ] node 模块
- [ ] XYRAS 自动更新（git pull）
- [ ] 插件注册机制（无需手改菜单）

---

## 🤝 贡献

欢迎 Issue / PR / 讨论。

这是一个为 **长期使用、可维护、可扩展** 而设计的 Linux 工具框架。