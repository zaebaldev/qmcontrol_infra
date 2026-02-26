DC = docker compose
EXEC = docker exec -it
LOGS = docker logs

POSTGRES_FILE = postgres.yaml
RABBITMQ_FILE = rabbitmq.yaml
ADMINER_FILE = adminer.yaml
REDIS_FILE = redis.yaml
KRAKEN_FILE = kraken.yaml
ENV= --env-file .env


.PHONY: network
network:
	docker network create qcontrol_network

.PHONY: adminer
adminer:
	${DC} -f ${ADMINER_FILE} up -d
.PHONY: adminer-down
adminer-down:
	${DC} -f ${ADMINER_FILE} down

.PHONY: pg
pg:
	${DC} -f ${POSTGRES_FILE}  -f ${ADMINER_FILE} ${ENV} up --build -d
.PHONY: pg-down
pg-down:
	${DC} -f ${POSTGRES_FILE} -f ${VOLUMES_FILE} -f ${ADMINER_FILE} down

.PHONY: redis
redis:
	${DC} -f ${REDIS_FILE} -f ${VOLUMES_FILE} ${ENV} up -d
.PHONY: redis-down
redis-down:
	${DC} -f ${REDIS_FILE} -f ${VOLUMES_FILE} down

.PHONY: rabbitmq
rabbitmq:
	${DC} -f ${RABBITMQ_FILE} -f ${VOLUMES_FILE} ${ENV} up -d

.PHONY: rabbitmq-down
rabbitmq-down:
	${DC} -f ${RABBITMQ_FILE} -f ${VOLUMES_FILE} down

.PHONY: kraken
kraken:
	${DC} -f ${KRAKEN_FILE} ${ENV} up --build -d
.PHONY: kraken-down
kraken-down:
	${DC} -f ${KRAKEN_FILE} down

.PHONY: all
all:
	${DC} -f compose.yaml ${ENV} up --build -d

.PHONY: all-down
all-down:
	${DC} -f compose.yaml down