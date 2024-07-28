local ending = {}

function ending.main(p)

    text =  "\\$"
    return {{
        foreground = p.theme.endingFg,
        background = p.theme.endingBg,
        text       = text,
        name       = 'ending'
    }}
end

return ending
