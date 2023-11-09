#!/usr/bin/env bash


dconfdir=/org/gnome/terminal/legacy/profiles:


create_new_profile() {
    local profile_ids=($(dconf list $dconfdir/ | grep ^: |\
                        sed 's/\///g' | sed 's/://g'))
    local profile_name="$1"
    local profile_ids_old="$(dconf read "$dconfdir"/list | tr -d "]")"
    local profile_id="$(uuidgen)"

    # if there's no `list` key
    [ -z "$profile_ids_old" ] && local profile_ids_old="["  

    # if the list is empty
    [ ${#profile_ids[@]} -gt 0 ] && local delimiter=,

    dconf write $dconfdir/list \
        "${profile_ids_old}${delimiter} '$profile_id']"
    dconf write "$dconfdir/:$profile_id"/visible-name "'$profile_name'"
    echo $profile_id
}


in_array() {
  local e
  for e in "${@:2}"; do [[ $e == $1 ]] && return 0; done
  return 1
}


duplicate_profile() {
    local from_profile_id="$1"; shift
    local to_profile_name="$1"; shift
    local profile_ids=(
        $(dconf list $dconfdir/ | grep ^: | sed 's/\///g' | sed 's/://g')
    )

    # If UUID doesn't exist, abort
    in_array "$from_profile_id" "${profile_ids[@]}" || return 1
    # Create a new profile
    local id=$(create_new_profile "$to_profile_name")
    # Copy an old profile and write it to the new
    dconf dump "$dconfdir/:$from_profile_id/" \
        | dconf load "$dconfdir/:$id/"
    # Rename
    dconf write "$dconfdir/:$id"/visible-name "'$to_profile_name'"
}


get_profile_uuid() {
    # Print the UUID linked to the profile name sent in parameter
    local profile_ids=(
      $(dconf list $dconfdir/ | grep ^: | sed 's/\///g' | sed 's/://g'))
    local profile_name="$1"
    for i in ${!profile_ids[*]}; do
        if [[ "$(dconf read $dconfdir/:${profile_ids[i]}/visible-name)" == \
            "'$profile_name'" ]]; then
            echo "${profile_ids[i]}"
            return 0
        fi
    done
}


if [[ ${BASH_SOURCE[0]} == ${0} ]]; then


  # Create profile
  profile_name='Custom'
  id=$(create_new_profile $profile_name)

  # Define and set new colors
  palette="[
      'rgb(0,0,0)', 'rgb(255,0,0)', 'rgb(0,255,0)', 'rgb(255,128,0)', 
      'rgb(102,102,255)', 'rgb(255,0,255)', 'rgb(0,202,202)', 
      'rgb(170,170,170)', 'rgb(85,85,85)', 'rgb(255,102,102)', 
      'rgb(153,255,153)', 'rgb(255,255,85)', 'rgb(170,170,255)', 
      'rgb(255,85,255)', 'rgb(128,255,255)', 'rgb(255,255,255)']"
  profile_dump="
    [/]
    audible-bell=false
    background-color='rgb(0,0,0)'
    background-transparency-percent=1
    cursor-blink-mode='on'
    cursor-shape='ibeam'
    default-size-rows=25
    font='Ubuntu Mono 15'
    foreground-color='rgb(0,255,0)'
    highlight-background-color='rgb(0,255,0)'
    highlight-colors-set=true
    highlight-foreground-color='rgb(0,0,0)'
    palette=$(echo $palette)
    scroll-on-output=true
    use-system-font=false
    use-theme-colors=false
    use-theme-transparency=false
    use-transparent-background=true
    visible-name='$(echo $profile_name)'
  "
  echo "$profile_dump" | awk '{$1=$1};1' | dconf load "$dconfdir/:$id/" 

  #dconf write /org/gnome/terminal/legacy/profiles:/:$id/palette "$palette"


  ### other things you can do ### 
  ## set a profile as default
  # dconf write $dconfdir/default "'$UUID'"
  
  ## get a profile's UUID by its name
  # id=$(get_profile_uuid Default)

fi


