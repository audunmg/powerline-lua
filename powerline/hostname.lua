local hostname = {}

function hostname.main(p)
    text = "\\h"
	if (p.hostname) then
        text = p.hostname
    end
	return {{
		foreground = p.theme.hostnameFg,
		background = p.theme.hostnameBg,
		text       = text,
		name       = 'hostname'
	}}
end

return hostname
