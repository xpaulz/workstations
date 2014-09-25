#!/bin/bash


#~/git/devops/gpg/creds/<realm_id>.txt.asc
#~/git/devops/gpg/public/<user_id>.key
  #  get index.json https://spokedo/api/v1/credentials
  #  get https://spokedo/api/v1/credentials/index.json
  #  get '[*].id' https://spokeo.api/v1/credentials/index.json
  #  get 'Index[*].id' https://spokeo.api/v1/credentials/index.json
  #  get 'Index[*].id' https://spokeo.api/v1/credentials/
_credfs() {
  # encfs $srcdir $mntpoint 
  
  local f_descr="this is for storing credentials encryptedly but automagically retrievable"
  local f_usage="$0 <gnupg homedir> <destdir for encfs> (destdir must not exist)"
  local gnupgdir=$1
  local encdir=$2
  test -z $gnupgdir && gnupgdir=${GPG_HOME_DIR:-$HOME/.gnupg}
  test -d $gnupgdir || { echo ${f_usage} >&2 ; return 1 ; }

  test -z $encdir && encdir=
  test -d $encdir && { echo ${f_usage} >&2 ; return 1 ; }
  mkdir -p $encdir/.{u,e}ncfs
  encfs $encdir/.unc $encdir/.enc
  for credfn in $(ls ~/git/devops/gpg/creds ) ; do 
    credid=${credfn#.txt.asc}
    
  done
}
_list_gpg_keys() {
}
_list_users() {
  ls ~/git/devops/gpg/public
}
_list_realms() {
  usage="<function> <object> <path>"
  clist=( $( ls ~/git/devops/gpg/creds/ ) )
  for f in ${clist[@]}; do 
    echo ${f%.txt.asc}
  done
  
}
_put_token() {
  # 
  usage="<function> <object> <path>"
}
_get_tokens() {
  # 
  usage="<function> <object> <path>"
}
