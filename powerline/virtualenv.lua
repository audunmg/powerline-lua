local virtualenv = {}

function virtualenv.main(p)

	text =  ""
    if os.getenv('VIRTUAL_ENV_PROMPT') then
        text = string.gsub(os.getenv('VIRTUAL_ENV_PROMPT'),"^[(](.*)[)] $","%1")
    end
	return {{
		foreground = p.theme.virtualenvFg,
		background = p.theme.virtualenvBg,
		text       = text,
		name       = 'virtualenv'
	}}
end

return virtualenv
