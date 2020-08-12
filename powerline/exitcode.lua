local exitcode = {}

function exitcode.main(p)
	if (p.exitcode == nil) or (p.exitcode == 0) then
		return {
		foreground = 0,
		background = 0,
		text       = ''
	  }
	end
	
	exitcodes = {}
	-- Wish i could do this in one go...
	exitcodes[1] = "ERROR"
	exitcodes[2] = "USAGE"
	exitcodes[126] =  "NOPERM"
	exitcodes[127] = "NOTFOUND"
  exitcodes[129] = "SIGHUP"
  exitcodes[130] = "SIGINT"
  exitcodes[131] = "SIGQUIT"
  exitcodes[132] = "SIGILL"
  exitcodes[133] = "SIGTRAP"
  exitcodes[134] = "SIGABRT"
  exitcodes[135] = "SIGBUS"
  exitcodes[136] = "SIGFPE"
  exitcodes[137] = "SIGKILL"
  exitcodes[138] = "SIGUSR1"
  exitcodes[139] = "SIGSEGV"
  exitcodes[140] = "SIGUSR2"
  exitcodes[141] = "SIGPIPE"
  exitcodes[142] = "SIGALRM"
  exitcodes[143] = "SIGTERM"
  exitcodes[144] = "SIGSTKFLT"
  exitcodes[145] = "SIGCHLD"
  exitcodes[146] = "SIGCONT"
  exitcodes[147] = "SIGSTOP"
  exitcodes[148] = "SIGTSTP"
  exitcodes[149] = "SIGTTIN"
  exitcodes[150] = "SIGTTOU"
  exitcodes[151] = "SIGURG"
  exitcodes[152] = "SIGXCPU"
  exitcodes[153] = "SIGXFSZ"
  exitcodes[154] = "SIGVTALRM"
  exitcodes[155] = "SIGPROF"
  exitcodes[156] = "SIGWINCH"
  exitcodes[157] = "SIGIO"
  exitcodes[158] = "SIGPWR"
  exitcodes[159] = "SIGSYS"
  exitcodes[162] = "SIGRTMIN"
  exitcodes[163] = "SIGRTMIN+1"
  exitcodes[164] = "SIGRTMIN+2"
  exitcodes[165] = "SIGRTMIN+3"
  exitcodes[166] = "SIGRTMIN+4"
  exitcodes[167] = "SIGRTMIN+5"
  exitcodes[168] = "SIGRTMIN+6"
  exitcodes[169] = "SIGRTMIN+7"
  exitcodes[170] = "SIGRTMIN+8"
  exitcodes[171] = "SIGRTMIN+9"
  exitcodes[172] = "SIGRTMIN+10"
  exitcodes[173] = "SIGRTMIN+11"
  exitcodes[174] = "SIGRTMIN+12"
  exitcodes[175] = "SIGRTMIN+13"
  exitcodes[176] = "SIGRTMIN+14"
  exitcodes[177] = "SIGRTMIN+15"
  exitcodes[178] = "SIGRTMAX-14"
  exitcodes[179] = "SIGRTMAX-13"
  exitcodes[180] = "SIGRTMAX-12"
  exitcodes[181] = "SIGRTMAX-11"
  exitcodes[182] = "SIGRTMAX-10"
  exitcodes[183] = "SIGRTMAX-9"
  exitcodes[184] = "SIGRTMAX-8"
  exitcodes[185] = "SIGRTMAX-7"
  exitcodes[186] = "SIGRTMAX-6"
  exitcodes[187] = "SIGRTMAX-5"
  exitcodes[188] = "SIGRTMAX-4"
  exitcodes[189] = "SIGRTMAX-3"
  exitcodes[190] = "SIGRTMAX-2"
  exitcodes[191] = "SIGRTMAX-1"
  exitcodes[192] = "SIGRTMAX"
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
