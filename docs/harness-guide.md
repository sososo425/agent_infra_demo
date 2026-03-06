# Harness 概念指南

> **read_when**: 讨论 Harness、约束系统、沙箱、评测、Agent 安全控制时。

## 什么是 Agent Harness？

Agent Harness（智能体台架/约束系统）是包裹在 LLM "大脑"外面的**工程骨架**。
它解决的核心问题是：**如何把不可靠的 LLM 变成可靠的软件系统**。

详细讨论见 `Idea.md`，本文做结构化提炼。

## 两层 Harness 模型

### Hard Harness（硬台架 — 基础设施层）

关注：怎么让 Agent **跑起来、不炸机、可评测**？

| 组件 | 职责 | 技术选型参考 |
| :--- | :--- | :--- |
| Sandbox | 隔离代码执行 | Docker, E2B, Firecracker |
| Gateway | 流量控制、鉴权、熔断 | Kong, Cloudflare, 自研 Proxy |
| Tracer | 记录思考过程 | LangSmith, OpenTelemetry |
| Evaluator | 自动化打分 | Ragas, DeepEval, Promptfoo |

**四个核心能力**:
1. **隔离与沙箱**: 防止 Agent 执行危险操作
2. **状态与确定性控制**: Mock 外部世界，让行为可复现
3. **观测与拦截**: 实时监控，死循环检测，可随时中断
4. **评估闭环**: 自动化评分，量化表现

### Soft Harness（软约束 — 应用层）

关注：怎么让 Agent **把代码写对、不跑偏、符合规范**？

| 类型 | 手段 | 本项目实现 |
| :--- | :--- | :--- |
| 认知约束 | AGENTS.md / 结构化文档 | `AGENTS.md` + `docs/` |
| 编码约束 | Cursor Rules / Lint 规则 | `.cursor/rules/*.mdc` |
| 机械约束 | Linter / Pre-commit / CI | `ruff` + `mypy` + pre-commit |
| 流程约束 | Plan → Execute → Verify | `docs/agent-workflow.md` |
| 负面约束 | 禁止 TODO、禁止硬编码 | `.cursor/rules/security.mdc` |

## 行业参考

| 项目/工具 | 定位 | Harness 类型 |
| :--- | :--- | :--- |
| steipete/agent-scripts | Agent SOP 技能库 | Soft (Context) |
| Cursor Rules / .cursor/rules/ | IDE 内规则引擎 | Soft (Cognitive) |
| Aider | CLI AI Coding 工具 | Soft (Dynamic) + Mechanical |
| Cline / Roo Code | VS Code 插件 | Soft (Interactive) |
| LangSmith | 可观测性平台 | Hard (Tracing + Eval) |
| E2B | 代码沙箱 | Hard (Sandbox) |
| Inspect (UK AISI) | 安全评测框架 | Hard (Evaluation) |

## 本项目的 Harness 落地路径

```
Level 1 (当前): Soft Harness
  └─ Cursor Rules + AGENTS.md + docs/ + coding standards

Level 2 (下一步): Mechanical Harness
  └─ pre-commit hooks + Makefile + ruff/mypy 自动检查

Level 3 (未来): Hard Harness
  └─ Docker 沙箱 + 链路追踪 + 自动化评测
```
