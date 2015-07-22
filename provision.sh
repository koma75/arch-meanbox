#!/usr/bin/env bash

# setup proxy stuff
if ! [ -f "/etc/profile.d/setproxy.sh" ]; then
  # if it is not already set
  if [ -f "/vagrant/setproxy.sh" ]; then
    echo "proxy setting not found adding setproxy.sh"
    sudo cp /vagrant/setproxy.sh /etc/profile.d/
    sudo chmod 755 /etc/profile.d/setproxy.sh
    source /etc/profile.d/setproxy.sh
    sudo chmod 755 /vagrant/proxy-sudoer.sh
    sudo bash /vagrant/proxy-sudoer.sh
    # use curl to prevent connection time-outs
    sudo sed -i '/^#XferCommand.*curl/s/^#//' /etc/pacman.conf
  fi
fi

echo "checking for ansible binary"
if ! [ `which ansible` ]; then
  echo "no ansible installed.  Installing..."
  pacman -Sy --noconfirm ansible
else
  echo found ansible at `which ansible`
fi

#if ! [ -d "/etc/ansible/roles/leonidas.nvm" ]; then
#  ansible-galaxy install leonidas.nvm
#fi

#if ! [ -d "/etc/ansible/roles/rvm_io.rvm1-ruby" ]; then
#  ansible-galaxy install rvm_io.rvm1-ruby
#fi

if ! [ -f "/srv/ansible/hosts" ]; then
  echo "FATAL: hosts file not found at /srv/ansible/hosts"
  echo "make sure Vagrantfile is set up properly"
  exit -1
fi

if ! [ -f "/srv/ansible/playbook.yml" ]; then
  echo "FATAL: playbook not found at /srv/ansible/playbook.yml"
  echo "make sure Vagrantfile is set up properly"
  exit -1
fi

# if you have any ansible-vault encrypted files, uncomment the last line
# and add the ./ansible/.vault_pass.txt file and store the password for the
# encrypted file
echo "running: ansible-playbook -i /srv/ansible/hosts /srv/ansible/playbook.yml"
ansible-playbook \
  -i /srv/ansible/hosts /srv/ansible/playbook.yml \
  #--vault-password-file /srv/ansible/.vault_pass.txt
