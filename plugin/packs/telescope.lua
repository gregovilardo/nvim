local actions = require("telescope.actions")

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension("ui-select"))
pcall(require("telescope").load_extension("git_file_history"))

local builtin = require("telescope.builtin")
-- local extensions = require("telescope").extensions
-- local gfh_actions = extensions.git_file_history.actions

require("telescope").setup({
	defaults = {
		layout_strategy = "horizontal",
		layout_config = { height = 0.99, width = 0.99, preview_width = 0.5 },
	},

	mappings = {
		i = {
			["<C-n>"] = actions.move_selection_next,
			["<C-p>"] = actions.move_selection_previous,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		-- 	git_file_history = {
		-- 		-- Keymaps inside the picker
		-- 		mappings = {
		-- 			i = {
		-- 				["<C-g>"] = gfh_actions.open_in_browser,
		-- 			},
		-- 			n = {
		-- 				["<C-g>"] = gfh_actions.open_in_browser,
		-- 			},
		-- 		},
		--
		-- 		-- The command to use for opening the browser (nil or string)
		-- 		-- If nil, it will check if xdg-open, open, start, wslview are available, in that order.
		-- 		browser_command = nil,
		-- 	},
		-- 	wrap_results = true,
	},
})

vim.keymap.set("n", "<space>ff", builtin.find_files, { desc = "Find files in cwd" })
vim.keymap.set("n", "<space>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<space>fs", builtin.live_grep, { desc = "Find string in cwd" })
vim.keymap.set("n", "<space>fr", builtin.oldfiles, { desc = "Find recent files" })
vim.keymap.set("n", "<space>dw", builtin.diagnostics, { desc = "Diagnostic in current workspace" })
vim.keymap.set("n", "<leader>db", function()
	builtin.diagnostics({ bufnr = 0 })
end, { desc = "Diagnostics in current Buffer" })
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find, { desc = "Current buffer fzf" })
vim.keymap.set("n", "<space>gw", builtin.grep_string, { desc = "Find string under cursor " })
vim.keymap.set("n", "<space>gs", builtin.git_status, { desc = "Git status" })
-- vim.keymap.set("n", "<space>gf", extensions.git_file_history.git_file_history(), { desc = "Git file history" })

vim.keymap.set("n", "<space>cn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find file on nvim config" })
