return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		dependencies = { { "MunifTanjim/nui.nvim" }, { "rcarriga/nvim-notify" } },
		config = function()
			local noice = require("noice")
			noice.setup({
				cmdline = {
					enabled = true, -- enables the Noice cmdline UI
					view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
					opts = {}, -- global options for the cmdline. See section on views
					format = {
						-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
						-- view: (default is cmdline view)
						-- opts: any options passed to the view
						-- icon_hl_group: optional hl_group for the icon
						-- title: set to anything or empty string to hide
						cmdline = { pattern = "^:", icon = "", lang = "vim" },
						search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
						search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
						filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
						lua = {
							pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
							icon = "",
							lang = "lua",
						},
						help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
						input = {}, -- Used by input()
						-- lua = false, -- to disable a format, set to `false`
					},
				},
				routes = {
					{
						view = "notify",
						filter = { event = "msg_showmode" },
					},
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
				},
				lsp = {
					progress = {
						enabled = false,
						-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
						-- See the section on formatting for more details on how to customize.
						format = "lsp_progress",
						format_done = "lsp_progress_done",
						throttle = 1000 / 30, -- frequency to update lsp progress message
						view = "mini",
					},
					override = {
						-- override the default lsp markdown formatter with Noice
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						-- override the lsp markdown formatter with Noice
						["vim.lsp.util.stylize_markdown"] = true,
						-- override cmp documentation with Noice (needs the other options to work)
						["cmp.entry.get_documentation"] = true,
					},
					hover = {
						enabled = false,
						silent = false, -- set to true to not show a message if hover is not available
						view = nil, -- when nil, use defaults from documentation
						opts = {}, -- merged with defaults from documentation
					},
					signature = {
						enabled = false,
						auto_open = {
							enabled = true,
							trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
							luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
							throttle = 50, -- Debounce lsp signature help request by 50ms
						},
						view = nil, -- when nil, use defaults from documentation
						opts = {}, -- merged with defaults from documentation
					},
					message = {
						-- Messages shown by lsp servers
						enabled = true,
						view = "notify",
						opts = {},
					},
					-- defaults for hover and signature help
					documentation = {
						view = "hover",
						opts = {
							lang = "markdown",
							replace = true,
							render = "plain",
							format = { "{message}" },
							win_options = { concealcursor = "n", conceallevel = 3 },
						},
					},
				},
				presets = {
					-- you can enable a preset by setting it to true, or a table that will override the preset config
					-- you can also add custom presets that you can enable/disable with enabled=true
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},

	-- animations
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.scroll = {
				enable = false,
			}
		end,
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				-- separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				-- globalstatus = false,
				theme = "solarized_dark",
			},
		},
	},

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local colors = require("solarized-osaka.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
						InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			window = {
				backdrop = 0.95,
				width = 100,
				height = 0.85,
				options = {
					signcolumn = "no", -- disable signcolumn
					number = false, -- disable number column
					relativenumber = false, -- disable relative numbers
					cursorline = false, -- disable cursorline
					cursorcolumn = false, -- disable cursor column
					foldcolumn = "0", -- disable fold column
					list = false, -- disable whitespace characters
				},
			},
			plugins = {
				options = {
					enabled = true,
					ruler = false,
					showcmd = false,
					laststatus = 0,
				},
				gitsigns = true,
				tmux = true,
				twilight = { enabled = true },
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function(_, opts)
			local logo = [[
			███████╗███╗   ███╗██╗  ██╗ █████╗
			██╔════╝████╗ ████║██║  ██║██╔══██╗
			█████╗  ██╔████╔██║███████║███████║
			██╔══╝  ██║╚██╔╝██║██╔══██║██╔══██║
			███████╗██║ ╚═╝ ██║██║  ██║██║  ██║
			╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝
			   ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"
			opts.config.header = vim.split(logo, "\n")
		end,
	},
}
