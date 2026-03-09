# 项目进展记录

> 最后更新：2026-03-09

## 已完成

### 阶段一：Cursor Rules 基础骨架（Soft Harness 核心）✅

- [x] `.cursor/rules/general.mdc` — 团队 DNA 通用规则（角色定义、核心原则、行为约束、知识库索引、提交规范）
- [x] `.cursor/rules/python.mdc` — Python 编码规范（类型标注、异常处理、异步编程、日志、项目结构、依赖管理）
- [x] `.cursor/rules/testing.mdc` — 测试规范（pytest、AAA 模式、覆盖率要求、Mock 原则、测试分层）
- [x] `.cursor/rules/security.mdc` — 安全红线（禁止硬编码密钥、输入验证、依赖安全、禁止 eval/exec）
- [x] `.cursorignore` — Agent 上下文排除列表（Python 缓存、虚拟环境、IDE 文件、大文件等）

### 阶段二：知识库与 SOP 文档（Context Harness）✅

- [x] `AGENTS.md` — 项目入口地图（目录结构、read_when 路由表、工作规范）
- [x] `docs/agent-workflow.md` — Agent 工作流 SOP（Plan → Execute → Verify 三阶段流程）
- [x] `docs/harness-guide.md` — Harness 概念指南（Hard/Soft 两层模型、行业参考、落地路径）
- [x] `docs/architecture.md` — 项目架构文档（当前骨架、目标架构、设计原则、技术选型）
- [x] `README.md` — 项目说明与快速上手指南
- [x] `Idea.md` — 图片引用修复（harness.png、agent-scripts.png）

### 阶段三：机械强制约束（Mechanical Harness）✅

- [x] `pyproject.toml` — 项目配置（ruff、mypy、pytest、coverage 配置）
- [x] `Makefile` — 统一命令入口（make lint / make test / make format / make check / make audit）
- [x] `.pre-commit-config.yaml` — Git 预提交钩子（ruff、ruff-format、mypy、check-no-todo、check-no-secrets）
- [x] `scripts/check-no-todo.sh` — 负面约束脚本：检查代码中无 TODO/FIXME/HACK/XXX 残留
- [x] `scripts/check-no-secrets.sh` — 安全约束脚本：检查无硬编码 Secret/API Key/Token

### 背景文档

- [x] `Idea.md` — 与 Gemini 的对话记录，涵盖 Agent Harness Engineering 的原理、Hard/Soft Harness 区分、steipete/agent-scripts 分析、Cursor Rules 落地建议

## 待完成

### 阶段四：技术探索（Hard Harness）

- [ ] `src/` 目录初始化 — 项目源码骨架
- [ ] Docker 沙箱原型 — Agent 代码执行隔离环境
- [ ] 链路追踪集成 — OpenTelemetry / LangSmith 接入
- [ ] 自动化评测框架 — Agent 输出质量打分
- [ ] GitLab CI/CD 流水线 — 自动化检查集成

### 持续优化

- [ ] `docs/internal-sdk.md` — 内部 SDK 接口文档（当有内部框架时补充）
- [ ] `docs/error-codes.md` — 错误码规范
- [ ] `.cursor/rules/rust.mdc` — Rust 编码规范（引入 Rust 时创建）
- [ ] 团队 Onboarding 文档 — 新成员如何使用本仓库的规范
