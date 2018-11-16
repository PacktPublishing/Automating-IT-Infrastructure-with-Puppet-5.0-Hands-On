#!/bin/bash
mkdir /tmp/addmount
mount -t iso9660 /dev/sr1 /tmp/addmount

# Install the drivers
/tmp/addmount/VBoxLinuxAdditions.run

# Unmount
umount -f /tmp/addmount
rm -fr /tmp/addmount

# Make sure this doesn't fail the Packer build
exit 0
