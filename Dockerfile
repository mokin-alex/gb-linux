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
