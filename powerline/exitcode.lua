local exitcode = {}

function exitcode.main(p)
    if (p.exitcode == nil) or (p.exitcode == 0) then
        return {
            foreground = 0,
            background = 0,
            text       = ''
        }
    end

    exitcodes = {
        [1] = "ERROR",
        [2] = "USAGE",
        [126] = "NOPERM",
        [127] = "NOTFOUND",
        [129] = "SIGHUP",
        [130] = "SIGINT",
        [131] = "SIGQUIT",
        [132] = "SIGILL",
        [133] = "SIGTRAP",
        [134] = "SIGABRT",
        [135] = "SIGBUS",
        [136] = "SIGFPE",
        [137] = "SIGKILL",
        [138] = "SIGUSR1",
        [139] = "SIGSEGV",
        [140] = "SIGUSR2",
        [141] = "SIGPIPE",
        [142] = "SIGALRM",
        [143] = "SIGTERM",
        [144] = "SIGSTKFLT",
        [145] = "SIGCHLD",
        [146] = "SIGCONT",
        [147] = "SIGSTOP",
        [148] = "SIGTSTP",
        [149] = "SIGTTIN",
        [150] = "SIGTTOU",
        [151] = "SIGURG",
        [152] = "SIGXCPU",
        [153] = "SIGXFSZ",
        [154] = "SIGVTALRM",
        [155] = "SIGPROF",
        [156] = "SIGWINCH",
        [157] = "SIGIO",
        [158] = "SIGPWR",
        [159] = "SIGSYS",
        [162] = "SIGRTMIN",
        [163] = "SIGRTMIN+1",
        [164] = "SIGRTMIN+2",
        [165] = "SIGRTMIN+3",
        [166] = "SIGRTMIN+4",
        [167] = "SIGRTMIN+5",
        [168] = "SIGRTMIN+6",
        [169] = "SIGRTMIN+7",
        [170] = "SIGRTMIN+8",
        [171] = "SIGRTMIN+9",
        [172] = "SIGRTMIN+10",
        [173] = "SIGRTMIN+11",
        [174] = "SIGRTMIN+12",
        [175] = "SIGRTMIN+13",
        [176] = "SIGRTMIN+14",
        [177] = "SIGRTMIN+15",
        [178] = "SIGRTMAX-14",
        [179] = "SIGRTMAX-13",
        [180] = "SIGRTMAX-12",
        [181] = "SIGRTMAX-11",
        [182] = "SIGRTMAX-10",
        [183] = "SIGRTMAX-9",
        [184] = "SIGRTMAX-8",
        [185] = "SIGRTMAX-7",
        [186] = "SIGRTMAX-6",
        [187] = "SIGRTMAX-5",
        [188] = "SIGRTMAX-4",
        [189] = "SIGRTMAX-3",
        [190] = "SIGRTMAX-2",
        [191] = "SIGRTMAX-1",
        [192] = "SIGRTMAX"
    }

    if exitcodes[p.exitcode] == nil then
        text =  tostring(p.exitcode)
    else
        text =  exitcodes[p.exitcode]
    end

    return {{
        foreground = p.theme.exitcodeFg,
        background = p.theme.exitcodeBg,
        text       = text,
        name       = 'exitcode'
    }}
end

return exitcode
