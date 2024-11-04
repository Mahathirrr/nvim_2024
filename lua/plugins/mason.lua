return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				-- "tsserver",
				"templ",
				"html",
				"cssls",
				"lua_ls",
				"vimls",
				"tailwindcss",
				"svelte",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"clangd",
				"gopls",
				"jdtls",
				"jsonls",
				"intelephense",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		-- local disabled_servers = {
		-- 	"jdtls",
		-- 	"tsserver",
		-- }
		--
		-- mason_lspconfig.setup_handlers({
		-- 	-- Automatically configure the LSP installed
		-- 	function(server_name)
		-- 		for _, name in pairs(disabled_servers) do
		-- 			if name == server_name then
		-- 				return
		-- 			end
		-- 		end
		-- 	end,
		-- })

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				-- "stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- js linter
				"clang-format",
				"phpcbf",
				"golangci-lint-langserver",
				"goimports",
				"gofumpt",
				"gomodifytags",
				"gotests",
				"impl",
			},
		})
	end,
}
