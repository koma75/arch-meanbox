arch-meanbox
================================================================================
Arch Linux based MEAN development environment on Vagrant.

Initial Setup
--------------------------------------------------------------------------------

### Pre-requisite

make sure you have a arch linux 64bit base box named arch in your vagrant box.
currently tested against the box generated using
[this repo](https://github.com/koma75/packer-arch).

### Start up

~~~
vagrant up
ssh -p 2222 localhost
~~~

User and password should be initially set to vagrant.

### Proxy

vagrant-proxyconf + dotenv plugin does not seem to work properly with some tools
and environments.  provision.sh injects a setproxy.sh into /etc/profile.d/ and
to set up proxy environment for all users and also changes sudoers to keep the
settings during sudo.

to enable proxy setting,

* copy setproxy.sh.tmp as setproxy.sh
* edit setproxy.sh with server, port, username and password

### Windows hosts

* newer version of virtual box does not seem to work nice with windows security
  software like McAfee and SEP.  try using 4.3.12 or earlier.
* this box is intentionally set up to work on Windows 32bit hosts with VT-x
  support.
  * to enable VT-x, make sure the Virtualization extension capability is turned
    on in the BIOS menu.

### Secret variables for ansible

* if some secret variable need to be stored in ansible playbook files AND you
  would like to keep the variables in a repository, you can use ansible-vault
  to encrypt the file.
  * to run ansible without manually decrypting the file, place the password in
    ./ansible/.vault_pass.txt file and pass --vault-password-file /srv/ansible/.vault_pass.txt
    to the ansible-playbook command.
