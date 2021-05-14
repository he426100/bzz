#!/usr/bin/env bash
ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
mkdir -p keys
cntFile=".showcnt.txt"
if [ ! -f $cntFile ]; then
echo "未运行step1！"
exit
fi

echo "下载密钥至本地……"
cp /var/lib/bee/password ./keys
mv ./keys/password ./keys/${ip}-password.txt
sz ./keys/*
rm -r ./keys
