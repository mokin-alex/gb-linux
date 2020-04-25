0) Добавил в hospital_db.sql две строки, иначе таблицы не будут создаваться автоматически.
```
CREATE DATABASE hospital_db;
USE hospital_db;
```

1) MySQL dockerfile:
```
FROM	mysql/mysql-server:latest
#запишем sql-запрос в каталог для инициализации базы
COPY	hospital_db.sql /docker-entrypoint-initdb.d
```

2) sudo docker build . -t mawsql -f DockerfileMySQL
Successfully built f11160185e39
Successfully tagged mawsql:latest

3) Запускаем контейнер:
``` 
sudo docker run -ti -p 3306:3306 -p 33060:33060 mawsql
[Entrypoint] running /docker-entrypoint-initdb.d/hospital_db.sql
[Entrypoint] GENERATED ROOT PASSWORD: wup3qUmAsAKn0z3bVeq7ijlyzpI
```
4) Входим в строку mysql для смены пароля на постоянный:
```
 sudo docker exec -it 664ecd0d0b55 mysql -uroot -p
Enter password: вводим одноразовый пароль из пункта 3
```
Создаем пароль постоянный:
```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'admin';
Query OK, 0 rows affected (0.09 sec)
```
6) Проверим отработал ли скрипт при старте контейнера mawsql
```
mysql> use hospital_db;
mysql> select * from doctors;
+----+-------------+-------------------------+--------------------------------------------------------------+-------------+--------+------------+---------------------+
| id | name        | email                   | password                                                     | phone       | gender | specialist | created             |
+----+-------------+-------------------------+--------------------------------------------------------------+-------------+--------+------------+---------------------+
|  1 | Ahsan Saeed | ahsansaeed067@gmail.com | Vm0xMFlWbFdWWGhVYmxKWFltdHdVRlpzV21GWFJscHlWV3RLVUZWVU1Eaz0= | 03218878961 |      0 | Heart      | 2018-05-01 13:07:24 |
+----+-------------+-------------------------+--------------------------------------------------------------+-------------+--------+------------+---------------------+
1 row in set (0.00 sec)
```

7) sudo docker build . -t mawphp2 -f DockerfilePHP
```
ale@dv6:~/mawapp$ sudo docker run -ti -p 9000:9000 --hostname php mawphp2 
[25-Apr-2020 09:33:55] NOTICE: fpm is running, pid 1
[25-Apr-2020 09:33:55] NOTICE: ready to handle connections
```

8) sudo docker build . -t mawnginx -f DockerfileNginx
FROM nginx:latest 
COPY website.conf /etc/nginx/conf.d/

Successfully built 222e525f1846
Successfully tagged mawnginx:latest

10) sudo docker run -ti -p 8080:8080 -v $(pwd)/website.conf:/etc/nginx/conf.d/website.conf mawnginx 

11) ale@dv6:~/mawapp$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                   PORTS                                              NAMES
d48cf629d84f        mawsql              "/entrypoint.sh mysq…"   2 minutes ago       Up 2 minutes (healthy)   0.0.0.0:3306->3306/tcp, 0.0.0.0:33060->33060/tcp   zealous_hodgkin
f47c43d872d6        mawnginx            "nginx -g 'daemon of…"   18 minutes ago      Up 18 minutes            80/tcp, 0.0.0.0:8080->8080/tcp                     serene_chaplygin
fea6cac2be57        mawphp2             "php-fpm7"               5 hours ago         Up 5 hours               0.0.0.0:9000->9000/tcp                             infallible_dubinsky



