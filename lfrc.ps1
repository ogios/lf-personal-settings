# set previewer ~/.config/lf/lf_kitty_preview
# set cleaner ~/.config/lf/lf_kitty_clean


# set previewer ctpv
# set cleaner ctpvclear
# &ctpv -s $id
# &ctpvquit $id


# Basic Settings
set hidden true
set ignorecase true
set icons true

# Custom Functions
cmd mkdir ${{
  printf "Directory Name: "
  read ans
  mkdir $ans
}}

cmd mkfile ${{
  printf "File Name: "
  read ans
  nvim $ans
}}

# cmd setwallpaper ${{
#     cp "$f" ~/.config/wall.jpg
#     xwallpaper --zoom "$f"
#     betterlockscreen -u "$f" --fx
# }}
#
# Archive bindings
cmd unarchive ${{
  case "$f" in
      *.zip) unzip "$f" ;;
      *.tar.gz) tar -xzvf "$f" ;;
      *.tar.bz2) tar -xjvf "$f" ;;
      *.tar) tar -xvf "$f" ;;
      *) echo "Unsupported format" ;;
  esac
}}

# Trash bindings
cmd trash ${{
  files=$(printf "$fx" | tr '\n' ';')
  while [ "$files" ]; do
    file=${files%%;*}

    trash-put "$(basename "$file")"
    if [ "$files" = "$file" ]; then
      files=''
    else
      files="${files#*;}"
    fi
  done
}}

cmd restore_trash ${{
  trash-restore
}}

# nvim
cmd open_nvim ${{
    nvim
}}
cmd open_nvim_file ${{
    nvim "$f"
}}

# fuzzy finder
cmd fzf_jump ${{
    res="$(find . -maxdepth 5 | fzf --reverse --header='Jump to location')"
    if [ -n "$res" ]; then
        if [ -d "$res" ]; then
            cmd="cd"
        else
            cmd="select"
        fi
        res="$(printf '%s' "$res" | sed 's/\\/\\\\/g;s/"/\\"/g')"
        lf -remote "send $id $cmd \"$res\""
    fi
}}

cmd open_explorer ${{
	explorer .
}}


map <c-f> :fzf_jump
map E :open_nvim
map e :open_nvim_file
map oe :open_explorer

# Bindings
map d
map m

map c $vscodium "$f"

map au unarchive
map ae $wine "$f"

# Basic Functions
map . set hidden!
map dd trash
map dr restore_trash
map p paste
map x cut
map y copy
map <enter> open
map <backspace2> :updir
map J :updir; down; open
map K :updir; up; open
map R reload
map mf mkfile
map md mkdir
map C clear
map S shell

# Movement
map gn cd ~/AppData/Local/nvim/
map gl cd ~/AppData/Local/lf/
map gw cd D:/Projects
map gh cd ~
map ga cd ~/AppData/Local
