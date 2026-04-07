local wk = require("which-key")
wk.add({
	{ "<leader>c", group = "lsp (rename, code action)" },
	{ "<leader>f", group = "fzf" },
	{ "<leader>g", group = "git & fzf" },
	{ "<leader>s", group = "splits and terminal" },
	{ "<leader>h", group = "gitsigns hunks" },
	{ "<leader>t", group = "toggle (gitsigns)" },
})
