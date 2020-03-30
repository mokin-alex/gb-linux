Домашнее задание к Уроку 2

1. Просмотреть содержимое директорий /etc, /proc, /home. Посмотреть пару произвольных файлов в /etc.
```
ale@mintol:~$ ls -a /proc
ale@mintol:~$ ls -a /home
ale@mintol:~$ ls -l /etc
ale@mintol:~$ cat /etc/hosts
127.0.0.1       localhost
127.0.1.1       mintol
# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

ale@mintol:~$ less /etc/networks

# symbolic names for networks, see networks(5) for more information# symbolic names for networks, see networks(5) for more information
link-local 169.254.0.0
/etc/networks (END) q
```

2. Выяснить, для чего предназначена команда cat. Используя данную команду, создайте два файла с данными, а затем объедините их в один. Просмотрите содержимое созданного файла. Переименуйте файл, дав ему новое имя.

```
ale@mintol:/tmp$ man cat
#cat - concatenate files and print on the standard output
#cat    Copy standard input to standard output.

ale@mintol:/tmp$ cat >myfile1.txt
Создадим ПЕРВЫЙ файл с помощью команды cat
^D

ale@mintol:/tmp$ cat >myfile2.txt
Создадим ВТОРОЙ файл с использование cat
^D

ale@mintol:/tmp$ ls *.txt
myfile1.txt  myfile2.txt

ale@mintol:/tmp$ cat myfile1.txt myfile2.txt >myfile3.txt

ale@mintol:/tmp$ ls *txt
myfile1.txt  myfile2.txt  myfile3.txt

ale@mintol:/tmp$ cat myfile3.txt
Создадим ПЕРВЫЙ файл с помощью команды cat
Создадим ВТОРОЙ файл с использование cat

ale@mintol:/tmp$ mv myfile3.txt myfileNEW.txt
ale@mintol:/tmp$ ls *txt
myfile1.txt  myfile2.txt  myfileNEW.txt

```

3. Создать несколько файлов. Создайте директорию, переместите файл туда. Удалите все созданные в этом и предыдущем задании директории и файлы.

```
ale@mintol:/tmp$ touch manyfiles{1..30}.txt
ale@mintol:/tmp$ ls *txt
manyfiles10.txt  manyfiles15.txt  manyfiles1.txt   manyfiles24.txt  manyfiles29.txt  manyfiles5.txt  myfile1.txt
manyfiles11.txt  manyfiles16.txt  manyfiles20.txt  manyfiles25.txt  manyfiles2.txt   manyfiles6.txt  myfile2.txt
manyfiles12.txt  manyfiles17.txt  manyfiles21.txt  manyfiles26.txt  manyfiles30.txt  manyfiles7.txt  myfileNEW.txt
manyfiles13.txt  manyfiles18.txt  manyfiles22.txt  manyfiles27.txt  manyfiles3.txt   manyfiles8.txt
manyfiles14.txt  manyfiles19.txt  manyfiles23.txt  manyfiles28.txt  manyfiles4.txt   manyfiles9.txt

ale@mintol:/tmp$ mkdir testdir

ale@mintol:/tmp$ mv *.txt ./testdir/

ale@mintol:/tmp$ ls *txt
ls: невозможно получить доступ к '*txt': Нет такого файла или каталога

ale@mintol:/tmp$ ls ./testdir/*txt
./testdir/manyfiles10.txt  ./testdir/manyfiles19.txt  ./testdir/manyfiles27.txt  ./testdir/manyfiles7.txt
./testdir/manyfiles11.txt  ./testdir/manyfiles1.txt   ./testdir/manyfiles28.txt  ./testdir/manyfiles8.txt
./testdir/manyfiles12.txt  ./testdir/manyfiles20.txt  ./testdir/manyfiles29.txt  ./testdir/manyfiles9.txt
./testdir/manyfiles13.txt  ./testdir/manyfiles21.txt  ./testdir/manyfiles2.txt   ./testdir/myfile1.txt
./testdir/manyfiles14.txt  ./testdir/manyfiles22.txt  ./testdir/manyfiles30.txt  ./testdir/myfile2.txt
./testdir/manyfiles15.txt  ./testdir/manyfiles23.txt  ./testdir/manyfiles3.txt   ./testdir/myfileNEW.txt
./testdir/manyfiles16.txt  ./testdir/manyfiles24.txt  ./testdir/manyfiles4.txt
./testdir/manyfiles17.txt  ./testdir/manyfiles25.txt  ./testdir/manyfiles5.txt
./testdir/manyfiles18.txt  ./testdir/manyfiles26.txt  ./testdir/manyfiles6.txt

ale@mintol:/tmp$ rm -r testdir
ale@mintol:/tmp$ ls testdir
ls: невозможно получить доступ к 'testdir': Нет такого файла или каталога
```

4. В ОС Linux скрытыми файлами считаются те, имена которых начинаются с символа “.”. Сколько скрытых файлов в вашем домашнем каталоге?
```
ale@mintol:~$ ls  .?* -ld | grep ^[d] | grep -v '\.\.'

drwxrwxr-x 13 ale  ale  4096 мар 25 22:08 .cache
drwxr-xr-x 15 ale  ale  4096 мая 17  2019 .config
drwx------  3 root root 4096 апр  3  2019 .dbus
drwx------  2 ale  ale  4096 мая 19  2019 .gconf
drwx------  3 ale  ale  4096 апр  3  2019 .gnupg
drwxrwxr-x  3 ale  ale  4096 мар 23 22:29 .linuxmint
drwxr-xr-x  3 ale  ale  4096 мар 28  2019 .local
drwx------  5 ale  ale  4096 апр  1  2019 .mozilla
drwx------  2 ale  ale  4096 мар 25 22:07 .ssh
drwxrwxr-x  3 ale  ale  4096 мар 28  2019 .thumbnails

ale@mintol:~$ ls  .?* -ld | grep ^[d] | grep -v '\.\.' | wc -l
10
```
5. Попробовать вывести с помощью команды cat содержимое всех файлов в директории /etc, перенаправив вывод в любой файл в директории /tmp, а ошибки в отдельный файл в домашнем каталоге...
```
ale@dv6:~$ cat /etc/* >/dev/null 2>>$HOME/error.txt

ale@dv6:~$ cat error.txt | wc -l
151

#Найдем только файлы, исключим каталоги:
ale@dv6:~$ cat error.txt | grep -v "Это каталог" |wc -l
6
```
6. Команда kill и сигналы завершения
Запустим в другом терминале команду: ping - она выполняется пока ее не завершишь.
```
ale@dv6:~$ ping mail.ru
PING mail.ru (94.100.180.201) 56(84) bytes of data.
64 bytes from mail.ru (94.100.180.201): icmp_seq=1 ttl=55 time=67.9 ms
64 bytes from mail.ru (94.100.180.201): icmp_seq=2 ttl=55 time=68.1 ms
```
В другом терминале найдем PID процесса команда ping 
Завершим ее сигналом -2 , т.е. что соответсвует Ctrl-C
```
ale@dv6:~$ ps aux |grep ping
ale      15668  0.0  0.0  23872  2512 pts/1    S+   19:21   0:00 ping mail.ru

ale@dv6:~$ kill -2 15668
```
В РЕЗУЛЬТАТЕ: В другом терминале команда завершится с выводом статистики работы:
```
64 bytes from mail.ru (94.100.180.200): icmp_seq=347 ttl=55 time=67.4 ms
--- mail.ru ping statistics ---
347 packets transmitted, 346 received, 0% packet loss, time 350586ms
rtt min/avg/max/mdev = 64.483/70.134/123.945/9.643 ms
```
Запустим ping вновь.
Завершим теперь сигналом -9 - жесткое прерывание процесса.
```
ale@dv6:~$ ps aux |grep ping
ale      15779  0.0  0.0  23872  2516 pts/1    S+   19:28   0:00 ping mail.ru
ale@dv6:~$ kill -9 15779
```
В РЕЗУЛЬТАТЕ: команда будет "убита" тут же без вывода итоговой статистики работы.
```
64 bytes from mail.ru (94.100.180.201): icmp_seq=42 ttl=55 time=68.0 ms
Убито
```
Можно так же "вежливо" попросить команду завершиться сигналом -15
```
64 bytes from mail.ru (94.100.180.201): icmp_seq=28 ttl=55 time=67.4 ms
64 bytes from mail.ru (94.100.180.201): icmp_seq=29 ttl=55 time=69.9 ms
Завершено
ale@dv6:~$ 

