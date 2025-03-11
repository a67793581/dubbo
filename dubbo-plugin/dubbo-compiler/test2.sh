#!/bin/bash

COMPILER_PATH="/Users/admin/code/test/dubbo-1/dubbo-plugin/dubbo-compiler/target"
NATIVE_COMPILER="${COMPILER_PATH}/dubbo-compiler-3.3.4-SNAPSHOT-osx-aarch_64.exe"
JAR_COMPILER="${COMPILER_PATH}/dubbo-compiler-3.3.4-SNAPSHOT.jar"

if [ -f "$NATIVE_COMPILER" ]; then
    COMPILER="$NATIVE_COMPILER"
elif [ -f "$JAR_COMPILER" ]; then
    COMPILER="java -jar $JAR_COMPILER"
else
    echo "找不到编译器文件"
    exit 1
fi

protoc --plugin=protoc-gen-dubbo="$COMPILER" \
       --dubbo_out=./target/generated-sources \
       --proto_path=. \
       test.proto
