# Agent Infra Demo — 统一命令入口
# 用法: make help

.PHONY: help install install-dev lint format format-check typecheck test test-cov check check-no-todo check-no-secrets audit clean

help: ## 显示帮助信息
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## 安装项目运行时依赖
	pip install -e .

install-dev: ## 安装开发依赖（含 ruff/mypy/pytest）+ 初始化 pre-commit
	pip install -e ".[dev]"
	pre-commit install

lint: ## 运行 ruff lint 检查
	ruff check .

format: ## 格式化代码（写回文件）
	ruff format .
	ruff check --fix .

format-check: ## 检查代码格式（不修改）
	ruff format --check .

typecheck: ## 运行 mypy 类型检查
	@if [ -d src ] && [ -n "$$(find src -name '*.py' 2>/dev/null)" ]; then \
		mypy src; \
	else \
		echo "mypy: 跳过（src/ 无可检查的 .py 文件）"; \
	fi

test: ## 运行测试
	@if [ -d tests ] && [ -n "$$(find tests -name 'test_*.py' 2>/dev/null)" ]; then \
		pytest; \
	else \
		echo "pytest: 跳过（tests/ 无可运行测试）"; \
	fi

test-cov: ## 运行测试并生成覆盖率报告
	@if [ -d tests ] && [ -n "$$(find tests -name 'test_*.py' 2>/dev/null)" ]; then \
		pytest --cov=src --cov-report=term-missing --cov-report=html; \
	else \
		echo "pytest: 跳过（tests/ 无可运行测试）"; \
	fi

check: lint format-check typecheck check-no-todo check-no-secrets test ## 运行所有检查（一键验证）
	@echo "\n✅ All checks passed!"

check-no-todo: ## 检查代码中无 TODO/FIXME 残留
	@./scripts/check-no-todo.sh

check-no-secrets: ## 检查无硬编码 Secret
	@./scripts/check-no-secrets.sh

audit: ## 检查依赖安全漏洞
	pip-audit

clean: ## 清理缓存文件
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .pytest_cache -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .mypy_cache -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .ruff_cache -exec rm -rf {} + 2>/dev/null || true
	rm -rf htmlcov/ .coverage dist/ build/ *.egg-info
