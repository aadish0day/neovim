return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = {
				enabled = false, -- Handled dynamically with textobjects by mini.indentscope
			},
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"NvimTree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
					"oil",
				},
				buftypes = { "terminal", "nofile", "quickfix", "prompt" },
			},
		},
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		opts = function()
			return {
				symbol = "│",
				options = { try_as_border = true },
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation.none(),
					priority = 20,
				},
				mappings = {
					object_scope = "ii",
					object_scope_with_border = "ai",
					goto_top = "[i",
					goto_bottom = "]i",
				},
			}
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)

			-- Use a stylish accent color linked to theme instead of error red
			local function set_hl()
				vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Special", nocombine = true })
			end
			set_hl()
			vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })

			-- Disable in special buffers & tools
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "NvimTree", "undotree", "mason", "lazy", "oil", "help", "Trouble", "trouble" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}
