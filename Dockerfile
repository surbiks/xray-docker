FROM --platform=amd64 alpine

RUN mkdir -p /usr/app
WORKDIR /usr/app

ARG XRAY_VERSION=1.6.5
ARG XRAY_URL=https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip

RUN apk add --no-cache tzdata ca-certificates wget
RUN \
    mkdir -p /var/log/xray /etc/xray && \
    wget ${XRAY_URL} && \
    unzip Xray-linux-64.zip && \
    echo "{}" > /etc/xray/config.json && \
    chmod 755 xray && \
    rm Xray-linux-64.zip

COPY config.json /etc/xray/config.json
ENV TZ=Asia/Tehran
CMD [ "/usr/app/xray", "run", "-c", "/etc/xray/config.json" ]