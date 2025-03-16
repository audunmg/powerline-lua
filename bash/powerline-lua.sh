### Powerline-lua for bash

if [ -x "/usr/bin/lua" ]; then
    LUA="/usr/bin/lua"
fi
if [ -x "$PREFIX/bin/lua5.4" ]; then
    LUA="$PREFIX/bin/lua5.4"
fi

# Termux on android doesn't have permission to read /proc/uptime
if [ -r /proc/uptime ]; then
        INTERACTIVE_BASHPID_TIMER="/tmp/${USER}.START.$$"
        PS0='$( _uptime > "$INTERACTIVE_BASHPID_TIMER")'
function _uptime() {
    local uptime=0
    local IFS=" "
    read up rest </proc/uptime; uptime="${up%.*}${up#*.}"
    echo $uptime
}
elif which luajit > /dev/null; then
# Luajit workarond for non-readable /proc/uptime:
        INTERACTIVE_BASHPID_TIMER="$TMPDIR/${USER}.START.$$"
        PS0='$( _uptime > "$INTERACTIVE_BASHPID_TIMER")'
function _uptime() {
    # This method adds from 4(on my laptop) to up to 30ms(on my old phone) delay to the prompt.
    luajit -e '
local ffi = require("ffi")
ffi.cdef[[
    typedef long time_t;
    typedef int clockid_t;

    typedef struct timespec {
            time_t   tv_sec;        /* seconds */
            long     tv_nsec;       /* nanoseconds */
    } nanotime;
    int clock_gettime(clockid_t clk_id, struct timespec *tp);
]]
function clock_gettime()
    local pnano = assert(ffi.new("nanotime[?]", 1))

    -- CLOCK_REALTIME -> 0
    ffi.C.clock_gettime(0, pnano)
    return pnano[0]
end
local nano = clock_gettime()
print(string.format("%d%d",tonumber(nano.tv_sec),tonumber(nano.tv_nsec)/10000000))
'
}
fi

function _update_ps1() {
    local __ERRCODE=$?
    local uptime=0
    local __DURATION=0
    # If not installed normally
    export LUA_PATH="$POWERLINE_LUA_PATH/?.lua;;"
    if [ -e $INTERACTIVE_BASHPID_TIMER ]; then
        local IFS=" "
        uptime="$(_uptime)"
        local __END=$uptime
        __START=$(cat "$INTERACTIVE_BASHPID_TIMER");
        local __DURATIONMILLISECONDS="$( printf "%03i" $((__END - __START)))"
        [[ $__DURATIONMILLISECONDS =~ ([0-9]*)([0-9][0-9])$ ]] && __DURATION=${BASH_REMATCH[1]}.${BASH_REMATCH[2]}
        # Update history with command results if the database exists.
        if [ -e $HISTDB ]; then
            _historian_update "$__ERRCODE" "$__DURATIONMILLISECONDS" "$(( HISTCMD -1 ))"
        fi
        rm -f "$INTERACTIVE_BASHPID_TIMER"
    fi
    PS1="\[\e]0;\h:\w\a\]$($LUA $POWERLINE_LUA_PATH/powerline.lua -e $__ERRCODE -d $__DURATION )"
    history -a
}
if [ "$TERM" != "linux" ] && [ -f "$POWERLINE_LUA_PATH/powerline.lua" ]; then
    PROMPT_COMMAND="_update_ps1"
fi

