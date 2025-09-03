#!/usr/bin/env bash
set -euo pipefail

echo "[post-create] mix / hex のセットアップ確認..."

# Phoenix の新規作成ガイド表示（mix.exs がまだ無い場合）
if [ ! -f mix.exs ]; then
  cat <<'MSG'
[post-create] まだ mix.exs がありません。
  新規 Phoenix を作るには:

    mix phx.new demo_app --database postgres
    cd demo_app
    mix ecto.create

  起動:
    make server   # http://localhost:4000
MSG
fi

# 便利 Makefile（無ければ生成）
if [ ! -f Makefile ]; then
  cat > Makefile <<'MAKE'
PHX?=phx.server

help:
	@echo "make deps       # mix deps.get"
	@echo "make setup      # 初回: deps/assets/ecto セットアップ"
	@echo "make db-setup   # mix ecto.create && mix ecto.migrate"
	@echo "make server     # mix phx.server"

deps:
	mix deps.get

setup: deps
	[ -f assets/package.json ] && (cd assets && npm install) || true
	mix ecto.create || true
	mix ecto.migrate || true

db-setup:
	mix ecto.create || true
	mix ecto.migrate || true

server:
	mix $(PHX)
MAKE
fi

echo "[post-create] 完了。Run and Debug から 'mix phx.server' で起動できます。"
