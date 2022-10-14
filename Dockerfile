FROM ubuntu:focal

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN dpkg --add-architecture i386 \
    && apt update
RUN apt install -y -o APT::Immediate-Configure=false \
    build-essential \
    cabextract \
    p7zip-full \
    software-properties-common \
    unzip \
    vim \
    wget

RUN (wget -q https://dl.winehq.org/wine-builds/winehq.key -O- | apt-key add -) \
 && add-apt-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ focal main" \
 && apt update

RUN apt install -y -o APT::Immediate-Configure=false --install-recommends winehq-stable

RUN wget --no-check-certificate -L -O /tmp/utilities.zip 'https://www.dropbox.com/s/9rm6cd1gvppd6av/utilities.zip?dl=1' \
   && unzip /tmp/utilities.zip -d /tmp

RUN unzip /tmp/utilities/yychr20200119.zip -d /opt \
   && mv /opt/yychr20200119 /opt/yychr

RUN unzip /tmp/utilities/floating.zip -d /opt/floating
