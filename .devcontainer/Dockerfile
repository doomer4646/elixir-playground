FROM elixir:1.17

# ---- 基本ツール & Node.js (Phoenixのassets用) ----
ARG DEBIAN_FRONTEND=noninteractive
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    locales tzdata git curl ca-certificates build-essential \
    inotify-tools wget gnupg2 make unzip openssl \
    postgresql-client \
  ; \
  echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen; \
  locale-gen; \
  ln -snf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && echo Asia/Tokyo > /etc/timezone; \
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash -; \
  apt-get install -y --no-install-recommends nodejs; \
  npm --version; node --version; \
  rm -rf /var/lib/apt/lists/*

# ---- 非rootユーザー ----
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid ${USER_GID} ${USERNAME} \
  && useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

ENV LANG=ja_JP.UTF-8 \
    LC_ALL=ja_JP.UTF-8 \
    MIX_HOME=/home/${USERNAME}/.mix \
    HEX_HOME=/home/${USERNAME}/.hex

USER ${USERNAME}
WORKDIR /workspace

# ---- Elixir周り（hex / rebar / phoenix installer）----
RUN set -eux; \
  mix local.hex --force; \
  mix local.rebar --force; \
  mix archive.install hex phx_new --force

# ---- 便利スクリプト: post-create ----
RUN mkdir -p /workspace/.devcontainer && \
  printf '%s\n' \
'#!/usr/bin/env bash' \
'set -euo pipefail' \
'echo "[post-create] mix/hex のチェックと便利タスクを用意します…"' \
'# Phoenix新規作成テンプレ:' \
'if [ ! -f mix.exs ]; then' \
'  echo "[post-create] 既存mix.exsが無いので新規プロジェクトは以下で作成可能:"' \
'  echo "  mix phx.new demo_app --database postgres"' \
'fi' \
'' \
'# 既存 or 作成後に有効な便利Makefileを生成（無ければ）' \
'if [ ! -f Makefile ]; then' \
'  cat <<MAKE > Makefile' \
'PHX?=phx.server' \
'DB_URL?=postgres://postgres:postgres@db:5432/postgres' \
'' \
'help:' \
'\t@echo "make deps       # mix deps.get"' \
'\t@echo "make setup      # 初回: deps/assets/ecto セットアップ"' \
'\t@echo "make db-setup   # mix ecto.create && mix ecto.migrate"' \
'\t@echo "make server     # mix phx.server"' \
'' \
'deps:' \
'\tmix deps.get' \
'' \
'setup: deps' \
'\t[ -f assets/package.json ] && (cd assets && npm install) || true' \
'\tmix ecto.create || true' \
'\tmix ecto.migrate || true' \
'' \
'db-setup:' \
'\tmix ecto.create || true' \
'\tmix ecto.migrate || true' \
'' \
'server:' \
'\tmix ${PHX}' \
'MAKE' \
'fi' \
'' \
'echo "[post-create] 完了。VS Code の Run/Debug から server を起動できます。"' \
  > /workspace/.devcontainer/post-create.sh && \
  chmod +x /workspace/.devcontainer/post-create.sh

