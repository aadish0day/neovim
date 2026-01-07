return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					-- Disable treesitter in previews to fix ft_to_lang error
					preview = {
						treesitter = false,
					},
					mappings = {
						i = {
							["<C-h>"] = "which_key",
							["<C-k>"] = require("telescope.actions").move_selection_previous,
							["<C-j>"] = require("telescope.actions").move_selection_next,
						},
					},
				},
				pickers = {
					buffers = {
						sort_mru = true,
						ignore_current_buffer = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			
			-- Load extensions
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")
			
			-- Keymaps
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Fuzzy find buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
			vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "Fuzzy find in current buffer" })
		end,
	},
}
