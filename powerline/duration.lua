local duration = {}

function duration.main(p)
    milliseconds = 1
    seconds = milliseconds * 1000
    minutes = seconds * 60
    hours   = minutes * 60
    if os.getenv('PL_DURATION') then
        dur = math.floor(tonumber(os.getenv('PL_DURATION')) * 1000)
    elseif os.getenv('PL_DURATION_MS') then
        dur = tonumber(os.getenv('PL_DURATION_MS'))
    elseif p.duration then
        dur = math.floor(p.duration * 1000)
    else
        return {{ text = nil, name = 'duration', foreground = 0, background = 0}}
    end

    if not (dur == nil or dur == 0) then
        h = math.floor(dur / hours)
        m = math.floor(dur % hours / minutes)
        s = math.floor(dur % minutes / seconds)
        ms  = math.floor(dur % seconds / milliseconds)
        -- print(string.format("%dh %dm %ds %dms", h,m,s,ms))
        if dur > hours then
            text = string.format("%dh %dm", h,m)
        elseif dur > minutes then
            text = string.format("%dm %ds", m,s)
        elseif dur >= seconds then
            if ms == 0 then
                text = string.format("%ds", s)
            else
                text = string.format("%ds %dms",s,ms)
            end
        elseif dur > 0 then
            text = string.format("%dms", ms)
        end
    else
        text = nil
    end
    return {{
        foreground = p.theme.durationFg,
        background = p.theme.durationBg,
        text       = text,
        name       = 'duration'
    }}
end

return duration
