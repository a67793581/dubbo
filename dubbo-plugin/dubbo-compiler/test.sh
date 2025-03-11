 protoc --plugin=protoc-gen-dubbo=/Users/admin/code/test/dubbo-1/dubbo-plugin/dubbo-compiler/target/dubbo-compiler  \
       --dubbo_out=./target/generated-sources \
       --proto_path=. \
       test.proto
