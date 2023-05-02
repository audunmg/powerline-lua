local ssh = {}

function ssh.main(p)

    text = ''
    if (params.ssh == true) then
        text =  p.theme.sshIndicator
    end
    if (type(params.ssh) == "string") then
        text = p.theme.sshIndicator .. params.ssh
    end

    return {{
        foreground = p.theme.sshFg,
        background = p.theme.sshBg,
        text       = text,
        name       = 'ssh'
    }}
end

return ssh
