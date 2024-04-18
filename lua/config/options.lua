vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

-- vim.opt.lazyredraw = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "cursor"
vim.opt.mouse = ""

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
-- opt.background = "dark" -- colorschemes that can be light or dark will be made dark
-- opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

if vim.fn.has("nvim-0.8") == 1 then
	vim.opt.cmdheight = 0
end

if vim.g.neovide then
	vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
	vim.keymap.set("n", "<c-s>", ":w<CR>") -- Save

	vim.o.guifont = "CaskaydiaCove_Nerd_Font:h10"
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0

	-- config for transparent
	--vim.g.neovide_transparency = 0.8
	vim.g.neovide_transparency = 0.9
	vim.g.neovide_refresh_rate = 144

	-- new extra config
	vim.g.neovide_fullscreen = true

	vim.g.neovide_scale_factor = 1.3

	vim.g.neovide_underline_automatic_scaling = false
	vim.g.neovide_refresh_rate_idle = 5
	vim.g.neovide_no_idle = true
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_touch_drag_timeout = 0.17
	-- animation config
	--vim.g.neovide_scroll_animation_length = 0.3
	--vim.g.neovide_cursor_animation_length = 0.13
	vim.g.neovide_cursor_trail_size = 0.8
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_vfx_mode = "torpedo"

	vim.opt.cmdheight = 0
end

-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap("", "<c-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<c-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<c-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<c-v>", "<C-R>+", { noremap = true, silent = true })
