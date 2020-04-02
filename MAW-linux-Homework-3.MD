1. Создание ссылок:
```
ale@dv6:~$ cd /tmp
ale@dv6:/tmp$ echo "наполнить его произвольным содержимым." >>file1
ale@dv6:/tmp$ cp file1 file2
#сивольная ссылка
ale@dv6:/tmp$ ln -s file1 file3

#жесткая ссылка
ale@dv6:/tmp$ ln file1 file4

ale@dv6:/tmp$ ls -ila file*
4608421 -rw-rw-r-- 2 ale ale 438 апр  2 08:05 file1
4608422 -rw-rw-r-- 1 ale ale 438 апр  2 08:06 file2
4608423 lrwxrwxrwx 1 ale ale   5 апр  2 08:10 file3 -> file1
4608421 -rw-rw-r-- 2 ale ale 438 апр  2 08:05 file4

ale@dv6:/tmp$ rm file1

#После удаления вывод вайла по символьной ссылке file3 невозможен
ale@dv6:/tmp$ cat file3
cat: file3: Нет такого файла или каталога

#Но вывод жетской ссылки file4 выполняется успешно, так как она ссылается на то же "место на устройстве", т.е. на туже ноду. 
ale@dv6:/tmp$ cat file4
наполнить его произвольным содержимым.
```

2. Работа со ссылками:
```
ale@dv6:/tmp$ mv file1 file1new
ale@dv6:/tmp$ ln -s file1new file1newlnk
ale@dv6:/tmp$ ln    file1new file1newlnkh

ale@dv6:/tmp$ ls -ila *new*
4608586 -rw-rw-r-- 2 ale ale 77 апр  2 12:45 file1new
4608562 lrwxrwxrwx 1 ale ale  8 апр  2 12:49 file1newlnk -> file1new
4608586 -rw-rw-r-- 2 ale ale 77 апр  2 12:45 file1newlnkh
```
Переместеим ВСЕ созданные ссылки в другую директорию
```
ale@dv6:/tmp$ mkdir test
ale@dv6:/tmp$ mv *lnk* ./test/
ale@dv6:/tmp/test$ ls -il
4608562 lrwxrwxrwx 1 ale ale  8 апр  2 12:49 file1newlnk -> file1new
4608586 -rw-rw-r-- 2 ale ale 77 апр  2 12:45 file1newlnkh
```
При этом нельзя вывести на экран символическую сслыку file1newlnk, так как в текущей директории нет файла file1new (он остался в /tmp)
Но жесткая ссылка напротив успешно выводит результат, так как привязана жестко к ноде файла.
```
ale@dv6:/tmp/test$ cat file1newlnkh
наполнить его произвольным содержимым 123.
```
3. Права файлов:
```
ale@dv6:/tmp/test$ echo "ФАЙЛ номер 1" >myfile1
ale@dv6:/tmp/test$ echo "ФАЙЛ номер 2" >myfile2

ale@dv6:/tmp/test$ chmod ug=rw,o=r myfile1

ale@dv6:/tmp/test$ chmod 600 myfile2
# или
ale@dv6:/tmp/test$ chmod u=rw,go=- myfile2

ale@dv6:/tmp/test$ ls -l myfile*
-rw-rw-r-- 1 ale ale 22 апр  2 13:09 myfile1
-rw------- 1 ale ale 22 апр  2 13:09 myfile2
```

4. Создать пользователя, обладающего возможностью выполнять действия от имени суперпользователя.
```
useradd -m -G sudo -s /bin/bash admuser
sudo passwd admuser
```
5. Создать группу developer, несколько пользователей, входящих в эту группу. Создать директорию для совместной работы. Сделать так, чтобы созданные одними пользователями файлы могли изменять другие пользователи этой группы.
```
ale@dv6:/opt$ sudo groupadd developer
ale@dv6:/opt$ sudo useradd -m -G developer -s /bin/bash petrov
ale@dv6:/opt$ sudo useradd -m -G developer -s /bin/bash ivanov

ale@dv6:/opt$ sudo mkdir developer
ale@dv6:/opt$ sudo chown root:developer developer
ale@dv6:/opt$ sudo chmod g+s developer
```
6. не успел данный пункт

7. * Создать директорию, в которой есть несколько файлов. Сделать так, чтобы открыть файлы можно только, зная имя файла, а через ls список файлов посмотреть нельзя.
Для выполнения данной задачи достаточно снять атрибут "чтение" для директории для всех пользователей и групп.
```
ale@dv6:~$ cd /tmp
ale@dv6:/tmp$ mkdir hidendir
ale@dv6:/tmp$ cd hidendir
ale@dv6:/tmp/hidendir$ touch MySecFile{1..3}
ale@dv6:/tmp/hidendir$ echo "My secret file's content" >>MySecFile1
ale@dv6:/tmp/hidendir$ echo "My secret file's content" >>MySecFile2
ale@dv6:/tmp/hidendir$ echo "My secret file's content" >>MySecFile3

ale@dv6:/tmp$ chmod -r hidendir

ale@dv6:/tmp$ ls hidendir/*
ls: невозможно получить доступ к 'hidendir/*': Нет такого файла или каталога
ale@dv6:/tmp$ cat hidendir/MySecFile2
My secret file's content

le@dv6:/tmp$ echo "super secret" >hidendir/MySecF
ale@dv6:/tmp$ cat hidendir/MySecF
super secret
```




