FROM frolvlad/alpine-mono:5.14-glibc
MAINTAINER Soul Inferno <gamingtiger@gmx-topmail.de>

ENV TZ="/usr/share/zoneinfo/UTC+1"

RUN apk update && apk upgrade

RUN adduser -D -h /home/openra -s /sbin/nologin openra
USER openra
WORKDIR /home/openra

# http://www.openra.net/download/
ENV OPENRA_PLAYTEST_VERSION=20190106
ENV OPENRA_PLAYTEST=https://github.com/OpenRA/OpenRA/releases/download/playtest-${OPENRA_PLAYTEST_VERSION}/OpenRA-Red-Alert-playtest-x86_64.AppImage
RUN \
mkdir /home/openra/tmp && \
cd /home/openra/tmp && \
wget $OPENRA_PLAYTEST -O /home/openra/tmp/crapimage && \
chmod 755 /home/openra/tmp/crapimage && \
/home/openra/tmp/crapimage --appimage-extract && \
mv /home/openra/tmp/squashfs-root/* /home/openra/ && \
rm -rf /home/openra/tmp/

COPY --chown=openra:openra launch-dedicated.sh /home/openra/usr/lib/openra

RUN mkdir /home/openra/.openra && \
mkdir /home/openra/.openra/Logs && \
mkdir /home/openra/.openra/maps && \
chmod 755 /home/openra/usr/lib/openra/launch-dedicated.sh

EXPOSE 26967

WORKDIR /home/openra/usr/lib/openra

VOLUME ["/home/openra", "/usr/lib/openra", "/home/openra/.openra/Logs", "/home/openra/.openra/maps"]
CMD [ "mono --debug OpenRA.Server.exe Game.Mod="ra" Server.AdvertiseOnline="True" Server.Name="Ded. server 2019 alpine playtest" Server.ExternalPort="26967" Server.ListenPort="26967" Server.EnableSingleplayer="True" Server.Motd="Info: github.com/sinfernoautomated/" " ]
