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
filelist=$( env /bin/ls -d ~/.*rc ~/.aws ~/.ssh ~/.gnupg ~/.gdfuse/*/config ~/.awssecret ~/.bash* ~/.gitconfig 2>/dev/null |sort -u  )
tar czf - $( echo $filelist ) | gpg -r xpaulz@gmail.com -r xpaul@spokeo.com -a -e > $GITROOT/`hostname`/keys.tgz.asc
ls -l keys.tgz.asc

git commit -a -m "updating keys from `hostname`" 
git push
