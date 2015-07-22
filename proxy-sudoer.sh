#!/bin/sh
if [ -z "$1" ]; then
  # when the script is called, the ARGV has no second param.
  echo "Changing sudoers file"
  # set the editor for visudo to be this script and call visudo from sudo
  export EDITOR=$0 && sudo -E visudo
else
  # when the script gets called as the editor, we can make changes to the
  # sudoers file.
  echo "Changing sudoers to keep proxy settings"
  # make changes to the sudoers file which is given in $1
  # in this case we add the env_keep values to keep some proxy related settings
  # when sudo is envoked
  echo "Defaults env_keep += \"http_proxy https_proxy ftp_proxy rsync_proxy http_proxy_user http_proxy_pass HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY no_proxy\"" >> $1
fi
