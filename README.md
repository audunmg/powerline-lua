# Powerline-lua

Incomplete port of the excellent https://github.com/justjanne/powerline-go


A goal is to have it working for (d)ash as well as bash to enjoy a nice prompt on those openWRT and alpine systems where a go binary is just too big.

Aiming for compatibility with powerline-go to keep things simple, and compatibility with lua 5.1 for openWRT.


# Examples

## busybox ash

Must be compiled with ASH_EXPAND_PRMT=y

Just add to .profile (or similar):
```sh
POWERLINE_LUA_PATH=/path/to/this/repo
# Add path to repo so lua require() finds it's way:
export LUA_PATH="$POWERLINE_LUA_PATH/?.lua;;"
PS1='$($POWERLINE_LUA_PATH/powerline.lua -e $?)'
```

## bash

Bash supports extra stuff so it's possible to calculate the duration a command took, but it makes for a bit longer snippet to add to .bashrc, so it is added separately in ./bash/powerline-lua.sh

Just add to .bashrc:
```sh
POWERLINE_LUA_PATH=/path/to/this/repo
source "${POWERLINE_LUA_PATH}/bash/powerline-lua.sh"
```

# License

GPLv3
