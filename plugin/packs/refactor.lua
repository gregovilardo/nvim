local keymap = vim.keymap

keymap.set({ "n", "x" }, "<leader>rs", function()
	-- this keymap doesn't select any textobject by default, so you may need to provide one each time you use it.
	require("refactoring").select_refactor()
end, { desc = "Select refactor" })

keymap.set({ "n", "x" }, "<leader>re", function()
	return require("refactoring").extract_func()
end, { desc = "Extract Function", expr = true })
