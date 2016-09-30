#!/usr/bin/env bash

# print separator
function printSeparator() {
  echo "---------------------------------------------------------------------"
}

# print newline
function printNewline() {
  echo -e "\n"
}

function checkWebServerByTitle {
  # 检测HTTP的返回码，如果不是200则出现问题
  # http://superuser.com/questions/272265/getting-curl-to-output-http-status-code
  echo "检测$1的HTTP的状态码判断是否正常"
  HTTP_STATUS_CODE=$(curl -s -o /dev/null -I -w "%{http_code}" $1)
  if [[ $HTTP_STATUS_CODE -ne 200 ]]; then
    echo "$1 服务存在问题，HTTP的状态码是: $HTTP_STATUS_CODE"
  else
    echo $HTTP_STATUS_CODE
  fi

  # 检测URL的标题内容，，通过标题判断是否正常
  echo "检测$1的标题判断是否正常"
  charset=$(curl -I $1 | grep Content-Type | cut -d '=' -f 2)
  if [[ "$charset" == 'utf-8' ]]; then
    echo "The charset of the content is $charset"
    HTML_TITLE=$(curl -s $1 | iconv -f $charset -t UTF-8 | grep '<title>')
  else  
    HTML_TITLE=$(curl -s $1 | grep '<title>')
  fi  
  if [[ $? -ne 0 ]]; then
    echo "$1 服务存在问题，curl获取网页内容的返回码是: $?"
  else
    echo $HTML_TITLE
  fi
}