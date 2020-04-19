1. Dockerfile
```
# ------- базовый образ с dockerhub
FROM    python:3
# ------- копируем каталоги и их содержимое в те же каталоги контейнера
COPY    demo/* /tmp/mawapp/demo/
COPY    polls/* /tmp/mawapp/polls/
COPY    db.sqlite3 /tmp/mawapp/
COPY    requirements.txt /tmp/mawapp/
COPY    manage.py /tmp/mawapp/
# ------- создаем окружение для питона
RUN     pip install -r /tmp/mawapp/requirements.txt
# ------- устраняем ошибку You have 15 unapplied migration(s) перед стартом
RUN     python /tmp/mawapp/manage.py migrate
# ------- команда для старта сервиса
CMD     python /tmp/mawapp/manage.py runserver 0.0.0.0:8000
# ------- просто проверка наличия файлов:
RUN     ls -l -r /tmp/mawapp/
```

2. Собираем контейнер командой:
```
ale@dv6:~/maw-app$ sudo docker build . -t mawapp:latest
```
3. Запускаем контейнер и делаем проброс портов, что бы сервис был доступен по адресу и порту 8000 хостовой машины
```
ale@dv6:~/maw-app$ sudo docker run -ti -p 8000:8000 mawapp:latest
Performing system checks...

System check identified no issues (0 silenced).
April 18, 2020 - 08:54:10
Django version 2.0.8, using settings 'demo.settings'
Starting development server at http://0.0.0.0:8000/
Quit the server with CONTROL-C.
[18/Apr/2020 08:54:21] "GET / HTTP/1.1" 200 16348
[18/Apr/2020 08:54:21] "GET /static/admin/css/fonts.css HTTP/1.1" 304 0
[18/Apr/2020 08:54:24] "GET / HTTP/1.1" 200 16348
```
Теперь страница приложения доступна для всех устройств в общей сети по адресу 192.168.2.102:8000

4. Загружаем образ на DockerHub
 4.1 Регистрируемся.
 4.2 Логинимся на линуксовой хост-машине:
```
ale@dv6:~/maw-app$ sudo docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: mawapp
Password: 
Login Succeeded
```
 4.3 Помечаем локальный образ как будет называться удаленный образ
```
sudo docker tag mawapp:latest mawapp/gblinuxhw7:latest
```
 4.4 Отправляем образ в репозиторий:
```
ale@dv6:~/maw-app$ sudo docker push mawapp/gblinuxhw7:latest
The push refers to repository [docker.io/mawapp/gblinuxhw7]
46fe1ba63aa6: Pushed 
2e676bbd58ab: Pushed 
4487a627c7f9: Pushed 
ae3493e5bc6d: Pushed 
b10d91b4179b: Pushed 
c13ee08d554e: Pushed 
a2bbdf7f56a3: Pushed 
4df8d182d9a9: Mounted from library/python 
9b5579ca5981: Mounted from library/python 
105af2af9350: Mounted from library/python 
55109ad1bdfa: Mounted from library/python 
46829331b1e4: Mounted from library/python 
d35c5bda4793: Mounted from library/python 
a3c1026c6bcc: Mounted from library/python 
f1d420c2af1a: Mounted from library/python 
461719022993: Mounted from library/python 
latest: digest: sha256:c79e8474bc489f039a2252d048a7e158e559713fee96eb66325729ac839af938 size: 3676
```
4.5 Контейнер доступен: docker pull mawapp/gblinuxhw7




