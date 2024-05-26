-- Setup which-key
require("which-key").setup({})

-- Which-key configuration for nvim-surround
local wk = require("which-key")

wk.register({
    ["ys"] = {
        name = "+surround",
        ["w"] = { "ysiw", "Surround word" },
        ["p"] = { "ysp", "Surround paragraph" },
        ["<C-g>s"] = { "Insert mode surround" },
        ["S"] = { "Visual mode surround" },
        ["ds"] = { "Delete surround" },
        ["cs"] = { "Change surround" },
    },
    ["yS"] = { "yS", "Surround with new lines" },
    ["ySS"] = { "ySS", "Surround line with new lines" },
    ["<C-g>S"] = { "Insert mode surround with new lines" },
    ["gS"] = { "gS", "Visual mode surround with new lines" },
    ["cS"] = { "cS", "Change surround with new lines" },
}, { prefix = "<leader>" })

wk.register({
    ["ys"] = {
        name = "+surround",
        ["w"] = { "ysiw", "Surround word" },
        ["p"] = { "ysp", "Surround paragraph" },
        ["<C-g>s"] = { "Insert mode surround" },
        ["S"] = { "Visual mode surround" },
        ["ds"] = { "Delete surround" },
        ["cs"] = { "Change surround" },
    },
    ["yS"] = { "yS", "Surround with new lines" },
    ["ySS"] = { "ySS", "Surround line with new lines" },
    ["<C-g>S"] = { "Insert mode surround with new lines" },
    ["gS"] = { "gS", "Visual mode surround with new lines" },
    ["cS"] = { "cS", "Change surround with new lines" },
}, { mode = "n" })

wk.register({
    ["S"] = { "Visual mode surround" },
    ["gS"] = { "Visual mode surround with new lines" },
}, { mode = "v" })


vim.o.timeout = true
vim.o.timeoutlen = 300
