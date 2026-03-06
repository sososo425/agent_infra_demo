# AGENTS.md — Agent Infra Demo 项目地图

> 本文件是 AI Agent 进入本项目时的**第一份文档**。
> 请在开始任何任务前完整阅读本文件。

## 项目概述

本项目是大厂 Infra 团队的 **Agent Infra 探索与落地** 示范仓库。
目标：探索如何通过工程手段（Harness Engineering）让 AI Agent 在团队中高效、安全、可控地工作。

- **主要语言**: Python (>= 3.10)，未来可能引入 Rust
- **部署方式**: GitLab 代码仓库 + Zadig 手动部署
- **团队工具**: Cursor IDE（AI Coding）

## 目录结构

```
.
├── AGENTS.md                 # 📍 你在这里 — 项目入口地图
├── README.md                 # 项目说明与快速上手
├── Idea.md                   # 项目构思记录（与 Gemini 的对话）
├── .cursor/
│   └── rules/                # Cursor Rules（AI 编码规范）
│       ├── general.mdc       # 团队通用规范
│       ├── python.mdc        # Python 编码规范
│       ├── testing.mdc       # 测试规范
│       └── security.mdc      # 安全红线
├── .cursorignore             # Agent 上下文排除列表
├── docs/                     # 知识库（按需阅读）
│   ├── architecture.md       # 项目架构设计
│   ├── agent-workflow.md     # Agent 工作流 SOP
│   └── harness-guide.md      # Harness 概念指南
├── images/                   # 图片资源
│   ├── harness.png
│   └── agent-scripts.png
└── src/                      # 源代码（待创建）
```

## 知识库索引（read_when 路由表）

遇到以下场景时，请**先阅读对应文档**再开始工作：

| 场景关键词 | 文档路径 | 说明 |
| :--- | :--- | :--- |
| 架构、模块划分、分层 | `docs/architecture.md` | 项目整体架构与设计原则 |
| Agent 工作流、Plan、Execute | `docs/agent-workflow.md` | Agent 执行任务的标准流程 |
| Harness、约束、沙箱、评测 | `docs/harness-guide.md` | Hard/Soft Harness 概念与实践 |
| 构思、背景、为什么做这个项目 | `Idea.md` | 与 Gemini 的对话，包含项目动机和思考 |
| 进展、TODO、下一步计划 | `docs/progress.md` | 项目进展记录与待办事项 |

## 工作规范

1. **先计划，后执行**: 复杂任务先制定计划（可用 Plan Mode），确认后再动手
2. **小步提交**: 每次 commit 聚焦一个变更点，使用 Conventional Commits 格式
3. **测试伴随**: 新增功能必须附带测试，覆盖率 >= 80%
4. **文档同步**: 修改架构或新增模块时，同步更新本文件和相关文档
