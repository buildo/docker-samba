FROM ubuntu:20.04

ENV SMB_USER samba
ENV SMB_PASS password

RUN apt-get clean && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install samba=2:4.15.13+dfsg-0ubuntu0.20.04.2 smbclient=2:4.15.13+dfsg-0ubuntu0.20.04.2 -y && \
    rm -fr /var/cache/*

ADD smb.conf /tmp/
RUN mv /etc/samba/smb.conf /etc/samba/smb.conf.orig && \
    mv /tmp/smb.conf /etc/samba/

ADD runconfig.sh /tmp/
RUN chmod +x /tmp/runconfig.sh && echo "/tmp/./runconfig.sh" >> ~/.bashrc

CMD /bin/bash

EXPOSE 138/udp
EXPOSE 139
EXPOSE 445
EXPOSE 445/udp
