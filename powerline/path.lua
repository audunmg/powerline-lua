local path = {}

function path.main(p)

	text =  "\\w"
	return {{
		foreground = p.theme.pathFg,
		background = p.theme.pathBg,
		text       = text
	}}
end

return path
