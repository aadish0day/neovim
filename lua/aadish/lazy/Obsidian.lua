return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "obsidian",
					path = "~/Documents/Obsidian",
				},
			},
			daily_notes = {
				folder = "Daily note",
				date_format = "%Y-%m-%d",
				alias_format = "%B %-d, %Y",
				default_tags = { "daily-notes" },
			},
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
			mappings = {
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes.
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
				-- Smart action depending on context, either follow link or toggle checkbox.
				["<cr>"] = {
					action = function()
						return require("obsidian").util.smart_action()
					end,
					opts = { buffer = true, expr = true },
				},
			},
			new_notes_location = "current_dir",
			preferred_link_style = "wiki",
			disable_frontmatter = true,

			follow_url_func = function(url)
				vim.fn.jobstart({ "xdg-open", url })
			end,
			follow_img_func = function(img)
				vim.fn.jobstart({ "xdg-open", img })
			end,

			picker = {
				name = "telescope.nvim",
			},

			ui = {
				enable = true,
				update_debounce = 200,
				checkboxes = {
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
					[">"] = { char = "", hl_group = "ObsidianRightArrow" },
					["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
					["!"] = { char = "", hl_group = "ObsidianImportant" },
				},
				bullets = { char = "•", hl_group = "ObsidianBullet" },
				external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				reference_text = { hl_group = "ObsidianRefText" },
				highlight_text = { hl_group = "ObsidianHighlightText" },
				tags = { hl_group = "ObsidianTag" },
				block_ids = { hl_group = "ObsidianBlockID" },
				hl_groups = {
					ObsidianTodo = { bold = true, fg = "#f78c6c" },
					ObsidianDone = { bold = true, fg = "#89ddff" },
					ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
					ObsidianTilde = { bold = true, fg = "#ff5370" },
					ObsidianImportant = { bold = true, fg = "#d73128" },
					ObsidianBullet = { bold = true, fg = "#89ddff" },
					ObsidianRefText = { underline = true, fg = "#c792ea" },
					ObsidianExtLinkIcon = { fg = "#c792ea" },
					ObsidianTag = { italic = true, fg = "#89ddff" },
					ObsidianBlockID = { italic = true, fg = "#89ddff" },
					ObsidianHighlightText = { bg = "#75662e" },
				},
			},
		},
		config = function(_, opts)
			require("obsidian").setup(opts)

			local map_opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", map_opts)
			vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", map_opts)
			vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", map_opts)
			vim.keymap.set("n", "<leader>oo", function()
				require("obsidian").util.open_app()
			end, map_opts)
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = ":call mkdp#util#install()",
		ft = { "markdown", "vimwiki" },
		config = function()
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_refresh_slow = 0
			vim.g.mkdp_command_for_global = 0
			vim.g.mkdp_open_to_the_world = 0
			vim.g.mkdp_browser = ""
			vim.g.mkdp_preview_options = {
				mkit = {},
				katex = {},
				uml = {},
				maid = {},
				disable_sync_scroll = 0,
				sync_scroll_type = "middle",
			}
		end,
		keys = {
			{ "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview" },
			{ "<leader>mo", "<Cmd>MarkdownPreview<CR>", desc = "Open Markdown Preview" },
			{ "<leader>mc", "<Cmd>MarkdownPreviewStop<CR>", desc = "Close Markdown Preview" },
		},
	},
}
