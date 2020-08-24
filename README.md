# Powerline-lua

Incomplete port of the excellent https://github.com/justjanne/powerline-go


A goal is to have it working for (d)ash as well as bash to enjoy a nice prompt on those openWRT and alpine systems where a go binary is just too big.

Aiming for compatibility with powerline-go to keep things simple, and compatibility with lua 5.1 for openWRT.


# Examples

## busybox ash

Must be compiled with ASH_EXPAND_PRMT=y

```sh
# Add path to repo so lua require() finds it's way:
export LUA_PATH="/path/to/powerline-lua/?.lua;;"
PS1='$(/path/to/powerline-lua/powerline.lua -e $?)'
```

## bash

Bash supports extra stuff so it's possible to calculate the duration a command took, but it makes for a bit longer snippet to add to .bashrc:

I'm sure this bit could be improved.
It looks a bit crazy, but it's using pure bash to improve latency, and measures time in tens of milliseconds.
```bash
POWERLINE_LUA_PATH="/path/to/powerline-lua"

function _uptime() {
  local uptime=0
  local IFS=" "
  read up rest </proc/uptime; uptime="${up%.*}${up#*.}"
  echo $uptime
}
PS0='$( _uptime > "$INTERACTIVE_BASHPID_TIMER")'

function _update_ps1() {
  local __ERRCODE=$?
  local uptime=0
  local __DURATION=0
  # If not installed normally
  export LUA_PATH="$POWERLINE_LUA_PATH/?.lua;;"
  if [ -e $INTERACTIVE_BASHPID_TIMER ]; then
    local IFS=" "
    read up rest </proc/uptime; uptime="${up%.*}${up#*.}"
    local __END=$uptime
    __START=$(cat "$INTERACTIVE_BASHPID_TIMER");
    local __DURATIONMILLISECONDS="$( printf "%03i" $((__END - __START)))"
    [[ $__DURATIONMILLISECONDS =~ ([0-9]*)([0-9][0-9])$ ]] && __DURATION=${BASH_REMATCH[1]}.${BASH_REMATCH[2]}
    rm -f "$INTERACTIVE_BASHPID_TIMER"
  fi
  PS1="\[\e]0;\h:\w\a\]$($POWERLINE_LUA_PATH/powerline.lua -e $__ERRCODE -d $__DURATION -m duration,ssh,hostname,path,git,exitcode )"
}
if [ "$TERM" != "linux" ] && [ -f "$POWERLINE_LUA_PATH/powerline.lua" ]; then
  PROMPT_COMMAND="_update_ps1"
fi
```


# License

GPLv3
