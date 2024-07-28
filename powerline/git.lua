local git = {}

function git.addRepoStatsSegment(number, symbol, foreground, background)
    if (not (number == nil)) and (number > 0) then
        return {
            name = "git-stats",
            foreground = foreground,
            background = background,
            text = string.format("%d%s", number, symbol),
        }
    else
        return {}
    end
end

function git.runGitCommand(cmd)
    local f = io.popen(cmd, 'r')
    local s = f:read('*a')
    f:close()
    return s
end

function git.repoRoot()
    local a = git.runGitCommand('git rev-parse --show-toplevel 2>&1')
    return a
end

function git.repostats()
    local gitcommand = "git status --porcelain -b --ignore-submodules"
    local a = git.runGitCommand(gitcommand)
    local stats = {
        untracked = 0,
        conflicted = 0,
        staged = 0,
        notStaged = 0
    }
    local conflicted = {
        DD = true,
        AU = true,
        UD = true,
        UA = true,
        DU = true,
        AA = true,
        UU = true
    }
    for line in string.gmatch(a, "[^\n]+") do
        local k = string.sub(line,1,2)
        if k == "##" then
            if line:match('%.%.%.') then
                for lbranch,rbranch,ahead,behind in line:gmatch('## (%S+)%.%.%.(%S+) ?%[?a?h?e?a?d? ?(%d*),? ?b?e?h?i?n?d? ?(%d*)%]?') do 
                    stats.lbranch = lbranch
                    stats.rbranch = rbranch
                    stats.ahead = tonumber(ahead)
                    stats.behind = tonumber(behind)
                end
            else
                -- no remote, so probably no ahead/behind
                stats.lbranch = line:match('## (.*)')
                if (stats.lbranch == 'HEAD (no branch)' )then
                    stats.lbranch = nil
                end
            end

        elseif (k == "??") then
            stats.untracked = stats.untracked + 1
        elseif conflicted[k]  then
            stats.conflicted = stats.conflicted +1
        else
            if not (string.sub(k,1,1) == ' ') then
                stats.staged = stats.staged + 1
            end
            if not (string.sub(k,2,2) == ' ') then
                stats.notStaged = stats.notStaged + 1
            end
        end
    end

    stats.dirty = (stats.untracked + stats.conflicted + stats.staged + stats.notStaged) > 0
    return stats
end



function git.main(p)
    local repoRoot = git.repoRoot(p.cwd)
    if repoRoot:match('^fatal:') then
        return {{
            name = 'git',
            text = nil
        }}
    end


    local r = git.repostats(p)
    local segments = {}
    if r.dirty then
        table.insert(segments, { name = 'git-branch', text = r.lbranch, foreground = p.theme.RepoDirtyFg, background = p.theme.RepoDirtyBg} )
    else
        table.insert(segments, { name = 'git-branch', text = r.lbranch, foreground = p.theme.RepoCleanFg, background = p.theme.RepoCleanBg} )
    end
    table.insert(segments, git.addRepoStatsSegment(r.ahead, p.theme.RepoAhead, p.theme.gitAheadFg, p.theme.gitAheadBg ))
    table.insert(segments, git.addRepoStatsSegment(r.behind, p.theme.RepoBehind, p.theme.gitBehindFg, p.theme.gitBehindBg ))
    table.insert(segments, git.addRepoStatsSegment(r.staged, p.theme.RepoStaged, p.theme.gitStagedFg, p.theme.gitStagedBg ))
    table.insert(segments, git.addRepoStatsSegment(r.notStaged, p.theme.RepoNotStaged, p.theme.gitNotStagedFg, p.theme.gitNotStagedBg ))
    table.insert(segments, git.addRepoStatsSegment(r.untracked, p.theme.RepoUntracked, p.theme.gitUntrackedFg, p.theme.gitUntrackedBg ))
    table.insert(segments, git.addRepoStatsSegment(r.conflicted, p.theme.RepoConflicted, p.theme.gitConflictedFg, p.theme.gitConflictedBg ))
    table.insert(segments, git.addRepoStatsSegment(r.stashed, p.theme.RepoStashed, p.theme.gitStashedFg, p.theme.gitStashedBg ))


    return segments
end

return git
