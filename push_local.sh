#!/bin/bash
# needs `which git`
# needs `which tar`
# needs `which tar`
GITDIR=$HOME/git/
PROJECT_DIR=$GITDIR/https/github.com/xpaulz/workstations
GITROOT=$PROJECT_DIR
HOSTROOT=$GITROOT/`hostname`
git config --global credential.helper "cache"
git config --global credential.usehttppath true
git config --global credential."https://github.com/xpaulz/*".username "xpaulz@yahoo.com"

pushd $GITROOT || {  mkdir -p $GITROOT ;  pushd $GITROOT ; }
test -d .git || { pushd ../ >/dev/null; mv workstations{,.`date +%Y%m%d.%H%M`} ; git clone https://github.com/xpaulz/workstations ; popd >/dev/null; }
git pull

pushd $HOSTROOT || { mkdir -p $HOSTROOT; pushd $HOSTROOT; }


test -f .wsync.txt || ( env /bin/ls -d ~/.*rc ~/.aws ~/.ssh ~/.gnupg ~/.gdfuse/*/config ~/.awssecret ~/.bash* ~/.gitconfig ~/.enc* ~/.vault* ~/.api* 2>/dev/null |sort -u  ) > .wsync.txt

tar czf - $(<.wsync.txt)  | gpg -r xpaulz@gmail.com -r xpaul@spokeo.com -a -e > keys.tgz.asc

ls -l keys.tgz.asc

git commit -a -m "updating wsync list from `hostname`" 
git push

popd 
for f in */.gitignore ; do h=$( echo ${f%/*}) ; for fspec in $(<$f) ; do echo rm -rf $h/$fspec; done; done

#for hostIgnore in */.gitignore; do 
  #myhost=${hostIgnore%/*}
  #for fspec in "$(<$hostIgnore)" ; do 
    #echo rm -rf $myhost/$f
  #done
#done
