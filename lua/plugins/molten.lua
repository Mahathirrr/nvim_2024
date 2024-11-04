return {
	{
		"benlubas/molten-nvim",
		dependencies = {
			"3rd/image.nvim",
		},
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_open_output = false
			vim.g.molten_auto_image_popup = true
			vim.g.molten_output_show_exec_time = true
		end,
		event = "BufEnter",
		config = function()
			-- Load and setup the plugin
			-- require("molten").setup({
			-- 	-- Plugin-specific options can be added here
			-- 	-- For example:
			-- 	-- use_split = false,
			-- 	-- open_cmd = "botright 50vnew",
			-- })
		end,
		keys = {
			{ "<leader>mi", ":MoltenInit<CR>", desc = "Initialize Molten" },
			{ "<leader>me", ":MoltenEvaluateOperator<CR>", desc = "Evaluate Operator" },
			{ "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "Evaluate Line" },
			{ "<leader>mr", ":MoltenReevaluateCell<CR>", desc = "Reevaluate Cell" },
			{ "<leader>md", ":MoltenDelete<CR>", desc = "Delete Cell" },
			{ "<leader>ms", ":MoltenShowOutput<CR>", desc = "Show Output" },
		},
	},
}
