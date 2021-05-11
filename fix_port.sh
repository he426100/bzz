#修复一个愚蠢的引号造成的端口错误
tCnt=`cat ".showcnt.txt"`
err='"$((1634+${tCnt}))"'
for ((i=1; i<=tCnt; i ++))
do
        sed -i s/$err/$((1634+${i}))/g cashout${i}.sh
done
