#!/usr/bin/env bash
ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
mkdir -p keys
cntFile=".showcnt.txt"
if [ ! -f $cntFile ]; then
echo "未运行step1！"
exit
fi

tCnt=`cat $cntFile`
for ((i=1; i<=tCnt; i ++))
do
echo "对第$i个节点添加自动提取。"
cp /dataCache/bee/node${i}/keys/swarm.key ./keys
mv ./keys/swarm.key ./keys/${ip}-${i}.key
echo "00 02 * * * /root/cashout${i}.sh cashout-all" >> /etc/crontab
screen -dmS bee$i
screen -x -S bee$i -p 0 -X stuff "bee start --config node${i}.yaml"
screen -x -S bee$i -p 0 -X stuff $'\n'
echo "第$i个节点已启动。"
screen -ls
done
echo "下载密钥至本地……"
cp /dataCache/bee/password ./keys
mv ./keys/password ./keys/${ip}-password.txt
sz ./keys/*
rm -r ./keys
