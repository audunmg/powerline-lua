local hostname = {}

function hostname.main(p)
	text =  "\\h"
	return {{
		foreground = p.theme.hostnameFg,
		background = p.theme.hostnameBg,
		text       = text,
		name       = 'hostname'
	}}
end

return hostname
