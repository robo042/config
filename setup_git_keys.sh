#!/usr/bin/env bash

error_exit(){
    echo -e "\n$0\n\t$@\n" >&2
    exit 1
}

if [[ ${BASH_SOURCE[0]} == ${0} ]]; then
    
    [[ $EUID -ne 0 ]] || {
        error_exit 'This is script is not intended to be run as root'
    }

    [[ -d $HOME ]] || error_exit "Can't find home directory"

    algorithm='ed25519'
    ssh_dir="${HOME}/.ssh" 
    private_key_file="${ssh_dir}/id_${algorithm}"
    public_key_file="${private_key_file}.pub"

    # Check if key exists
    [[ -f $public_key_file ]] && key_contents="$(cat $public_key_file)"

    # Generate key if needed
    [[ -z ${key_contents+x} ]] && {
        ssh-keygen -t $algorithm -N '' -f "$private_key_file" <<< n ;
        key_contents="$(cat $public_key_file)"
    }
    
    # Present key and link
    echo -e "\nHere go your key:\n$key_contents"
    echo -e "\nHead to this URL to add it:\nhttps://github.com/settings/keys"

fi
