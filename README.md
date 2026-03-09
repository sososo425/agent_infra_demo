# Agent Infra Demo

大厂 Infra 团队的 **Agent Infra 探索与落地**示范仓库。

## 这是什么？

本项目探索如何通过 **Harness Engineering（台架/约束工程）** 让 AI Agent 在团队中高效、安全、可控地工作。它既是一套 **AI Coding 规范的参考实现**，也是 Agent Infra 技术的试验场。

核心概念来自项目构思记录 [`Idea.md`](Idea.md)，将 Agent Harness 分为两层：

- **Soft Harness（软约束）**: Cursor Rules、AGENTS.md、SOP 文档 — 规范 Agent 的行为
- **Hard Harness（硬台架）**: 沙箱、链路追踪、自动化评测 — 保障 Agent 的安全

详见 [`docs/harness-guide.md`](docs/harness-guide.md)。

## 项目结构

```
.
├── AGENTS.md                    # Agent 入口地图（AI 必读）
├── Idea.md                      # 项目构思（与 Gemini 的对话记录）
├── .cursor/rules/               # Cursor Rules（AI 编码规范）
│   ├── general.mdc              #   通用规范
│   ├── python.mdc               #   Python 编码规范
│   ├── testing.mdc              #   测试规范
│   └── security.mdc             #   安全红线
├── docs/                        # 知识库
│   ├── architecture.md          #   项目架构
│   ├── agent-workflow.md        #   Agent 工作流 SOP
│   └── harness-guide.md         #   Harness 概念指南
└── images/                      # 图片资源
    ├── harness.png              #   Harness 约束系统图
    └── agent-scripts.png        #   agent-scripts 项目截图
```

## 快速上手

### 1. Clone 仓库

```bash
git clone <repo-url>
cd agent_infra_demo
```

### 2. 用 Cursor 打开

用 Cursor IDE 打开项目后，`.cursor/rules/` 中的规则会自动生效。
AI Agent 在编码时会自动遵循团队规范。

### 3. 了解背景

- 阅读 [`AGENTS.md`](AGENTS.md) 了解项目全貌
- 阅读 [`Idea.md`](Idea.md) 了解设计思路
- 阅读 [`docs/harness-guide.md`](docs/harness-guide.md) 了解 Harness 概念

## 落地路径

| 阶段 | 内容 | 状态 |
| :--- | :--- | :--- |
| Level 1 | Soft Harness — Cursor Rules + AGENTS.md + 知识库 | ✅ 已完成 |
| Level 2 | Mechanical Harness — pre-commit + Makefile + 自动检查 | ✅ 已完成 |
| Level 3 | Hard Harness — Docker 沙箱 + 链路追踪 + 自动化评测 | 📋 规划中 |

## 技术栈

- **语言**: Python 3.10+（未来考虑 Rust）
- **AI IDE**: Cursor
- **代码仓库**: GitLab
- **部署**: Zadig
