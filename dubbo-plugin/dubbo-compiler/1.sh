#!/bin/bash
mvn spotless:apply
mvn clean package

# 执行第一个 protoc 命令并检查返回值
protoc --plugin=protoc-gen-dubbo="./target/dubbo-compiler"  \
       --dubbo_out=./target/generated-sources \
       --proto_path=. \
       test.proto
if [ $? -ne 0 ]; then
    echo "第一个 protoc 命令执行失败"
else
    echo "第一个 protoc 命令执行成功"
fi

# 执行第二个 protoc 命令并检查返回值
protoc --plugin=protoc-gen-dubbo="./target/dubbo-compiler-3.3.4-SNAPSHOT-osx-aarch_64.exe" \
       --dubbo_out=./target/generated-sources \
       --proto_path=. \
       test.proto
if [ $? -ne 0 ]; then
    echo "第二个 protoc 命令执行失败"
else
    echo "第二个 protoc 命令执行成功"
fi
