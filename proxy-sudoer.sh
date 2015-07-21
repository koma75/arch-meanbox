#!/bin/sh
if [ -z "$1" ]; then
  echo "Changing sudoers file"
  export EDITOR=$0 && sudo -E visudo
else
  echo "Changing sudoers to keep proxy settings"
  echo "Defaults env_keep += \"http_proxy https_proxy ftp_proxy rsync_proxy http_proxy_user http_proxy_pass HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY no_proxy\"" >> $1
fi

