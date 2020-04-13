#!/bin/bash 

usage(){
cat << eof
В указанной с помощью параметра -d директории создает указанные файлы,
а так же созданным файлам, имеющим разширение '.sh' дает права на выполнение.
Пример: $0 -d /tmp/task_3 file1 file2.sh file3
eof
}

[[ $# == 0 ]]    && usage && exit 0
[[ $1 == "-h" ]] && usage && exit 0
[[ $1 == "--help" ]] && usage && exit 0
[[ $1 != "-d" ]] && echo "Ошибка: отсутвует ключ -d" && exit 1 
shift

if [[ -d $1 ]]; then
    DIRNAME=$1
else
    echo "Ошибка: не существует каталога, указанного после ключа -d"
    exit 2
fi
shift

[[ $# -eq 0 ]] && echo "Ошибка: не указаны файлы для создания" && exit 3

while [[ $# -gt 0 ]] ; do

  [[ $1 == "-d" ]]       && echo "Ошибка: повторное использование ключа -d" && exit 4
  [[ -e ${DIRNAME}/$1 ]] && echo "Предупреждение: файл ${DIRNAME}/${1} уже существует!" && shift && continue

  touch ${DIRNAME}/$1
  echo $1 |grep -P '(\.sh)$' 1>>/dev/null && chmod +x ${DIRNAME}/$1

  shift
done
