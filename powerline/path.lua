local path = {}

function path.main(p)
    if params.path then
        text = params.path
    else
    	text =  "\\w"
    end
	return {{
		foreground = p.theme.pathFg,
		background = p.theme.pathBg,
		text       = text,
		name       = 'path'
	}}
end

return path
