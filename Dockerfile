# 使用Debian 12作为基础镜像
FROM debian:12

# 设置工作目录
WORKDIR /opt/AdGuardHome

# 更新包列表并安装必要的软件包
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# 下载并执行AdGuard Home安装脚本
RUN curl -s -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | bash

# 设置工作目录为AdGuard Home的安装目录
WORKDIR /opt/AdGuardHome/

# 暴露端口
EXPOSE 3000/tcp 3000/udp 53/tcp 53/udp 80/tcp 443/tcp 853/tcp 853/udp 3000/tcp

# 设置容器启动时运行AdGuard Home

CMD ["/opt/AdGuardHome/AdGuardHome", "-s", "start"]

