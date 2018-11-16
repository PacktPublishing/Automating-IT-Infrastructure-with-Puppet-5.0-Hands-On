# Rebuild the initrd to include only what's needed.
dracut -f -H

yum clean all  # Remove yum's cache files.
rpm --rebuilddb

rm -f /var/log/dmesg.old /var/log/anaconda.ifcfg.log \
      /var/log/anaconda.log /var/log/anaconda.program.log \
      /var/log/anaconda.storage.log /var/log/anaconda.syslog \
      /var/log/anaconda.yum.log /root/anaconda-ks.cfg 

rm -rf /tmp/* /tmp/.[^.]+
