FROM ubuntu:22.04
MAINTAINER XIA

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'
ENV EFB_DATA_PATH /data/
ENV EFB_PARAMS ""
ENV EFB_PROFILE "default"
ENV HTTPS_PROXY ""

RUN apt-get update -y
RUN apt-get install -y python3 python3-pip python3-setuptools python3-yaml ffmpeg libcairo2-dev libcairo2 nano
RUN apt-get install -y libmagic-dev ffmpeg git
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

RUN pip3 install --upgrade pip && pip3 install python-telegram-bot[socks] efb-telegram-master[tgs] \
    && pip3 install ehforwarderbot efb-patch-middleware efb-mp-instantview-middleware efb-msg_blocker-middleware efb-online-middleware efb-notice-middleware efb-voice_recog-middleware efb-gpg-middleware \
    && pip3 install --upgrade --force-reinstall \
       https://github.com/ehForwarderBot/efb-wechat-slave/archive/master.zip \
       https://github.com/ehForwarderBot/efb-qq-plugin-go-cqhttp/archive/master.zip \
    && rm -rf /tmp/* /var/cache/apk/* /var/lib/apk/lists/*

WORKDIR .
ADD entrypoint.sh .

CMD /bin/sh /entrypoint.sh
