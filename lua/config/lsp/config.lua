local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

-- local servers = { "jsonls", "sumneko_lua","html","cssls","tsserver"}
-- local servers = { "jdtls", "yamlls" }
local servers = {}

lsp_installer.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("config.lsp.handlers").on_attach,
		capabilities = require("config.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "config.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end

lspconfig.yamlls.setup({
	filetypes = { "yaml", "yaml.docker-compose" },
	settings = {
		yaml = {
			schemaStore = {
				-- You must disable built-in schemaStore support if you want to use
				-- this plugin and its advanced options like `ignore`.
				enable = false,
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})