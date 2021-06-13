cntFile=".showcnt.txt"
epFile="epFile.txt"
if [ ! -f $cntFile ]; then
        echo "未运行step1！"
        exit
fi
tCnt=`cat $cntFile`
ep=`cat $epFile`

processId=`ps -ef|grep bee|grep -v grep|grep -v sh|grep -v PPID|awk '{ print $2}'`
for i in $processId
do
   kill -9 $i
done
echo "************************************************************"

for ((i=1; i<=tCnt; i ++))
do
        screen -S bee$i -X quit
done

screen -wipe
screen -ls
