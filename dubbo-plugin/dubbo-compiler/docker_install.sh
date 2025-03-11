#!/bin/bash

# 设置错误时立即退出
set -e
# 切换到脚本所在目录
cd "$(dirname "$0")"
# 打印执行的命令
# set -x

if ! docker images dubbo-compiler:latest -q | grep -q .; then
    docker build -t dubbo-compiler .
fi

# 使用自定义镜像运行构建
docker run --rm \
 -v $(pwd)/../../:/dubbo \
 -v maven-repo:/root/.m2 \
 -w /dubbo/dubbo-plugin/dubbo-compiler dubbo-compiler:latest \
 mvn clean package \
 -Dmaven.artifact.threads=50 \
 -Dmaven.wagon.http.ssl.insecure=true \
 -Dmaven.wagon.http.ssl.allowall=true \
 -Dmaven.wagon.http.ssl.ignore.validity.dates=true \
 --settings /dubbo/dubbo-plugin/dubbo-compiler/settings.xml
