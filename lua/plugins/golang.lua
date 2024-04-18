return {
	{
		"olexsmir/gopher.nvim",
		config = function()
			require("gopher").setup({
				commands = {
					go = "go",
					gomodifytags = "gomodifytags",
					gotests = "gotests",
					impl = "impl",
					iferr = "iferr",
				},
			})
		end,
	},
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
	},
}
