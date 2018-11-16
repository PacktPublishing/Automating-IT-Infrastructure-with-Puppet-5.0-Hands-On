# Create vagrant user
groupadd vagrant
useradd vagrant -g vagrant -G wheel
echo "vagrant" | passwd --stdin vagrant

# Install vagrant keys
mkdir -p /home/vagrant/.ssh

cat <<EOM >/home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8Y\
Vr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdO\
KLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7Pt\
ixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmC\
P3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcW\
yLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOM

chown -R vagrant:vagrant /home/vagrant/.ssh
chmod -R u=rwX,go= /home/vagrant/.ssh

sed -i '/.*requiretty/d' /etc/sudoers
echo '%wheel ALL=NOPASSWD: ALL' >> /etc/sudoers

# Setup network devices.
echo '#' >/etc/udev/rules.d/75-persistent-net-generator.rules
cat <<EOM >/etc/sysconfig/network
HOSTNAME=vagrant-puppet5.vagrantup.com
NETWORKING=yes
EOM

cat <<EOM >>/etc/hosts
127.0.0.1   vagrant-puppet5.vagrantup.com vagrant-puppet5
::1         vagrant-puppet5.vagrantup.com vagrant-puppet5
EOM

sed -i -r 's/#(UseDNS).*/\1 no/' /etc/ssh/sshd_config
