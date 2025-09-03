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
