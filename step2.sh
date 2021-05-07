#!/usr/bin/env bash
cntFile=".showcnt.txt"
if [ ! -f $cntFile ]; then
echo "未运行step1！"
exit
fi

tCnt=`cat $cntFile`
for ((i=1; i<=tCnt; i ++))
do
bee start   \
--config /etc/bee/bee${i}.yaml
done
sz /var/lib/bee/keys${tCnt}/swarm.key /var/lib/bee/password
