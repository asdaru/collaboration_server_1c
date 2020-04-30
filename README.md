# 1С: Сервер взаимодействия docker 


## Запуск

### Запустить контейнер с посгрес
```
docker run -d --name postgres -e POSTGRES_PASSWORD=myPassword -d postgres
```
### Создать базу
```
docker exec -ti --user postgres  postgres psql

Вводим
CREATE DATABASE cs OWNER postgres;
\c cs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

### Запустить сервер взаимодействия

```
docker run -ti --name 1ccommunicationserver --link postgres:postgres -e POSTGRES_URL=postgress:5432/cs -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=myPassword -p 8181:8181 asdaru/collaboration_server_1c
```


