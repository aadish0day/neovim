return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim", -- Add this
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"j-hui/fidget.nvim",
			"onsails/lspkind-nvim",
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

			-- Mason LSP setup
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"clangd",
					"cssls",
					"html",
					"jdtls",
					"ts_ls",
					"pyright",
					"tinymist",
					"ruff",
				},
				automatic_installation = true,
			})

			-- Mason Tool Installer setup (for formatters/linters)
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"ruff",
					"shfmt",
					"clang-format",
					"typstyle",
					"prettierd",
					"prettier",
					"debugpy",
				},
			})

			-- Keymapping to open Mason
			vim.keymap.set("n", "<leader>m", ":Mason<CR>", { silent = true })

			require("fidget").setup({})

			-- LSP capabilities
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Use the new vim.lsp.config API instead of require('lspconfig')
			local servers = { "html", "cssls", "ts_ls", "bashls", "clangd", "ruff" }

			for _, server in ipairs(servers) do
				local existing = vim.lsp.config[server] or {}
				vim.lsp.config[server] = vim.tbl_deep_extend("force", existing, {
					capabilities = capabilities,
				})
			end

			-- TypeScript 7 (native) ships no tsserver.js, so ts_ls can't use it.
			-- Use TS 7's built-in LSP (`tsc --lsp`) in those projects, ts_ls everywhere else.
			local function uses_ts7(bufnr)
				local root = vim.fs.root(bufnr, "node_modules")
				if not root then
					return false
				end
				local ok, pkg = pcall(vim.fn.readfile, root .. "/node_modules/typescript/package.json")
				if not ok then
					return false
				end
				local ok_json, parsed = pcall(vim.json.decode, table.concat(pkg, "\n"))
				if not ok_json or type(parsed) ~= "table" then
					return false
				end
				local version = parsed.version or ""
				return (tonumber(version:match("^(%d+)")) or 0) >= 7
			end

			local ts_ls_root = vim.lsp.config.ts_ls.root_dir
			vim.lsp.config("ts_ls", {
				root_dir = function(bufnr, on_dir)
					if not uses_ts7(bufnr) and ts_ls_root then
						if on_dir then
							return ts_ls_root(bufnr, on_dir)
						else
							local root
							ts_ls_root(bufnr, function(r)
								root = r
							end)
							return root
						end
					end
				end,
			})

			local tsc_root = vim.lsp.config.tsc.root_dir
			vim.lsp.config("tsc", {
				capabilities = capabilities,
				cmd = function(dispatchers, config)
					local root = config and config.root_dir
					local bin = root and vim.fs.joinpath(root, "node_modules/.bin/tsc")
					if not bin or vim.fn.executable(bin) ~= 1 then
						bin = "tsc"
					end
					return vim.lsp.rpc.start({ bin, "--lsp", "--stdio" }, dispatchers)
				end,
				root_dir = function(bufnr, on_dir)
					if uses_ts7(bufnr) and tsc_root then
						if on_dir then
							return tsc_root(bufnr, on_dir)
						else
							local root
							tsc_root(bufnr, function(r)
								root = r
							end)
							return root
						end
					end
				end,
			})
			vim.lsp.enable("tsc")

			-- Setup for Java using jdtls
			local java27 = "/usr/lib/jvm/java-27-openjdk"
			local jdtls_env = vim.fn.isdirectory(java27) == 1 and {
				JAVA_HOME = java27,
				PATH = java27 .. "/bin:" .. vim.env.PATH,
			} or nil

			vim.lsp.config.jdtls = {
				capabilities = capabilities,
				cmd_env = jdtls_env,
				root_dir = function(bufnr, on_dir)
					local path = vim.api.nvim_buf_get_name(bufnr)
					local root = vim.fs.root(path, { "gradlew", "mvnw", ".git" })
					if on_dir and root then
						on_dir(root)
					end
					return root
				end,
			}

			-- Setup for Python LSP
			vim.lsp.config.pyright = {
				capabilities = capabilities,
			}

			-- Setup for Typst LSP using tinymist
			vim.lsp.config.tinymist = {
				capabilities = capabilities,
				cmd = { "tinymist" },
				filetypes = { "typst" },
				root_dir = function(bufnr, on_dir)
					local path = vim.api.nvim_buf_get_name(bufnr)
					local root = vim.fs.root(path, { ".git", "." })
					if on_dir and root then
						on_dir(root)
					end
					return root
				end,
				settings = {
					exportPdf = "onType", -- Export PDF on each save
					outputPath = "$root/$dir/$name", -- PDF output path
				},
			}

			-- Special configuration for Lua
			vim.lsp.config.lua_ls = {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
							},
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			}

			-- Snippet and completion setup
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").load()
			require("luasnip.loaders.from_lua").load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.scroll_docs(-4),
					["<C-n>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						local has_copilot, copilot_suggestion = pcall(require, "copilot.suggestion")
						if has_copilot and copilot_suggestion.is_visible() then
							copilot_suggestion.accept()
						elseif cmp.visible() then
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
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					format = function(entry, item)
						local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
						item = require("lspkind").cmp_format({
							mode = "symbol_text",
							maxwidth = 50,
							ellipsis_char = "...",
						})(entry, item)
						if color_item.abbr_hl_group then
							item.kind_hl_group = color_item.abbr_hl_group
							item.kind = color_item.abbr
						end
						return item
					end,
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path" },
					{ name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
				},
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Diagnostics configuration
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN] = "▲",
						[vim.diagnostic.severity.HINT] = "⚑",
						[vim.diagnostic.severity.INFO] = "»",
					},
				},
			})

			-- Autopairs setup for nvim-cmp
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			-- Link cmp with nvim-autopairs
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			-- LSP key mapping and document highlight configuration
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions and document highlight",
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					local opts = { buffer = event.buf }
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

					-- Highlight references of the symbol under cursor
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
						local highlight_group = vim.api.nvim_create_augroup("lsp-highlight-" .. event.buf, { clear = true })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_group,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_group,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach-" .. event.buf, { clear = true }),
							callback = function(event2)
								if event2.buf == event.buf then
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({ group = "lsp-highlight-" .. event.buf, buffer = event.buf })
								end
							end,
						})
					end
				end,
			})
		end,
	},
}
