#!/usr/bin/env bash

. ./utils.sh

ELEARNING_DOMAIN_NAME=elearning.ynu.edu.cn

# 检测Elearning Web相关服务是否正常
echo "检测Elearning Web相关服务是否正常"
printSeparator
echo "Elearning网络教学平台：http://elearning.ynu.edu.cn/"
checkWebServerByTitle $ELEARNING_DOMAIN_NAME/meol/homepage/common/
printSeparator
printSeparator
echo "教学资源库：http://elearning.ynu.edu.cn/moocresource/"
checkWebServerByTitle $ELEARNING_DOMAIN_NAME/moocresource/index/index.jsp
printSeparator
printSeparator
echo "质量工程平台：http://zlgc.ynu.edu.cn/"
checkWebServerByTitle http://zlgc.ynu.edu.cn/zlgc/index.do
printSeparator

printNewline

# 检测Elearning相关服务器及数据库状态
echo "检测Elearning相关服务器及数据库状态"
WEB_SERVER_HOST=113.55.12.56
VIDEO_SERVER_HOST=113.55.12.57
ORACLE_SERVER_HOST=113.55.12.58
printSeparator
echo "检测Web服务相关进程是否正常"
echo "/root/tomcat_homepage status && /root/tomcat_mooc status && /root/apache2 status"
ssh root@$WEB_SERVER_HOST "/root/tomcat_homepage status"
ssh root@$WEB_SERVER_HOST "/root/tomcat_mooc status"
ssh root@$WEB_SERVER_HOST "/root/apache2 status"
printSeparator
echo "检测流媒体服务器相关进程是否正常"
echo "/root/tomcat_moocvideo status && service nginx status"
ssh root@$VIDEO_SERVER_HOST "/root/tomcat_moocvideo status"
ssh root@$VIDEO_SERVER_HOST "service nginx status"
printSeparator
echo "检测数据库服务器相关进程是否正常"
echo "runuser -l oracle -c 'lsnrctl status' 2>/dev/null"
ssh root@$ORACLE_SERVER_HOST "runuser -l oracle -c 'lsnrctl status' 2>/dev/null"
printSeparator
echo "检测数据库服务器备份定时任务是否正常"
echo "runuser -l oracle -c 'crontab -l' 2>/dev/null"
ssh root@$ORACLE_SERVER_HOST "runuser -l oracle -c 'crontab -l' 2>/dev/null"


