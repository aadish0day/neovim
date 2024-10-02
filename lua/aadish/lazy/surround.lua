return {

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					insert = "<C-g>s", -- Insert mode: Ctrl-g s
					insert_line = "<C-g>S", -- Insert mode: Surround line
					normal = "ys", -- Normal mode: You Surround
					normal_cur = "yss", -- Normal mode: Surround current line
					normal_line = "yS", -- Normal mode: Surround entire line
					normal_cur_line = "ySS", -- Normal mode: Surround current line with line break
					visual = "S", -- Visual mode: Surround selection
					visual_line = "gS", -- Visual mode: Surround visual line selection
					delete = "ds", -- Normal mode: Delete surround
					change = "cs", -- Normal mode: Change surround
					change_line = "cS", -- Normal mode: Change surround for entire line
				},
				surrounds = {
					["("] = { add = { "(", ")" } }, -- Define your own surround pairs
					[")"] = { add = { "(", ")" } },
					["{"] = { add = { "{ ", " }" } },
					["["] = { add = { "[", "]" } },
					["<"] = { add = { "<", ">" } },
					["t"] = { -- HTML tag surround
						add = function()
							local tag = vim.fn.input("Enter the HTML tag: ")
							return { { "<" .. tag .. ">" }, { "</" .. tag .. ">" } }
						end,
					},
					["f"] = { -- Function surround
						add = function()
							local func_name = vim.fn.input("Enter the function name: ")
							return { { func_name .. "(" }, { ")" } }
						end,
					},
				},
				aliases = {
					["b"] = ")",
					["r"] = "]",
					["q"] = { "'", '"', "`" }, -- Alias `q` to any quote
				},
				highlight = {
					duration = 200, -- Highlight for 200 ms
				},
				move_cursor = "begin", -- Move cursor to the beginning
				indent_lines = true, -- Re-indent lines
			})
			-- Configuration here, or leave empty to use defaults
		end,
	},
}
