require("nvim-surround").setup({
    keymaps = {
        -- Normal mode mappings
        normal = "ys",           -- Surround a motion
        normal_cur = "yss",      -- Surround the current line
        normal_line = "yS",      -- Surround a motion, with newlines
        normal_cur_line = "ySS", -- Surround the current line, with newlines

        -- Visual mode mappings
        visual = "S",       -- Surround a visual selection
        visual_line = "gS", -- Surround a visual line selection

        -- Normal mode mappings for deleting and changing surroundings
        delete = "ds", -- Delete a surrounding
        change = "cs", -- Change a surrounding
    }
})
