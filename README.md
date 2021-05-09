
功能

step1.sh:
快速配置多节点
step2.sh:
使用screen开启节点，写入自动兑付支票，下载钱包文件
step3.sh:
修复旧版本step2.sh的自动兑付的端口错误，下载钱包地址和合约地址

环境

Ubuntu20.04
未安装Bee或已将其彻底删除，/var、/etc目录下无残留


用法

wget https://raw.githubusercontent.com/pumpkin4gb/bzz/main/step1.sh && chmod 777 step1.sh && ./step1.sh
之后每想添加一个节点就运行一次./step1.sh，直至满意数量。
运行./step2.sh
