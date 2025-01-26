if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("utils.debug").dump(...)
end
vim.print = _G.dd
vim.g.lazy_auto_update = false
require("config.lazy")
