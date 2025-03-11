#!/bin/bash

protoc --plugin=protoc-gen-dubbo="/Users/admin/code/test/dubbo-1/dubbo-plugin/dubbo-compiler/target/dubbo-compiler-3.3.4-SNAPSHOT-osx-aarch_64.exe" \
       --dubbo_out=./target/generated-sources \
       --proto_path=. \
       test.proto
