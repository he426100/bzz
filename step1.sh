#!/usr/bin/env bash
cntFile=".showcnt.txt"
if [ ! -f $cntFile ]; then
sudo apt-get update
apt-get install -y jq
apt-get install -y lrzsz
apt-get install -y screen
apt-get install -y net-tools
wget https://github.com/ethersphere/bee/releases/download/v0.5.3/bee_0.5.3_amd64.deb
wget -O cashout.sh https://gist.githubusercontent.com/ralph-pichler/3b5ccd7a5c5cd0500e6428752b37e975/raw/b40510f1172b96c21d6d20558ca1e70d26d625c4/cashout.sh && chmod +x cashout.sh && echo "00 02 * * * /root/cashout.sh cashout-all" >> /etc/crontab
wget https://raw.githubusercontent.com/pumpkin4gb/bzz/main/step2.sh && chmod 777 step2.sh
sudo dpkg -i bee_0.5.3_amd64.deb && sudo chown -R bee:bee /var/lib/bee
echo "0" > $cntFile
sed -i 's/10000000000000000/100/g' cashout.sh
#chmod +rw $cntFilefi
fi
if [ $# == 1 ]; then
if [ $1 == "resetcnt" ]; then
echo "0" > $cntFile
fi
fi
tCnt=`cat $cntFile`
let tCnt++
echo $($tCnt) > $cntFile
echo "//====这是第 $tCnt 次创建节点"

cat>node${tCnt}.yaml<<EOF
api-addr: $((1634+${tCnt}))
config: /etc/bee/node${tCnt}.yaml
data-dir: /var/lib/bee/node${tCnt}
db-capacity: 15000000
debug-api-addr: 127.0.0.1:$((1734+${tCnt}))
debug-api-enable: true
p2p-addr: $((1834+${tCnt}))
password-file: /var/lib/bee/password
verbosity: 5
swap-endpoint: https://goerli.infura.io/v3/d25f1dc4e4764a098ea729325d18276c
EOF
cp cashout.sh cashout${tCnt}.sh
sed -i 's/1635/$((1734+${tCnt}))/g' cashout${tCnt}.sh
echo "    第${tCnt}个节点等待接水中,node${tCnt}.yaml文件已生成至当前目录"
echo "    接水完毕后按Ctrl+C，之后再次运行此脚本部署更多节点"
echo "    部署完所有节点后运行step2.sh开始正式挖矿"
bee start --config node${tCnt}.yaml
