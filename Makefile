.PHONY: help install lint format typecheck test check clean audit

help: ## 显示帮助信息
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## 安装项目依赖（含开发依赖）
	pip install -e ".[dev]"
	pre-commit install

lint: ## 运行 ruff lint 检查
	ruff check src/ tests/

format: ## 格式化代码
	ruff format src/ tests/
	ruff check --fix src/ tests/

format-check: ## 检查代码格式（不修改）
	ruff format --check src/ tests/

typecheck: ## 运行 mypy 类型检查
	mypy src/

test: ## 运行测试
	pytest

check: lint format-check typecheck check-todo check-secrets ## 运行所有检查（一键验证）
	@echo "\n✅ All checks passed!"

check-todo: ## 检查代码中无 TODO/FIXME 残留
	@bash scripts/check-no-todo.sh

check-secrets: ## 检查无硬编码 Secret
	@bash scripts/check-no-secrets.sh

audit: ## 检查依赖安全漏洞
	pip-audit

clean: ## 清理缓存文件
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .pytest_cache -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .mypy_cache -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .ruff_cache -exec rm -rf {} + 2>/dev/null || true
	rm -rf htmlcov/ .coverage dist/ build/ *.egg-info
