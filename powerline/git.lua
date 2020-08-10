local git = {}

function git.main(p)

	text =  "\\$"
	return {
		foreground = p.theme.gitFg,
		background = p.theme.gitBg,
		text       = text
	}
end

return git
