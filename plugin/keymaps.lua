local set = vim.keymap.set
-- set leader key to space
vim.g.mapleader = " "

set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- use jk to exit insert mode
set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
set("n", "x", '"_x')

-- delete  without copying into register
set("n", "d", '"_d')

-- yank and delete
set("n", "yd", "d", { desc = "Yank and delete" })

-- increment/decrement numbers
set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- For window resize
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")

set('n', '<C-n>', ':bnext<CR>', { silent = true })
set('n', '<C-p>', ':bprevious<CR>', { silent = true })

set("n", "<leader>e", function()
  require("oil").open(nil, { preview = {} })
end, { desc = "Open parent directory (oil.nvim)" })

set("n", "<C-x>", ":bd<CR>", { desc = "Close current buffer" })

set("n", "<M-j>", ":m+1<CR>", { silent = true, desc = "Swap lines down" })
set("n", "<M-k>", ":m-2<CR>", { silent = true, desc = "Swap lines up" })

set("n", "cd", ":Telescope git_worktree git_worktrees<CR>", { desc = "List an cd to git worktrees" })

-- set("n", "<C-Tab>", "i<CR><Esc>:m-2j$a <Esc>", { desc = "Insert <CR>" })
set("n", "<C-b>", "i<CR><Esc>k$a <Esc>", { desc = "Insert <CR>" })

set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- code actions on visual mode
set({ "v", "n" }, "<M-CR>", vim.lsp.buf.code_action)

-- obsidian.nvim
set("n", "<leader>on", ":ObsidianTemplate limbo-note<cr>", { desc = "Obsidian limbo note from template" })
set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>", { desc = "remove date from obsidian template" })

-- code actions
set("v", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", { desc = "Visual code action" })

-- refactor
set("x", "<leader>re", ":Refactor extract ")

-- formatting
set("v", "<leader>f", function()
	require("conform").format({ range = true })
end, { desc = "Format selected text with Conform" })

set("n", "<leader>cf", function()
	require("conform").format()
end, { desc = "Format current file" })

-- linting and diagnostics
set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "toggle diagnostics" })

set("n", "<leader>tl", function()
	if vim.opt.laststatus:get() == 0 then
		vim.opt.laststatus = 2 -- Show statusline
	else
		vim.opt.laststatus = 0 -- Hide statusline
	end
	-- local statusline = vim.o.statusline
	-- require("lualine").hide({
	-- 	place = { "statusline" },
	-- 	unhide = vim.o.statusline == "",
	-- })
	-- vim.opt.laststatus = 0
end, { desc = "toggle statusline" })

-- Yank all the function that has brackets
set("n", "YY", "va{Vy", { desc = "Yank function with {}" })

-- python dict
set("v", "<leader>pd", ":norm 1wyesiw'$pA,<CR>gv:norm 02f'a: <CR>$x", { silent = true, desc = "python dict" })

-- For simple template in obsidian
set("n", "<leader>ot", function()
	local date = os.date("%d-%m-%Y")
	local lines = {
		"---",
		"created: " .. date,
		"tags: []",
		"references: []",
		"---",
		"",
	}
	vim.api.nvim_put(lines, "l", false, true)
end, { buffer = true, desc = "Insert 'Nota Basica' Template" })

-- DEBUGGER
set("n", "<F5>", function()
	require("dap").continue()
end)
set("n", "<F10>", function()
	require("dap").step_over()
end)
set("n", "<F11>", function()
	require("dap").step_into()
end)
set("n", "<F12>", function()
	require("dap").step_out()
end)
set("n", "<Leader>b", function()
	require("dap").toggle_breakpoint()
end)
