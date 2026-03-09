#!/usr/bin/env bash
# 检查 src/ 目录下的 Python 文件中是否存在疑似硬编码的密钥/Token
# 用于 pre-commit hook 和 make check

set -euo pipefail

SEARCH_DIR="src"

if [ ! -d "$SEARCH_DIR" ]; then
    exit 0
fi

# 匹配常见的密钥模式：
#   - sk-xxx, ak-xxx (OpenAI / AWS style keys)
#   - ghp_xxx (GitHub personal access tokens)
#   - 变量赋值中包含长随机字符串的情况
PATTERNS=(
    'sk-[A-Za-z0-9]{20,}'
    'ak-[A-Za-z0-9]{20,}'
    'ghp_[A-Za-z0-9]{20,}'
    'gho_[A-Za-z0-9]{20,}'
    'glpat-[A-Za-z0-9\-]{20,}'
    'AKIA[0-9A-Z]{16}'
    '(password|passwd|secret|token|api_key|apikey)\s*=\s*["\x27][^"\x27]{8,}["\x27]'
)

COMBINED_PATTERN=$(IFS='|'; echo "${PATTERNS[*]}")
MATCHES=$(grep -rn --include="*.py" -E "$COMBINED_PATTERN" "$SEARCH_DIR" 2>/dev/null || true)

if [ -n "$MATCHES" ]; then
    echo "❌ 发现疑似硬编码的密钥/Token："
    echo ""
    echo "$MATCHES"
    echo ""
    echo "请使用环境变量或配置中心管理敏感信息。"
    exit 1
fi

echo "✅ 无硬编码密钥"
