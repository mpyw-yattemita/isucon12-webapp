.PHONY: deploy
deploy:
	docker compose stop & \
	docker compose up -d
