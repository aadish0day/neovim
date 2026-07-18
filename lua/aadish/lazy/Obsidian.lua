return {
	{
		"obsidian-nvim/obsidian.nvim",
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
				min_chars = 2,
			},
			new_notes_location = "current_dir",
			link = {
				style = "wiki",
			},
			frontmatter = {
				enabled = false,
			},
			legacy_commands = false,

			picker = {
				name = "telescope.nvim",
			},

			-- Show recently modified notes first in search
			search = {
				sort_by = "modified",
				sort_reversed = true,
			},

			checkboxes = {
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				[">"] = { char = "", hl_group = "ObsidianRightArrow" },
				["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
				["!"] = { char = "", hl_group = "ObsidianImportant" },
			},

			ui = {
				enable = true,
				update_debounce = 200,
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

			-- Define standard keymaps with descriptive tags for which-key integration
			vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { desc = "Create New Note", noremap = true, silent = true })
			vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", { desc = "Open Today's Note", noremap = true, silent = true })
			vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { desc = "Search Notes", noremap = true, silent = true })
			vim.keymap.set("n", "<leader>oo", function()
				require("obsidian").util.open_app()
			end, { desc = "Open Obsidian App", noremap = true, silent = true })

			-- Additional productivity keymaps
			vim.keymap.set("n", "<leader>ob", ":ObsidianBacklinks<CR>", { desc = "View Backlinks", noremap = true, silent = true })
			vim.keymap.set("n", "<leader>ol", ":ObsidianLinks<CR>", { desc = "View Links in Note", noremap = true, silent = true })
			vim.keymap.set("n", "<leader>oi", ":ObsidianLink<CR>", { desc = "Link Existing Note", noremap = true, silent = true })
			vim.keymap.set("n", "<leader>or", ":ObsidianRename<CR>", { desc = "Rename Note & References", noremap = true, silent = true })
			vim.keymap.set("n", "<leader>op", ":ObsidianPasteImg<CR>", { desc = "Paste Image from Clipboard", noremap = true, silent = true })

			-- Command to automatically run the study session script for the current daily note
			vim.api.nvim_create_user_command("CyberSecStudy", function()
				-- Save current buffer if it has modifications to prevent conflict warnings
				vim.cmd("silent! write")

				-- Get the date from the current buffer filename (e.g. "2025-07-17")
				local current_file = vim.fn.expand("%:t:r")

				local vault_path = vim.fn.expand("~/Documents/Obsidian")
				local script_path = vault_path .. "/scripts/setup_study_session.py"
				vim.fn.jobstart({ "python3", script_path, current_file }, {
					on_exit = function(_, code)
						if code == 0 then
							-- Force reload current buffer to show new study links without warnings
							vim.cmd("edit!")
							print("Study session created and linked successfully!")
						else
							print("Error: Could not create study session. Make sure the filename contains a YYYY-MM-DD date.")
						end
					end
				})
			end, {})

			vim.keymap.set("n", "<leader>od", ":CyberSecStudy<CR>", { desc = "Run Cybersecurity Study Script", noremap = true, silent = true })

			-- Define Markdown-specific buffer keymaps and styling
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					local keymap_opts = { buffer = true, silent = true }
					
					-- Enable conceallevel so Obsidian custom icons and bullets display correctly
					vim.opt_local.conceallevel = 2

					-- Highlight raw URLs with the Obsidian link color (purple)
					vim.fn.matchadd("ObsidianRefText", [[https\?:\/\/[^ \t\r\n<>"]\+]])

					-- Follow link
					vim.keymap.set("n", "gf", function()
						if require("obsidian").util.cursor_on_markdown_link() then
							return "<cmd>ObsidianFollowLink<CR>"
						else
							return "gf"
						end
					end, { noremap = false, expr = true, buffer = true })

					-- Toggle check-boxes
					vim.keymap.set("n", "<leader>ch", function()
						require("obsidian").util.toggle_checkbox()
					end, keymap_opts)

					-- Smart action (follow link / toggle checkbox)
					vim.keymap.set("n", "<cr>", function()
						return require("obsidian").util.smart_action()
					end, { buffer = true, expr = true })
				end,
			})
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
