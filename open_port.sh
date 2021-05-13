cntFile=".showcnt.txt"
tCnt=`cat $cntFile`
for ((i=1; i<=tCnt; i ++))
do
screen -S bee$i -X quit
sed -i 's#/etc/bee#/root#g' node${i}.yaml
sed -i 's/127.0.0.1//' node${i}.yaml
echo "已修改debug端口。"
screen -dmS bee$i
screen -x -S bee$i -p 0 -X stuff "bee start --config node${i}.yaml"
screen -x -S bee$i -p 0 -X stuff $'\n'
echo "第$i个节点已重启。"
done
sed -i '/cashout/d' /etc/crontab
screen -ls
