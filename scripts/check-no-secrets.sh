#!/usr/bin/env bash
# 安全约束：检查无硬编码 Secret / API Key / Password
# 用于 pre-commit 与 make check

set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

DIRS="src tests scripts"

PATTERNS=(
  'sk-[a-zA-Z0-9_-]{20,}'
  'ak-[A-Za-z0-9]{20,}'
  'ghp_[A-Za-z0-9]{20,}'
  'gho_[A-Za-z0-9]{20,}'
  'glpat-[A-Za-z0-9\-]{20,}'
  'AKIA[0-9A-Z]{16}'
  'Bearer [a-zA-Z0-9_-]{20,}'
  'api[_-]?key[[:space:]]*=[[:space:]]*["'"'"'][^"'"'"']+["'"'"']'
  'password[[:space:]]*=[[:space:]]*["'"'"'][^"'"'"']+["'"'"']'
  'secret[[:space:]]*=[[:space:]]*["'"'"'][^"'"'"']+["'"'"']'
  'token[[:space:]]*=[[:space:]]*["'"'"'][^"'"'"']+["'"'"']'
)

ALLOWED='<YOUR_API_KEY>|your-api-key|your_api_key|xxx|example\.com|placeholder'

FOUND=0
for dir in $DIRS; do
  if [ ! -d "$dir" ]; then
    continue
  fi
  while IFS= read -r -d '' f; do
    case "$f" in
      *__pycache__*|*.pyc|*/.venv/*|*/venv/*) continue ;;
      */check-no-todo.sh|*/check-no-secrets.sh) continue ;;
    esac
    for pat in "${PATTERNS[@]}"; do
      MATCHES=$(grep -n -i -E "$pat" "$f" 2>/dev/null || true)
      [ -z "$MATCHES" ] && continue
      BAD=""
      while IFS= read -r line; do
        echo "$line" | grep -i -E "$ALLOWED" >/dev/null && continue
        BAD="${BAD}${line}"$'\n'
      done <<< "$MATCHES"
      if [ -n "$BAD" ]; then
        if [ $FOUND -eq 0 ]; then
          echo "❌ 禁止在代码中硬编码密钥/密码/Token，请使用环境变量或配置中心。"
          echo "占位示例请使用: <YOUR_API_KEY>"
          echo ""
        fi
        echo "  $f:"
        echo "$BAD" | sed 's/^/    /'
        FOUND=1
      fi
    done
  done < <(find "$dir" -type f \( -name '*.py' -o -name '*.yaml' -o -name '*.yml' -o -name '*.toml' -o -name '*.env.example' \) -print0 2>/dev/null)
done

if [ $FOUND -eq 1 ]; then
  exit 1
fi
echo "✅ check-no-secrets: 通过"
exit 0
