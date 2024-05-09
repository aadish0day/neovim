-- ~/.config/nvim/lua/autopairs_setup.lua
local M = {}

M.setup = function()
    local npairs = require('nvim-autopairs')
    npairs.setup {}

    -- If using nvim-cmp
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    require('cmp').event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done({ map_char = { tex = '' } })
    )
end

return M

