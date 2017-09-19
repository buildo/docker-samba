#!/bin/bash

# Set up Samba for the user

# Create a samba user
useradd $SMB_USER

# Sed the smb.conf file
sed -ie 's/USER_NAME/'$SMB_USER'/g' /etc/samba/smb.conf

# Create user in smbpasswd
echo $SMB_PASS | tee - | smbpasswd -a -s $SMB_USER

# Add Samba to the bashrc and start samba
echo "service smb start" >> ~/.bashrc
service smb start

# Remove the runconfig line
sed -ie 's/\/tmp\/\.\/runconfig.sh/#\/tmp\/\.\/runconfig.sh/g' ~/.bashrc

chmod 2777 /home/samba

unset SMB_USER SMB_PASS
