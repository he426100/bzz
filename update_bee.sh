#!/usr/bin/env bash
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
cat>node${i}.yaml<<EOF
api-addr: :$((1534+${i}))
data-dir: /var/lib/bee/node${i}
cache-capacity: "2000000"
block-time: "15"
#bootnode:
#- /dnsaddr/bootnode.ethswarm.org
debug-api-addr: :$((1634+${i}))
#debug-api-addr: 127.0.0.1:$((1634+${i}))
debug-api-enable: true
p2p-addr: :$((1734+${i}))
password-file: /var/lib/bee/password
swap-initial-deposit: "10000000000000000"
verbosity: 3
swap-endpoint: ${ep}
full-node: true
welcome-message: "欢迎来到无产阶级社群，MY NAME IS DADAGUAI WECHAT:dislike_diss"
EOF
done
ver=`dpkg -l | grep "bee" | grep "0.5.3"`
wget https://github.com/ethersphere/bee/releases/download/v0.6.2/bee_0.6.2_amd64.deb
sudo dpkg -i bee_0.6.2_amd64.deb
sudo rm cashout*
wget -O cashout.sh https://gist.githubusercontent.com/ralph-pichler/3b5ccd7a5c5cd0500e6428752b37e975/raw/aa576d6d28b523ea6f5d4a1ffb3c8cc0bbc2677f/cashout.sh && chmod 777 cashout.sh
sed -i 's/10000000000000000/100000/g' cashout.sh
for ((i=1; i<=tCnt; i ++))
do
cp cashout.sh cashout${i}.sh
sed -i "s/1635/$((1634+${i}))/g" cashout${i}.sh
if [[ "$ver" != "" ]]
then
rm -rf /var/lib/bee/node${i}/localstore
fi
screen -dmS bee$i
screen -x -S bee$i -p 0 -X stuff "bee start --config node${i}.yaml"
screen -x -S bee$i -p 0 -X stuff $'\n'
echo "第$i个节点已启动。"
sleep 2
done
screen -wipe
screen -ls
