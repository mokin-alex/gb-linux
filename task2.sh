#!/bin/bash 

usage(){
cat << eof
Скрипт анализа ошибок входа в систему,
выводит последние 10 неудачных входов в систему.
запуск: $0 start
eof
}

[[ $# == 0 ]]    && usage && exit 0
[[ $1 == "-h" ]] && usage && exit 0
[[ $1 == "--help" ]] && usage && exit 0
[[ $1 == "start" ]] &&
while true ; do
    cat /var/log/auth.log | grep "authentication failure" | grep pam_unix |  gawk '{
        if ($5 ~ /login*/) terminal="TTY" ; 
        if ($5 ~ /ssh/) terminal="SSH" ;
        if ($5 ~ /lightdm/) terminal="CON";
        print "authentication failure at ",$1,$2,$3,"--",terminal":",$5,$12,$13,$14,$15}' >/tmp/auth.err
    clear
    tail /tmp/auth.err
    sleep 30
done

