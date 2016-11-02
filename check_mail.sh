#!/usr/bin/env bash

. ./utils.sh

# mail host ip
MAIL_SERVER_HOST=202.203.208.32
MAIL_SERVER_DOMAIN_NAME=webmail.ynu.edu.cn
MAIL_SERVER_SLAVE_HOST=113.55.12.132

# 检测邮箱Web相关服务是否正常
echo "检测邮箱Web相关服务是否正常"
printSeparator
echo "检测 $MAIL_SERVER_DOMAIN_NAME"
checkWebServerByTitle $MAIL_SERVER_DOMAIN_NAME
echo "检测 $MAIL_SERVER_DOMAIN_NAME/webadm"
checkWebServerByTitle $MAIL_SERVER_DOMAIN_NAME/webadm
echo "检测 $MAIL_SERVER_DOMAIN_NAME:8080/gw/admin/"
checkWebServerByTitle $MAIL_SERVER_DOMAIN_NAME:8080/gw/admin/
printSeparator

printNewline

# 检测服务器连通性，使用ping
echo "ping -c 4 ${MAIL_SERVER_HOST}"
printSeparator
ping -c 4 ${MAIL_SERVER_HOST}
printSeparator

printNewline

# 检测同步操作状态
echo "ssh root@${MAIL_SERVER_HOST} tail /usr/local/eyou/mail/log/phpd.log"
printSeparator
ssh root@${MAIL_SERVER_HOST} tail /usr/local/eyou/mail/log/phpd.log
printSeparator

printNewline

# 检查备机mysql数据库实时备份是否正常
echo "检查备机mysql数据库实时备份是否正常"
printSeparator
echo "ssh root@${MAIL_SERVER_HOST} \"mysql -h 127.0.0.1 eyou_mail -s -e 'show master status\G' | grep 'Position'\""
ssh root@${MAIL_SERVER_HOST} "mysql -h 127.0.0.1 eyou_mail -s -e 'show master status\G' | grep 'Position'"
echo "ssh root@${MAIL_SERVER_SLAVE_HOST} \"mysql -h 127.0.0.1 eyou_mail -s -e 'show slave status\G' | grep 'Slave\|Exec_Master_Log_Pos'\""
ssh root@${MAIL_SERVER_SLAVE_HOST} "mysql -h 127.0.0.1 eyou_mail -s -e 'show slave status\G' | grep 'Slave\|Exec_Master_Log_Pos'"
printSeparator
echo "Compare Position and Exec_Master_Log_Pos, check Slave_IO_Running/ Slave_SQL_Running is YES"
printSeparator

printNewline

# 检查端口服务是否正常
echo "检查端口服务是否正常"
printSeparator
echo "nc -zv ${MAIL_SERVER_HOST} 25"
nc -zv ${MAIL_SERVER_HOST} 25
echo "nc -zv ${MAIL_SERVER_HOST} 110"
nc -zv ${MAIL_SERVER_HOST} 110
echo "nc -zv ${MAIL_SERVER_SLAVE_HOST} 25"
nc -zv ${MAIL_SERVER_SLAVE_HOST} 25
echo "nc -zv ${MAIL_SERVER_SLAVE_HOST} 110"
nc -zv ${MAIL_SERVER_SLAVE_HOST} 110
printSeparator

printNewline

# 检查eyou_mail状态
echo "检查eyou_mail状态"
printSeparator
echo "ssh root@${MAIL_SERVER_HOST} \"tail /usr/local/eyou/mail/log/mta.log\""
printSeparator
ssh root@${MAIL_SERVER_HOST} "tail /usr/local/eyou/mail/log/mta.log"
printSeparator
echo "ssh root@${MAIL_SERVER_HOST} eyou_mail watch"
printSeparator
ssh root@${MAIL_SERVER_HOST} eyou_mail watch
printSeparator
echo "ssh root@${MAIL_SERVER_HOST} /var/emdg/sbin/checkproc"
printSeparator
ssh root@${MAIL_SERVER_HOST} /var/emdg/sbin/checkproc
printSeparator

printNewline

