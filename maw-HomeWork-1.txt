1. Установка VirtualBox
2. Новая VBox-Машина: 2Гб ОЗУ, 20Гб HDD
3. VirtualBox - Настройка Машины 
	- Общие - Дополнительно:
		Буфер обмена  = двусторонний 
		Драг-анд-дроп = двусторонний
	- Сеть - тип подключения = сетевой мост. (адрес будет получен по DHCP от роутера)

4. Установка Linux:
	- установили рускую локализацию
	- Установим переключение клавиатуры:
	Центр Управления - Клавиатура -> Раскладки - Параметры - Переключение на другую клавиатуру:
	выбираем например Alt-Shift
	- установка ДополненийОС: VirtualBox-Устройства-Подключить образ диска ДополненийОС.
	автозапуск диск, ввод пароля, установка. ок!
	
5. Установим ssh-сервер:
	Обновим кэш репозиториев:
	sudo apt-get update
	Установим:
	sudo apt-get install mc
	sudo apt-get install openssh-server

6. Генерируем ssh-ключи на стороне Клиента (Windows).

`C:\Users\Alex>ssh-keygen -m PEM -t rsa -b 4096
Generating public/private rsa key pair.
Enter file in which to save the key (C:\Users\Alex/.ssh/id_rsa): C:\Users\Alex/.ssh/rsa_linux
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in C:\Users\Alex/.ssh/rsa_linux.
Your public key has been saved in C:\Users\Alex/.ssh/rsa_linux.pub.
The key fingerprint is:
SHA256:dhM280zCGEnx7/vqOSrKczxeuQnlOT2AZXgWY/N+Om8 alex@myLenovo
The key's randomart image is:
+---[RSA 4096]----+
|       .+o=      |
|        .B =     |
|        o & o    |
|         B @     |
|        S = = .  |
|       . + B o   |
|       .. * *    |
|     .. =o +.*E  |
|      o=.o+o==o  |
+----[SHA256]-----+
`

7. Переадем (прописываем) открытый ключ на стороне Сервера (Linux)
Переносим rsa_linux.pub в вируальную машину (драг-анд-дроп).
В домашнем каталоге пользователя, в папке .ssh создаем файл для ключей авторизации и записываем туда наш публичный (открытый) ключ):
`
ale@mintol:~/.ssh$ >authorized_keys
ale@mintol:~/.ssh$ 
ale@mintol:~/.ssh$ cat rsa_linux.pub >>authorized_keys
`

8. Подключаемся к серверу:
`
ssh ale@192.168.2.101 -i C:\Users\Alex/.ssh/rsa_linux
The authenticity of host '192.168.2.101 (192.168.2.101)' can't be established.
ECDSA key fingerprint is SHA256:3iYCFH+4h1P7MR8VLCpZji7gj1OEU6WJ5mMUs9dXsUQ.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.2.101' (ECDSA) to the list of known hosts.
ale@mintol:~$ ls
 Видео   Документы   Загрузки   Изображения   Музыка   Общедоступные  'Рабочий стол'   Шаблоны
ale@mintol:~$
`

9. Настроим Fairwall:
Добавления порта ssh 22 в исключения фаервола ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

ale@mintol:~$ sudo ufw status verbose
[sudo] пароль для ale:
Состояние: активен
Журналирование: on (low)
По умолчанию: deny (входящие), allow (исходящие), disabled (маршрутизированные)
Новые профили: skip

В                          Действие    Из
-                          --------    --
22                         ALLOW IN    Anywhere
22 (v6)                    ALLOW IN    Anywhere (v6)

10. Добавление баннера ПЕРЕД ВХОДОМ в систему.
Предупреждающее сообщение SSH обычно находится в файлах ‘/etc/issue’ 
Откроем файл конфигурации SSH сервера: `/etc/ssh/sshd_config`
Укажем путь к нашему баннеру:
`Banner /etc/issue`
Сохраним изменения и перезапустим sshd:
`$ service sshd reload`

