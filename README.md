# deepseek-agent-cli

Агентская CLI-обёртка в духе Claude Code / Codex, работающая на модели
**DeepSeek** (`deepseek-chat` / `deepseek-reasoner`). Под капотом —
[Aider](https://aider.chat), который делает всю агентскую механику (читает
репозиторий, предлагает и применяет правки, коммитит); саму интеллектуальную
часть (понимание кода, генерация правок) выполняет DeepSeek через его API.

Изолированный Python 3.12 ставится через [uv](https://astral.sh/uv) —
без sudo и без конфликтов с системным Python.

## Установка

```bash
git clone <ссылка-на-этот-репозиторий>
cd deepseek-agent-cli
./setup.sh
```

Скрипт сам поставит `uv` (если его нет), Python 3.12 и Aider в локальный
`.venv` внутри этой папки — ничего в системе не меняется.

## Настройка ключа

1. Получи API key на https://platform.deepseek.com (нужен баланс на счёте —
   у DeepSeek предоплата).
2. Открой `.env` (появится после `setup.sh`, или скопируй вручную из
   `.env.example`) и вставь ключ:

   ```
   DEEPSEEK_API_KEY=sk-...
   ```

Ключ — твой личный секрет, не коммить `.env` в git (он уже в `.gitignore`).

## Запуск

```bash
./run.sh
```

Запустится интерактивный агентский чат Aider в текущей директории (или
передай любые аргументы Aider напрямую, например `./run.sh --message "..."`).

По умолчанию используется модель `deepseek/deepseek-chat`. Чтобы переключиться
на `deepseek-reasoner`, задай переменную окружения:

```bash
AIDER_DEEPSEEK_MODEL=deepseek/deepseek-reasoner ./run.sh
```

## Как это работает

- `setup.sh` — ставит `uv`, Python 3.12, создаёт `.venv`, устанавливает
  `aider-chat`.
- `run.sh` — подхватывает `DEEPSEEK_API_KEY` из `.env`, запускает
  `aider --model deepseek/...`.
- Вся агентская логика (диффы, git-коммиты, контекст файлов) — от Aider;
  вся "смысловая" работа (что писать, как чинить код) — от DeepSeek.
