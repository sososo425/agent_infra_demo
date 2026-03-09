# 项目进展记录

> 最后更新：2026-03-06

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

- [x] `pyproject.toml` — 项目配置（合并两方案优势）
  - 构建: hatchling + 版本锁定
  - ruff: 15 个规则集（E/W/F/I/N/UP/B/S/A/C4/T20/ARG/RET/SIM/ERA）
  - mypy: strict 模式 + show_error_codes
  - pytest: strict-markers + strict-config
  - coverage: 独立配置，branch=true，fail_under=80
- [x] `Makefile` — 统一命令入口
  - `make install` / `make install-dev`: 拆分安装 + pre-commit 初始化
  - `make lint` / `make format` / `make format-check`: ruff 检查与格式化
  - `make typecheck`: mypy（空目录自动跳过）
  - `make test` / `make test-cov`: pytest（空目录自动跳过）+ 覆盖率报告
  - `make check`: 一键运行所有检查
  - `make audit` / `make clean`: 安全审计 + 缓存清理
- [x] `.pre-commit-config.yaml` — Git 预提交钩子
  - pre-commit-hooks: trailing-whitespace / end-of-file / check-yaml / check-toml / large-files / merge-conflict / detect-private-key
  - ruff lint (--fix) + ruff format
  - 自定义: check-no-todo + check-no-secrets
  - mirrors-mypy: 提交时自动类型检查 src/
- [x] `scripts/check-no-todo.sh` — 负面约束脚本（多目录、多文件类型、自身排除、allowed: 豁免）
- [x] `scripts/check-no-secrets.sh` — 安全约束脚本（多目录、多文件类型、占位符豁免、合并双方密钥模式）
- [x] `src/agent_infra_demo/__init__.py` — 源码包占位
- [x] `tests/__init__.py` — 测试包占位

### 背景文档

- [x] `Idea.md` — 与 Gemini 的对话记录，涵盖 Agent Harness Engineering 的原理、Hard/Soft Harness 区分、steipete/agent-scripts 分析、Cursor Rules 落地建议

## 待完成

### 阶段四：技术探索（Hard Harness）

- [ ] `src/` 业务代码 — 实际的 Agent Infra 功能实现
- [ ] Docker 沙箱原型 — Agent 代码执行隔离环境
- [ ] 链路追踪集成 — OpenTelemetry / LangSmith 接入
- [ ] 自动化评测框架 — Agent 输出质量打分
- [ ] GitLab CI/CD 流水线 — 自动化检查集成（复用 Makefile 命令）

### 持续优化

- [ ] `docs/internal-sdk.md` — 内部 SDK 接口文档（当有内部框架时补充）
- [ ] `docs/error-codes.md` — 错误码规范
- [ ] `.cursor/rules/rust.mdc` — Rust 编码规范（引入 Rust 时创建）
- [ ] 团队 Onboarding 文档 — 新成员如何使用本仓库的规范

## 快速命令参考

```bash
make install-dev   # 安装开发依赖 + 初始化 pre-commit hooks
make check         # 一键运行所有检查（lint + format + typecheck + todo + secrets + test）
make test          # 运行测试
make test-cov      # 运行测试 + 覆盖率报告
make format        # 格式化代码
make audit         # 依赖安全审计
make clean         # 清理缓存
make help          # 查看所有可用命令
```

## 分支说明

| 分支 | 内容 |
| :--- | :--- |
| `main` | 合并后的最佳版本（oversea + domestic 取长补短） |
| `oversea` | 阶段三方案 A 备份（Cursor Agent 生成） |
| `domestic` | 阶段三方案 B 备份（另一个 AI Agent 生成） |
