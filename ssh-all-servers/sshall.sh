#!/bin/bash
# This shell script can generate ssh-keys on the host,
# then send the id_rsa.public to target servers listed in the file host_ip
#@Author: Vincent Stchu
#@Date: 2018-03-30

[ ! -f ~/.ssh/id_rsa.pub] && ssh-keygen -t rsa -P '' & > dev/null
while readline; do
    ip=`echo $line | cut -d " " -f1`
    username=`echo $line | cut -d " " -f2`
    password=`echo $line | cut -d " " -f3`
expect <<EOF
spawn ssh-copy-id -i ~/.ssh/id_rsa.pub $username@$ip
expect {
    "yes/no" { send "yes\n";exp_continue}
    "password" { send "$password\n"}
}
expect eof
EOF
done < ~/host_ip