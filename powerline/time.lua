local time = {}

function time.main(p)
    text = ""
    os = require("os")
    time = os.time()
    if (p.time) then
        time = p.time
    end
    if (p.timeformat) then
        text = os.date(p.timeformat, time)
    else
        text = os.date(nil, time)
    end
    return {{
        foreground = p.theme.timeFg,
        background = p.theme.timeBg,
        text       = text,
        name       = 'time'
    }}
end

return time
