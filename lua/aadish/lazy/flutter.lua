return {
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
			"mfussenegger/nvim-dap",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("flutter-tools").setup({
				ui = {
					border = "rounded",
					notification_style = "plugin",
				},
				decorations = {
					statusline = {
						app_version = false,
						device = true,
					},
				},
				widget_guides = {
					enabled = true,
				},
				closing_tags = {
					highlight = "Comment",
					prefix = "// ",
					enabled = true,
				},
				dev_log = {
					enabled = true,
					open_cmd = "tabedit",
					focus_on_open = false,
				},
				dev_tools = {
					autostart = false,
					auto_open_browser = false,
				},
				outline = {
					open_cmd = "30vnew",
					auto_open = false,
				},
				lsp = {
					on_attach = function(client, bufnr)
						if vim.lsp.document_color and vim.lsp.document_color.enable then
							pcall(vim.lsp.document_color.enable, true, { bufnr = bufnr })
						end
					end,
					capabilities = capabilities,
					settings = {
						showTodos = true,
						completeFunctionCalls = true,
						analysisExcludedFolders = {
							vim.fn.expand("$HOME/.pub-cache"),
						},
						renameFilesWithClasses = "prompt",
						enableSnippets = true,
						updateImportsOnRename = true,
					},
				},
				debugger = {
					enabled = true,
					run_via_dap = true,
					register_configurations = function(_)
						local dap = require("dap")
						dap.adapters.dart = {
							type = "executable",
							command = "flutter",
							args = { "debug-adapter" },
						}
						dap.adapters.flutter = {
							type = "executable",
							command = "flutter",
							args = { "debug-adapter" },
						}
						dap.configurations.dart = {
							{
								type = "dart",
								request = "launch",
								name = "Launch Flutter App",
								program = "${workspaceFolder}/lib/main.dart",
								cwd = "${workspaceFolder}",
							},
						}
					end,
				},
			})

			-- Load telescope flutter extension if telescope is present
			pcall(function()
				require("telescope").load_extension("flutter")
			end)

			-- Register which-key group if available
			local ok, wk = pcall(require, "which-key")
			if ok then
				wk.add({
					{ "<leader>F", group = "Flutter" },
				})
			end

			-- Flutter Keymaps
			local map = vim.keymap.set
			map("n", "<leader>Fs", "<cmd>FlutterRun<CR>", { desc = "Flutter Run / Start" })
			map("n", "<leader>Fq", "<cmd>FlutterQuit<CR>", { desc = "Flutter Quit" })
			map("n", "<leader>Fr", "<cmd>FlutterReload<CR>", { desc = "Flutter Hot Reload" })
			map("n", "<leader>FR", "<cmd>FlutterRestart<CR>", { desc = "Flutter Hot Restart" })
			map("n", "<leader>Fd", "<cmd>FlutterDevices<CR>", { desc = "Flutter Devices" })
			map("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>", { desc = "Flutter Emulators" })
			map("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", { desc = "Flutter Outline Toggle" })
			map("n", "<leader>Fl", "<cmd>FlutterDevLog<CR>", { desc = "Flutter Dev Log" })
			map("n", "<leader>Ft", "<cmd>FlutterDevTools<CR>", { desc = "Flutter DevTools" })
			map("n", "<leader>Fv", "<cmd>FlutterVisualDebug<CR>", { desc = "Flutter Visual Debug" })
			map("n", "<leader>Fc", "<cmd>Telescope flutter commands<CR>", { desc = "Flutter Commands (Telescope)" })
		end,
	},
}
