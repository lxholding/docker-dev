docker run --name "percona-5.7" -p 3306:3306 -v "/Users/lixin/work/docker-volume/database/data":/var/lib/mysql -v "/Users/lixin/work/docker-volume/database/log":/var/log/mysql -e MYSQL_ROOT_PASSWORD=123 -d percona:5.7

docker run --name "redis-4.0" -p 6379:6379 -v "/Users/lixin/work/docker-volume/redis":/data -d redis:4.0-alpine
