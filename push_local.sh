#!/bin/bash
# needs `which git`
# needs `which tar`
# needs `which tar`
GITROOT=~/git/https/github.com/xpaulz/workstations
HOSTROOT=$GITROOT/`hostname`

pushd $GITROOT || {  mkdir -p $GITROOT ;  pushd $GITROOT ; }
test -d .git || { pushd ../; mv workstations{,.`date +%Y%m%d.%H%M`} ; git clone https://github.com/xpaulz/workstations ; popd; }
git pull

pushd $HOSTROOT || { mkdir -p $HOSTROOT; pushd $HOSTROOT; }

tar czf -  ~/.aws ~/.ssh ~/.gnupg ~/.gdfuse ~/.awssecret ~/.bash* | gpg -r xpaulz@gmail.com -r xpaul@spokeo.com -a -e > $GITROOT/`hostname`/keys.tgz.asc
ls -l keys.tgz.asc

git commit -a -m "updating keys from `hostname`" 
git push
