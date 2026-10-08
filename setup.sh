#!/usr/bin/env bash
# Ставит агентскую CLI-обёртку (Aider) на Python 3.12, изолированно через uv.
# Не требует sudo и не трогает системный Python.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
cd "$SCRIPT_DIR"

if ! command -v uv >/dev/null 2>&1; then
  echo "uv не найден, устанавливаю (в ~/.local/bin, без sudo)..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

uv python install 3.12
uv venv --python 3.12 "$SCRIPT_DIR/.venv"
uv pip install --python "$SCRIPT_DIR/.venv/bin/python" aider-chat

if [[ ! -f "$SCRIPT_DIR/.env" ]]; then
  cp "$SCRIPT_DIR/.env.example" "$SCRIPT_DIR/.env"
  echo
  echo "Готово. Открой $SCRIPT_DIR/.env и вставь свой DEEPSEEK_API_KEY, затем запускай ./run.sh"
else
  echo
  echo "Готово. Запускай ./run.sh"
fi
