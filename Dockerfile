FROM ubuntu:20.04

ENV SMB_USER samba
ENV SMB_PASS password

ADD smb.conf /tmp/
ADD runconfig.sh /tmp/

RUN apt-get clean && \
apt-get update && \
apt-get upgrade -y && \
apt-get install samba=2:4.15.13+dfsg-0ubuntu0.20.04.2 samba-client -y && \
rm -fr /var/cache/*

RUN mv /etc/samba/smb.conf /etc/samba/smb.conf.orig && \
mv /tmp/smb.conf /etc/samba/

RUN echo "service rpcbind start" >> ~/.bashrc && \
chmod +x /tmp/runconfig.sh && \
echo "/tmp/./runconfig.sh" >> ~/.bashrc

CMD /bin/bash

EXPOSE 138/udp
EXPOSE 139
EXPOSE 445
EXPOSE 445/udp
