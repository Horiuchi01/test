#!/bin/bash

UID=$(id -u)
GID=$(id -g)

# 一回実行の時はすぐ実行して終了
if [ "$1" = "once" ]; then
    chown -R $UID:$GID src/
    exit 0
fi

# 更新チェックの間隔（秒数）
INTVL=${1:-5}

sudo -s <<EOF

while true
do
    TIME1=\$(date +"%H:%M:%S")
    echo [\$TIME1] ファイルの変更を監視し、検知すると所有者を $UID:$GID に変更します。
    echo [\$TIME1] 停止させるには ctrl+c を 2 回連続で押下してください。
    watch -g -n $INTVL ls -alR --full-time src/ --ignore=*.log \| sha256sum 1>/dev/null
    echo ----------------------------------------------------------------
    TIME2=\$(date +"%H:%M:%S")
    echo [\$TIME2] ファイルの変更を検知しました。
    echo [\$TIME2] 所有者を $UID:$GID に変更するコマンドを発行します。 
    chown -R $UID:$GID src/
    echo [\$TIME2] コマンドを発行しました。
    sleep 1
done;

EOF
