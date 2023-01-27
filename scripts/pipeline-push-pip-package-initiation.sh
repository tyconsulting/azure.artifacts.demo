#! /bin/bash
if [ -z $BASH_VERSION ]; then
  print_log "current SHELL is not BASH. please use bash to run this script" "error"
  exit 1
fi

echo "installing artifacts-keyring pip package"
sudo pip install keyring artifacts-keyring
echo "installing wheel pip package"
sudo pip install wheel
echo "installing twine pip package"
sudo pip install twine
