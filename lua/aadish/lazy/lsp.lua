return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"j-hui/fidget.nvim",
		},
		config = function()
			-- Mason setup
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			vim.keymap.set("n", "<leader>m", ":Mason<CR>", { silent = true })

			-- Mason-tool-installer setup
			require("mason-tool-installer").setup({
				ensure_installed = {
					"shfmt",
					"lua_ls",
					"html",
					"cssls",
					"jdtls",
					"bashls",
					"clangd",
					"ts_ls",
					"stylua",
				},
				auto_update = true,
				run_on_start = true,
				start_delay = 3000,
				debounce_hours = 5,
			})

			require("fidget").setup({
				text = {
					spinner = "dots", -- You can choose from 'dots', 'line', 'dots_pulse', 'line_pulse', 'moon', etc.
					done = "✔️", -- Character displayed when the task is done
					commenced = "Started", -- Message displayed when a task starts
					completed = "Completed", -- Message displayed when a task completes
				},
				align = {
					bottom = true, -- Align the fidget UI to the bottom of the window
					right = true, -- Align the fidget UI to the right of the window
				},
				timer = {
					spinner_rate = 125, -- How fast the spinner updates (in milliseconds)
					fidget_decay = 2000, -- Time in milliseconds to wait before fading out the fidget
				},
				window = {
					blend = 0, -- Transparency level of the fidget window
				},
				fmt = {
					leftpad = true, -- Pad the messages on the left
					max_width = 30, -- Set a maximum width for the messages
				},
				--- Controls when fidget should show
				-- These are all optional
				-- 'LspAttach' will show fidget when LSP attaches to a buffer
				-- 'LspProgress' will show fidget during LSP operations
				-- 'InsertEnter' will show fidget when entering insert mode
				-- 'InsertLeave' will hide fidget when leaving insert mode
				-- 'DiagnosticChanged' will show fidget when diagnostics change
				-- These can be set to true or false
				show = {
					LspAttach = true,
					LspProgress = true,
					InsertEnter = false,
					InsertLeave = true,
					DiagnosticChanged = true,
				},
			})

			-- LSP setup
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
				vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
			end

			local lspconfig = require("lspconfig")
			local servers = { "html", "cssls", "jdtls", "bashls", "clangd", "ts_ls" }

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end

			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						runtime = { version = "LuaJIT" },
						workspace = {
							library = {
								vim.fn.expand("$VIMRUNTIME/lua"),
								vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
							},
						},
						telemetry = { enable = false },
					},
				},
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Snippet and completion setup
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").load()
			require("luasnip.loaders.from_lua").load()

			vim.api.nvim_create_autocmd("InsertLeave", {
				callback = function()
					if
						luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
						and not luasnip.session.jump_active
					then
						luasnip.unlink_current()
					end
				end,
			})

			local kind_icons = {
				Text = "",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰇽",
				Variable = "󰂡",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰅲",
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
						})[entry.source.name]
						return vim_item
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},
}
