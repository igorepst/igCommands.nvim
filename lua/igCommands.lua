local M = {}

local function chcase(s)
    return s:gsub('(%a)([%w]*)', function(first, rest)
        return first:upper() .. rest:lower()
    end)
end

M.setup = function(config)
    config = config or {}
    local prefix = ''
    if config.prefix then
        prefix = chcase(config.prefix)
    end
    local commands = config.commands or {}
    for _, command in ipairs(commands) do
        if command.name and command.cmd then
            local name = prefix .. chcase(command.name):gsub('-', ''):gsub('_', ''):gsub('%s+', '')
            vim.cmd('command! ' .. name .. ' :' .. command.cmd)
            if command.key then
                vim.api.nvim_set_keymap('n', command.key, ':' .. command.cmd .. '<CR>', { noremap=true })
            end
        end
    end
end

return M
