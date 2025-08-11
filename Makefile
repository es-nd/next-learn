COMPOSE ?= docker compose

.PHONY: up down stop logs ps bash psql reset clean status

up:
	$(COMPOSE) up

down:
	$(COMPOSE) down

reup:
	$(COMPOSE) down up

stop:
	$(COMPOSE) stop

logs:
	$(COMPOSE) logs -f

# コンテナ内で bash（psql クライアント入ってます）
bash:
	$(COMPOSE) exec db bash

# 直接 psql を開く（パスワードは env のを利用）
psql:
	$(COMPOSE) exec -e PGPASSWORD=password db psql -U user -d sample

# ボリュームも含めて完全リセット（データ消えます）
reset:
	$(COMPOSE) down -v

# 未使用ボリュームまで掃除（慎重に）
clean:
	docker volume prune -f

status:
	$(COMPOSE) ps
