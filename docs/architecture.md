# 项目架构

> **read_when**: 讨论架构设计、模块划分、新增子系统、理解项目整体结构时。

## 定位

Agent Infra Demo 是一个**探索性项目**，用于验证和沉淀 Agent Infra 的工程实践。
它同时服务两个目标：

1. **规范沉淀**: 作为团队 AI Coding 规范的参考实现（Cursor Rules、AGENTS.md、SOP 文档）
2. **技术探索**: 作为 Agent Harness 相关技术的试验场（沙箱、评测、工具链）

## 当前架构（Phase 1 — 规范骨架）

```
agent_infra_demo/
├── .cursor/rules/         # Soft Harness: AI 编码规范
├── docs/                  # Context Harness: 知识库
├── AGENTS.md              # 项目入口地图
├── Idea.md                # 构思记录
├── images/                # 图片资源
└── README.md              # 项目说明
```

当前阶段聚焦于 **Soft Harness 的搭建**，尚未有业务代码。

## 目标架构（Phase 2+ — 技术探索）

```
agent_infra_demo/
├── .cursor/rules/         # AI 编码规范
├── docs/                  # 知识库
├── src/
│   ├── harness/           # Harness 核心模块
│   │   ├── sandbox/       # 沙箱管理（Docker/容器）
│   │   ├── tracer/        # 链路追踪
│   │   ├── evaluator/     # 评测引擎
│   │   └── gateway/       # API 网关 / 熔断
│   ├── agents/            # Agent 实现示例
│   │   ├── coding_agent/  # 编码 Agent
│   │   └── review_agent/  # Code Review Agent
│   └── common/            # 公共模块（日志、配置、异常）
├── tests/                 # 测试
├── scripts/               # 工具脚本
├── Makefile               # 命令入口
└── pyproject.toml         # 项目配置
```

## 设计原则

1. **分层解耦**: Harness 层与 Agent 层分离，Harness 不依赖具体 Agent 实现
2. **插件化**: 沙箱、追踪器、评测器通过接口抽象，支持替换实现
3. **配置驱动**: 运行时行为通过配置文件控制，而非硬编码
4. **渐进式**: 从最简实现开始，根据实际需求逐步演进

## 技术选型参考

| 领域 | 当前选择 | 备选方案 | 决策理由 |
| :--- | :--- | :--- | :--- |
| 语言 | Python 3.10+ | Rust (未来) | 团队主力语言，生态丰富 |
| 包管理 | uv | poetry, pip | 速度快，现代化 |
| Lint/Format | ruff | flake8 + black | 统一工具，10-100x 更快 |
| 类型检查 | mypy | pyright | 社区最广泛 |
| 测试 | pytest | unittest | 社区标准，插件丰富 |
| 容器 | Docker | Firecracker, E2B | 团队已有经验 |
| 部署 | Zadig + GitLab | GitLab CI/CD | 当前团队工作流 |
