#!/bin/bash
# needs `which git`
# needs `which tar`
# needs `which tar`
GITROOT=~/git/https/github.com/xpaulz/workstations
HOSTROOT=$GITROOT/`hostname`
test -d $HOSTROOT || mkdir -p $HOSTROOT

pushd $GITROOT
test -d .git || { pushd ../; git clone https://github.com/xpaulz/workstations ; popd; }
git pull

test -d $HOSTROOT || mkdir -p $HOSTROOT

tar czf -  ~/.aws ~/.ssh ~/.gnupg ~/.gdfuse/*/config ~/.awssecret ~/.bash* | gpg -r xpaulz@gmail.com -r xpaul@spokeo.com -a -e > $GITROOT/`hostname`/keys.tgz.asc
git commit -a -m "updating keys from pvigils-lx1" 
git push
