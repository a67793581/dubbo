FROM ubuntu:22.04
RUN apt-get update && apt-get install -y ca-certificates \
    curl wget zip unzip \
    tar maven git gcc g++ \
    build-essential zlib1g-dev gzip

# - buf-Darwin-arm64
# - buf-Darwin-arm64.tar.gz
# - buf-Darwin-x86_64
# - buf-Darwin-x86_64.tar.gz
# - buf-Linux-aarch64
# - buf-Linux-aarch64.tar.gz
# - buf-Linux-armv7
# - buf-Linux-armv7.tar.gz
# - buf-Linux-x86_64
# - buf-Linux-x86_64.tar.gz
RUN curl -sSL "https://github.com/bufbuild/buf/releases/download/v1.50.0/buf-$(uname -s)-$(uname -m)" -o "/usr/local/bin/buf" && \
    chmod +x "/usr/local/bin/buf"
# 创建graalvm
# Linux ARM64 Compressed Archive	331.31 MB
# https://download.oracle.com/graalvm/23/latest/graalvm-jdk-23_linux-aarch64_bin.tar.gz ( sha256)
# Linux x64 Compressed Archive	359.02 MB
# https://download.oracle.com/graalvm/23/latest/graalvm-jdk-23_linux-x64_bin.tar.gz ( sha256)
RUN MACHINE=$(uname -m) && \
    case $MACHINE in \
        x86_64)  ARCH=x64 ;; \
        aarch64|arm64) ARCH=aarch64 ;; \
        *) echo "Unsupported architecture: $MACHINE" && exit 1 ;; \
    esac && \
    echo "Detected architecture: $ARCH" && \
    mkdir -p /usr/lib/graalvm && \
    GRAAL_URL="https://download.oracle.com/graalvm/23/latest/graalvm-jdk-23_linux-${ARCH}_bin.tar.gz" && \
    echo "Downloading from: $GRAAL_URL" && \
    curl -L -o /usr/lib/graalvm/graalvm.tar.gz "$GRAAL_URL" && \
    cd /usr/lib/graalvm && \
    tar -xzf graalvm.tar.gz && \
    rm graalvm.tar.gz



# 安装 Go 1.23.7
# go1.23.7.linux-loong64.tar.gz	Archive	Linux	loong64	68MB	b9fb0ae7116cee77e88e1e2f54cca44343a71168b944768c48188cd1957fb3f8
# go1.23.7.linux-mips.tar.gz	Archive	Linux	mips	66MB	27404833dc64673cacdd1470d77bf4235252ca5ca7a1fb47b465ff3b98cc31df
# go1.23.7.linux-mips64.tar.gz	Archive	Linux	mips64	65MB	fd1b628f2491b8be86791ad63e2b61b17909b6e1b3ae37ddcd27b9a5faddcd87
# go1.23.7.linux-mips64le.tar.gz	Archive	Linux	mips64le	65MB	f1d91a01bfe537bef687e2ab11f0c67ae8948d1ab1662110edcbfd7fd1803d9c
# go1.23.7.linux-mipsle.tar.gz	Archive	Linux	mipsle	66MB	bdcaa3fddb09b53c42a8963fcbfb52a29feeaf34bdcec7d59e54eab0d16bfb12
# go1.23.7.linux-ppc64.tar.gz	Archive	Linux	ppc64	67MB	ce2226b5e0940116cf9c791aa912ce62b3baac8bf2aaf09a1cd1e1de33456fd3
# go1.23.7.linux-ppc64le.tar.gz	Archive	Linux	ppc64le	67MB	3ffc310bfd11fd0bcc713a764a0f7252c4d52d03f12abebfaebaaae77e027028
# go1.23.7.linux-riscv64.tar.gz	Archive	Linux	riscv64	68MB	6474c707a09633ebd3117eb9127de467fbc482932164f1d1b1084e3be40c36f7
# go1.23.7.linux-s390x.tar.gz	Archive	Linux	s390x	69MB	af1d4c5d01e32c2cf6e3cc00e44cb240e1a6cef539b28a64389b2b9ca284ac6c
# go1.23.7.linux-386.tar.gz	Archive	Linux	x86	68MB	9115f7d751efe5b17b63a7630d24cd0a2479976465eecb277b5deec8aa0f4143
# go1.23.7.linux-amd64.tar.gz	Archive	Linux	x86-64	70MB	4741525e69841f2e22f9992af25df0c1112b07501f61f741c12c6389fcb119f3
# go1.23.7.linux-arm64.tar.gz	Archive	Linux	ARM64	67MB	597acbd0505250d4d98c4c83adf201562a8c812cbcd7b341689a07087a87a541
# go1.23.7.linux-armv6l.tar.gz	Archive	Linux	ARMv6	68MB	c9e9ecd6a8cf1429f1c65d81115c450258258ac65833d95a82d5f4e5ad7d2d7a
RUN MACHINE=$(uname -m) && \
    case $MACHINE in \
        x86_64)  ARCH=amd64 ;; \
        aarch64) ARCH=arm64 ;; \
        armv6l)  ARCH=armv6l ;; \
        i386|i686) ARCH=386 ;; \
        *) ARCH=$MACHINE ;; \
    esac && \
    echo "Detected architecture: $ARCH" && \
    url="https://go.dev/dl/go1.23.7.linux-$ARCH.tar.gz" && echo "变量 : $url" && curl "$url" -sSL  -o /tmp/go1.23.7.tar.gz && \
    tar -C /usr/local -xzf /tmp/go1.23.7.tar.gz && \
    rm /tmp/go1.23.7.tar.gz

# 设置环境变量
ENV GRAALVM_HOME=/usr/lib/graalvm/graalvm-jdk-23.0.2+7.1
ENV JAVA_HOME=$GRAALVM_HOME
ENV GOPATH=/go
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:$JAVA_HOME/bin

# # 验证安装
RUN java -version && \
    native-image --version && \
    go env && \
    buf --version

CMD ["bash"]
