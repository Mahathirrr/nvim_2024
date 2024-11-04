return {
	size = function(term)
		if term.direction == "horizontal" then
			return vim.o.lines * 0.3
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.3
		end
	end,
	open_mapping = [[c-\]],
	hide_numbers = true,
	shade_terminals = false,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	shell = vim.o.shell,
	autochdir = true,
	highlights = {
		NormalFloat = {
			link = "Normal",
		},
		FloatBorder = {
			link = "FloatBorder",
		},
	},
	float_opts = {
		border = "rounded",
		height = 20,
		width = 95,
		winblend = 0,
	},
}
