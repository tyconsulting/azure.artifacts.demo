#! /bin/bash
if [ -z $BASH_VERSION ]; then
  print_log "current SHELL is not BASH. please use bash to run this script" "error"
  exit 1
fi

while getopts ":f:p:o:r:" opt; do
  case $opt in
  f)
    FEED="$OPTARG"
    ;;
  o)
    ORG="$OPTARG"
    ;;
  p)
    PACKAGE="$OPTARG"
    ;;
  r)
    PYPIRCPATH="$OPTARG"
    ;;
  \?)
    echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
  -*)
    echo "Option $opt is not valid. Please use -f for feed, -o for ADO organization, -p for package name" >&2
    exit 1
    ;;
  esac
done
echo "PYPIRC_PATH: $PYPIRCPATH"
cat $PYPIRCPATH
URL="https://pkgs.dev.azure.com/$ORG/_packaging/$FEED/pypi/simple"
TEMPDIR='pip-temp'

echo "creating temp directory"
sudo mkdir -p $TEMPDIR
sudo dir
echo "downloading package $PACKAGE"
sudo pip wheel $PACKAGE -w $TEMPDIR
echo "Uploading packge $PACKAGE to $FEED via URL $URL"
twine upload -r $FEED --skip-existing --disable-progress-bar --config-file $PYPIRCPATH $TEMPDIR/*
