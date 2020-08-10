local ssh = {}

function ssh.main(p)

	text = ''
	if not (os.getenv("SSH_CLIENT") == nil) then
		text =  p.theme.sshIndicator
	end

	return {{
		foreground = p.theme.sshFg,
		background = p.theme.sshBg,
		text       = text
	}}
end

return ssh
