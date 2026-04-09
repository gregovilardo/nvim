require("mini.icons").setup()
require("mini.ai").setup()
-- require("mini.pairs").setup()
require("mini.notify").setup()
require("mini.bracketed").setup()
require("mini.surround").setup()
require("mini.statusline").setup()
require("mini.tabline").setup({
	format = function(buf_id, label)
		local is_current = buf_id == vim.api.nvim_get_current_buf()

		if is_current then
			return " 󰅨 " .. label .. "  "
		else
			return "   " .. label .. "  "
		end
	end,
})

vim.api.nvim_set_hl(0, "MiniTablineCurrent", { fg = "#000000", bg = "#83a598", bold = true })
vim.api.nvim_set_hl(0, "MiniTablineVisible", { fg = "#ebdbb2", bg = "#3c3836" })
vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = "#928374", bg = "#282828" })
