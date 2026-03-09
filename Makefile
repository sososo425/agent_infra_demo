# Agent Infra Demo — 统一命令入口
# 用法: make lint | make test | make format | make check

.PHONY: help lint format test check install install-dev

help:
	@echo "Agent Infra Demo — 常用命令"
	@echo "  make install    安装项目依赖"
	@echo "  make install-dev 安装开发依赖（含 ruff/mypy/pytest）"
	@echo "  make lint       运行 ruff check"
	@echo "  make format     运行 ruff format（并写回）"
	@echo "  make format-check 仅检查格式，不修改"
	@echo "  make typecheck  运行 mypy"
	@echo "  make test       运行 pytest"
	@echo "  make test-cov   运行 pytest 并生成覆盖率报告"
	@echo "  make check      运行所有检查（lint + format-check + typecheck + test + 约束脚本）"
	@echo "  make audit      运行 pip-audit 安全扫描"

install:
	pip install -e .

install-dev:
	pip install -e ".[dev]"

lint:
	ruff check .

format:
	ruff format .

format-check:
	ruff format --check .

typecheck:
	@if [ -d src ] && [ -n "$$(find src -name '*.py' 2>/dev/null)" ]; then \
		mypy src; \
	else \
		echo "mypy: 跳过（无 src 或无可检查的 .py 文件）"; \
	fi

test:
	@if [ -d tests ] && [ -n "$$(find tests -name 'test_*.py' 2>/dev/null)" ]; then \
		pytest; \
	else \
		echo "pytest: 跳过（无 tests/ 或无可运行测试）"; \
	fi

test-cov:
	@if [ -d tests ]; then pytest --cov=src --cov-report=term-missing --cov-report=html; else echo "pytest: 跳过"; fi

check-no-todo:
	@./scripts/check-no-todo.sh

check-no-secrets:
	@./scripts/check-no-secrets.sh

audit:
	pip-audit

check: lint format-check typecheck check-no-todo check-no-secrets test
	@echo "所有检查通过。"
