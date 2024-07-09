FROM ubuntu:24.04

ARG SMB_USER=samba
ARG SMB_PASS=password

RUN apt-get update && \
    apt-get install --no-install-recommends samba=2:4.19.5+dfsg-4ubuntu9 smbclient=2:4.19.5+dfsg-4ubuntu9 -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /home/ubuntu

COPY smb.conf /tmp/
RUN mv /etc/samba/smb.conf /etc/samba/smb.conf.orig && \
    mv /tmp/smb.conf /etc/samba/ && \
    useradd --create-home ${SMB_USER} && \
    chmod 2777 /home/${SMB_USER} && \
    printf "${SMB_PASS}\n${SMB_PASS}\n" | smbpasswd -a -s ${SMB_USER}

CMD service smbd start && tail -f /var/log/samba/samba.log

EXPOSE 138/udp
EXPOSE 139
EXPOSE 445
EXPOSE 445/udp
