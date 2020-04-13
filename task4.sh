#!/bin/bash

cat /etc/passwd |grep -v nobody | awk -F: '{if ($3 >= 1000) system("du -hs " $6)}' >/tmp/user.space


