#!/bin/bash

# Set up Samba for the user

# Create a samba user
useradd --create-home $SMB_USER

# Sed the smb.conf file
sed -ie 's/USER_NAME/'$SMB_USER'/g' /etc/samba/smb.conf

# Create user in smbpasswd
echo -en "$SMB_PASS\n$SMB_PASS\n" | tee - | smbpasswd -a -s $SMB_USER

# Add Samba to the bashrc and start samba
echo "service smbd start" >> ~/.bashrc
service smbd start

# Remove the runconfig line
sed -ie 's/\/tmp\/\.\/runconfig.sh/#\/tmp\/\.\/runconfig.sh/g' ~/.bashrc

chmod 2777 /home/$SMB_USER

unset SMB_USER SMB_PASS
