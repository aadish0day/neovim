-- Lua
require('onedark').setup {
    style = 'deep',     -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true, -- Enable transparency

    diagnostics = {
        darker = true,     -- darker colors for diagnostic
        undercurl = true,  -- use under curl instead of underline for diagnostics
        background = true, -- use background color for virtual text
    },
}
require('onedark').load()
