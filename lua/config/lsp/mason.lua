local servers = {
	"lua_ls",
	"cssls",
	"html",
	-- "tsserver",
	"pyright",
	-- "bashls",
	"jsonls",
	-- "yamlls",
	"jdtls",
	"emmet_ls",
	"intelephense",
	"marksman",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
-- * buka remark ini jika akan menggunakan list serverrs diatas dan remark config dibawah
-- require("mason-lspconfig").setup({
-- 	ensure_installed = servers,
-- 	automatic_installation = true,
-- })
--
-- * buka remark ini jika ingin menjalankan dengan cara install dan remark config diatas (pilih satu)
require("mason-lspconfig").setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("neonnex.config.lsp.handlers").on_attach,
		capabilities = require("neonnex.config.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "neonnex.config.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
