return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		--Enable (broadcasting) snippet capability for completion
		local capabilities2 = vim.lsp.protocol.make_client_capabilities()
		capabilities2.textDocument.completion.completionItem.snippetSupport = true

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities2,
			on_attach = on_attach,
			filetypes = { "html", "templ" },
		})

		lspconfig.htmx.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "html", "templ" },
		})

		lspconfig["templ"].setup({
			capabilities = capabilities2,
			on_attach = on_attach,
		})

		lspconfig["ccls"].setup({
			capabilities = capabilities2,
			on_attach = on_attach,
		})

		lspconfig["cmake"].setup({
			capabilities = capabilities2,
			on_attach = on_attach,
		})

		-- configure volar server
		lspconfig["volar"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				init_options = {
					typescript = {
						tsdk = vim.fn.stdpath("data")
							.. "/mason/packages/vue-language-server/node_modules/typescript/lib",
					},
				},
				languageFeatures = {
					implementation = true,
					references = true,
					definition = true,
					typeDefinition = true,
					callHierarchy = true,
					hover = true,
					rename = true,
					renameFileRefactoring = true,
					signatureHelp = true,
					codeAction = true,
					workspaceSymbol = true,
					diagnostics = true,
					semanticTokens = false,
				},
			},
		})

		-- configure typescript server with plugin
		-- lspconfig["tsserver"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- 	settings = {
		-- 		javascript = {
		-- 			inlayHints = {
		-- 				includeInlayEnumMemberValueHints = true,
		-- 				includeInlayFunctionLikeReturnTypeHints = true,
		-- 				includeInlayFunctionParameterTypeHints = true,
		-- 				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
		-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
		-- 				includeInlayPropertyDeclarationTypeHints = true,
		-- 				includeInlayVariableTypeHints = true,
		-- 			},
		-- 		},
		-- 		typescript = {
		-- 			inlayHints = {
		-- 				includeInlayEnumMemberValueHints = true,
		-- 				includeInlayFunctionLikeReturnTypeHints = true,
		-- 				includeInlayFunctionParameterTypeHints = true,
		-- 				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
		-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
		-- 				includeInlayPropertyDeclarationTypeHints = true,
		-- 				includeInlayVariableTypeHints = true,
		-- 			},
		-- 		},
		-- 	},
		-- })

		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure tailwindcss server
		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "templ", "astro", "javascript", "typescript", "react" },
			settings = {
				tailwindCSS = {
					includeLanguages = {
						templ = "html",
					},
					classAttributes = { "class", "className", "ngClass" },
					experimental = {
						classRegex = {
							"tw`([^`]*)", -- tw`...`
							"tw='([^']*)", -- <div tw="..." />
							"tw={`([^`}]*)", -- <div tw={"..."} />
							"tw\\.\\w+`([^`]*)", -- tw.xxx`...`
							"tw\\(.*?\\)`([^`]*)", -- tw(component)`...`
							"styled\\(.*?, '([^']*)'\\)",
							{ "cn\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
							{ "clsx\\(([^]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
							{ "(?:twMerge|twJoin)\\(([^\\);]*)[\\);]", "[`'\"`]([^'\"`,;]*)[`'\"`]" },
							{ "{([\\s\\S]*)}", ":\\s*['\"`]([^'\"`]*)['\"`]" },
						},
					},
				},
			},
		})

		-- configure svelte server
		lspconfig["svelte"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)

				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						if client.name == "svelte" then
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
						end
					end,
				})
			end,
		})

		-- configure prisma orm server
		lspconfig["prismals"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure graphql language server
		lspconfig["graphql"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		-- configure emmet language server
		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"html",
				"htmx",
				"templ",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
				"php",
				"jsx",
			},
		})

		-- configure gopls language server
		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				gopls = {
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
					analyses = {
						unusedparams = true,
						shadow = true,
					},
					staticcheck = true,
				},
			},
			filetypes = { "go", "gomod", "gotmpl" }, -- adding "gotmpl" for template files
		})

		-- configure jdtls language server
		lspconfig["jdtls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "java" },
			autostart = false,
		})

		-- configure sqlls language server
		lspconfig["sqlls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = function()
				return vim.loop.cwd()
			end,
		})

		-- configure jsonls language server
		lspconfig["jsonls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})

		-- configure python server
		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
					},
				},
			},
		})

		-- configure C/C++ server
		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
			},
		})

		-- configure php server
		lspconfig["intelephense"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = function(fname)
				return vim.fn.getcwd()
			end,
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					semantic = {
						enable = false,
					},
					hint = { enable = true },
					telemetry = { enable = false },
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
						checkThirdParty = false,
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
				},
			},
		})
	end,
}
