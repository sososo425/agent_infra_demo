#!/usr/bin/env bash
# 检查 src/ 目录下的 Python 文件中是否存在 TODO / FIXME / HACK / XXX 残留
# 用于 pre-commit hook 和 make check

set -euo pipefail

SEARCH_DIR="src"

if [ ! -d "$SEARCH_DIR" ]; then
    exit 0
fi

MATCHES=$(grep -rn --include="*.py" -E '\b(TODO|FIXME|HACK|XXX)\b' "$SEARCH_DIR" 2>/dev/null || true)

if [ -n "$MATCHES" ]; then
    echo "❌ 发现代码中存在 TODO/FIXME/HACK/XXX 残留："
    echo ""
    echo "$MATCHES"
    echo ""
    echo "请完成或移除这些标记后再提交。"
    exit 1
fi

echo "✅ 无 TODO/FIXME 残留"
