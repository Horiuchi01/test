# フロントでUP
up:
	docker-compose up --build --remove-orphans

# バックグラウンド（別プロセス）でUP
daemon:
	docker-compose up --build --remove-orphans -d

# 停止
stop:
	docker-compose stop

# 削除
down:
	docker-compose down

# ボリュームも削除
destroy:
	docker-compose down --volumes

# コンテナに入る
# usage:
#     make bash
#     make bash CONT=db
CONT=php
bash:
	docker-compose exec container_${CONT} bash
