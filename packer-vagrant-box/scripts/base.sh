echo %_install_langs en_US.utf8 >> /etc/rpm/macros

# No fsck at boot
sed -i -r 's/(defaults\s+)1 1/\10 0/' /etc/fstab

# Import key first so that yum doesn't complain later.
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-*-7

# Squash the delay on boot
sed -i 's/GRUB_TIMEOUT.*/GRUB_TIMEOUT=0/' \
    /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

# Disable GSSAPI Authentication for speed
sed -i -r 's/^GSSAPIAuthentication yes/GSSAPIAuthentication no/' /etc/ssh/sshd_config

