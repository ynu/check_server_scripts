#!/usr/bin/env bash

. ./utils.sh

# check the two standalone dns server
DNS_SERVER_HOST=("202.203.208.33" "202.203.208.34" )

for SERVER_HOST in "${DNS_SERVER_HOST[@]}"
do
  echo "Testing ${SERVER_HOST} functionalities"
  
  # check ping
  echo "ping -c 4 ${SERVER_HOST}"
  printSeparator
  ping -c 4 ${SERVER_HOST}
  printSeparator
  
  # nslookup some common domain including intranet and internet
  intranet_domains=(  "www.ynu.edu.cn" "www.lib.ynu.edu.cn" "cm.ynu.edu.cn" "webmail.ynu.edu.cn" "ecard.ynu.edu.cn" "ids.ynu.edu.cn" "elearning.ynu.edu.cn" )
  internet_domains=(  "www.baidu.com" "www.qq.com" "weibo.com" "www.163.com" "www.csdn.net" "www.youku.com" )
  for $domain in "${intranet_domains[@]}"
  do
    echo "nslookup intranet domain: $domain using ${SERVER_HOST}"
    printSeparator
    nslookup $domain ${SERVER_HOST}
    printSeparator
  done
  for domain in "${internet_domains[@]}"
  do
    echo "nslookup internet domain: $domain using ${SERVER_HOST}"
    printSeparator
    nslookup $domain ${SERVER_HOST}
    printSeparator
  done
  printNewline
  
done
