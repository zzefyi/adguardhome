# 使用Alpine作为基础镜像
FROM alpine:latest

# 设置环境变量
ENV ADGUARD_VERSION=v0.107.0

# 安装必要的依赖项
RUN apk add --no-cache curl tar

# 创建目录并下载AdGuard Home
RUN mkdir -p /opt/adguardhome \
    && curl -L -o /tmp/AdGuardHome.tar.gz https://static.adguard.com/adguardhome/release/AdGuardHome_linux_amd64.tar.gz \
    && tar -xzf /tmp/AdGuardHome.tar.gz -C /opt/adguardhome --strip-components=1 \
    && rm /tmp/AdGuardHome.tar.gz

# 设置工作目录
WORKDIR /opt/adguardhome

# 暴露端口
EXPOSE 3000/tcp 3000/udp 53/tcp 53/udp 80/tcp 443/tcp 853/tcp 853/udp 3000/tcp
# 设置卷
VOLUME ["/opt/adguardhome/work", "/opt/adguardhome/conf"]

# 入口点
ENTRYPOINT ["/opt/adguardhome/AdGuardHome"]

# 默认命令
CMD ["-c", "/opt/adguardhome/conf/AdGuardHome.yaml", "-w", "/opt/adguardhome/work"]


