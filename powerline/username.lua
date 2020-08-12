local username = {}

function username.main(p)

	text =  "\\u"
	return {{
		foreground = p.theme.usernameFg,
		background = p.theme.usernameBg,
		text       = text,
		name       = 'username'
	}}
end

return username
