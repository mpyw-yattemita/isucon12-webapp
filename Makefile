.PHONY: deploy
deploy:
	docker compose stop & \
	docker compose up -d --build

scp-nginx:
	ssh isucon@35.78.161.76 "sudo dd of=/etc/nginx/nginx.conf" < ./etc/nginx/nginx.conf
	ssh isucon@35.78.161.76 "sudo dd of=/etc/nginx/sites-available/isuports.conf" < ./etc/nginx/sites-available/isuports.conf

restart-nginx:
	ssh isucon@35.78.161.76 "sudo systemctl restart nginx"

deploy-nginx: scp-nginx restart-nginx

scp-mysql:
	ssh isucon@35.78.161.76 "sudo dd of=/etc/mysql/mysql.conf.d/mysqld.cnf" < ./etc/mysql/mysql.conf.d/mysqld.cnf & \
	ssh isucon@18.181.52.131 "sudo dd of=/etc/mysql/mysql.conf.d/mysqld.cnf" < ./etc/mysql/mysql.conf.d/mysqld.cnf & \
	ssh isucon@35.79.204.162 "sudo dd of=/etc/mysql/mysql.conf.d/mysqld.cnf" < ./etc/mysql/mysql.conf.d/mysqld.cnf & \
	wait

restart-mysql:
	ssh isucon@35.78.161.76 "sudo systemctl restart mysql" & \
	ssh isucon@18.181.52.131 "sudo systemctl restart mysql" & \
	ssh isucon@35.79.204.162 "sudo systemctl restart mysql" & \
	wait

deploy-mysql: scp-mysql restart-mysql
