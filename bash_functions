# ~/.bash_functions

# function cd_func
cd_func(){
    # This function defines a 'cd' replacement function capable of keeping,
    # displaying and accessing history of visited directories, up to 10
    # entries. To use it, source this file and try 'cd --'.
    local x2 the_new_dir adir index
    local -i cnt
    [[ $1 ==  "--" ]]&&{
        dirs -v
        return 0
    }
    the_new_dir=$1
    [[ -z $1 ]]&& the_new_dir=$HOME
    [[ ${the_new_dir:0:1} == '-' ]]&&{
        index=${the_new_dir:1}
        [[ -z $index ]] && index=1
        adir=$(dirs +$index)
        [[ -z $adir ]] && return 1
        the_new_dir=$adir
    }
    [[ ${the_new_dir:0:1} == '~' ]]&& the_new_dir="${HOME}${the_new_dir:1}"
    pushd "$the_new_dir">/dev/null
    [[ $? -ne 0 ]] && return 1
    the_new_dir=$(pwd)
    popd -n +11 2>/dev/null 1>/dev/null
    for((cnt=1; cnt<=10; cnt++)); do
        x2=$(dirs +${cnt} 2>/dev/null)
        [[ $? -ne 0 ]]&& return 0
        [[ ${x2:0:1} == '~' ]]&& x2="${HOME}${x2:1}"
        [[ $x2 == $the_new_dir ]]&&{
            popd -n +$cnt 2>/dev/null 1>/dev/null
            cnt=cnt-1
        }
    done
    return 0
    # there's a corresponding cd_func alias in ~/.bash_aliases
}

