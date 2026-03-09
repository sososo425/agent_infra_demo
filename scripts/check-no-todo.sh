#!/usr/bin/env bash
# 负面约束：检查代码中无 TODO/FIXME/HACK/XXX 残留
# 用于 pre-commit 与 make check

set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# 扫描的目录（与 .cursorignore 对齐，排除无关路径）
DIRS="src tests scripts"

# 匹配的禁止标记（大小写不敏感）
# 允许在注释中写 "allowed: TODO" 等作为例外说明
PATTERN='(^|[^a-zA-Z])(TODO|FIXME|HACK|XXX)([^a-zA-Z]|$)'

FOUND=0
for dir in $DIRS; do
  if [ ! -d "$dir" ]; then
    continue
  fi
  while IFS= read -r -d '' f; do
    # 跳过 .cursorignore 中常见排除内容及本约束脚本自身
    case "$f" in
      *__pycache__*|*.pyc|*/.venv/*|*/venv/*) continue ;;
      */check-no-todo.sh|*/check-no-secrets.sh) continue ;;
    esac
    MATCHES=$(grep -n -i -E "$PATTERN" "$f" 2>/dev/null | grep -v 'allowed:' || true)
    if [ -n "$MATCHES" ]; then
      if [ $FOUND -eq 0 ]; then
        echo "error: 代码中禁止遗留 TODO/FIXME/HACK/XXX，请修复或移除后再提交。"
        echo "若确属例外，可在同一行注释中写明 allowed: TODO"
        echo ""
      fi
      echo "  $f:"
      echo "$MATCHES"
      FOUND=1
    fi
  done < <(find "$dir" -type f \( -name '*.py' -o -name '*.md' -o -name '*.yaml' -o -name '*.yml' -o -name '*.toml' -o -name '*.sh' \) -print0 2>/dev/null)
done

if [ $FOUND -eq 1 ]; then
  exit 1
fi
echo "check-no-todo: 通过"
exit 0
