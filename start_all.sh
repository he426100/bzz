cntFile=".showcnt.txt"
epFile="epFile.txt"
if [ ! -f $cntFile ]; then
        echo "未运行step1！"
        exit
fi
tCnt=`cat $cntFile`
ep=`cat $epFile`

for ((i=1; i<=tCnt; i ++))
do
        screen -dmS bee$i
        screen -x -S bee$i -p 0 -X stuff "bee start --config node${i}.yaml"
        screen -x -S bee$i -p 0 -X stuff $'\n'
        echo "第$i个节点已启动。"
        sleep 2
done
