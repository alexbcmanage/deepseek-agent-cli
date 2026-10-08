#!/usr/bin/env bash
# Запуск Aider с DeepSeek как бэкендом.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

if [[ -f "$SCRIPT_DIR/.env" ]]; then
  set -a
  source "$SCRIPT_DIR/.env"
  set +a
fi

if [[ -z "${DEEPSEEK_API_KEY:-}" ]]; then
  echo "Не задан DEEPSEEK_API_KEY. Открой .env (скопируй из .env.example) и вставь свой ключ." >&2
  exit 1
fi

MODEL="${AIDER_DEEPSEEK_MODEL:-deepseek/deepseek-chat}"

exec "$SCRIPT_DIR/.venv/bin/aider" --model "$MODEL" "$@"
