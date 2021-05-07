#!/usr/bin/env bash
cntFile=".showcnt.txt"
if [ ! -f $cntFile ]; then
sudo apt-get update
apt-get install -y jq
apt-get install -y lrzsz
apt-get install -y screen
wget https://github.com/ethersphere/bee/releases/download/v0.5.3/bee_0.5.3_amd64.deb
wget https://github.com/ethersphere/bee-clef/releases/download/v0.4.9/bee-clef_0.4.9_amd64.deb
wget -O cashout.sh https://gist.githubusercontent.com/ralph-pichler/3b5ccd7a5c5cd0500e6428752b37e975/raw/b40510f1172b96c21d6d20558ca1e70d26d625c4/cashout.sh && chmod +x cashout.sh && echo "00 02 * * * /root/cashout.sh cashout-all" >> /etc/crontab
sudo dpkg -i bee-clef_0.4.9_amd64.deb && sudo dpkg -i bee_0.5.3_amd64.deb && sudo chown -R bee:bee /var/lib/bee
echo "0" > $cntFile
#chmod +rw $cntFilefi
if [ $# == 1 ]; then
if [ $1 == "resetcnt" ]; then
echo "0" > $cntFile
fi
fi
tCnt=`cat $cntFile`
echo $(($tCnt + 1)) > $cntFile
echo "//====================================="
echo "//== 这是第 $tCnt 次创建节点" echo "//====================================="

cat>bee${tCnt}.yaml<<EOF
api-addr: :${1635+${tCnt}}
clef-signer-enable: false
config: /etc/bee/bee${tCnt}.yaml
data-dir: /var/lib/bee${tCnt}
db-capacity: 15000000
debug-api-addr: 127.0.0.1:${1735+${tCnt}}（指定调试端口，非固定，只要未被占用的端口均可）
debug-api-enable: true 
p2p-addr: :${1835+${tCnt}}
password-file: /var/lib/bee/password
verbosity: 5
swap-endpoint: https://goerli.infura.io/v3/d25f1dc4e4764a098ea729325d18276c
EOF && \cp ${bee${tCnt}.yaml} /etc/bee/${bee${tCnt}.yaml} && echo "//== ${bee${tCnt}.yaml}文件已生成至/etc/bee" echo "//====================================="

echo "————————————节点的接水地址如下，接水后运行step2.sh————————————"
sudo bee-get-addr
