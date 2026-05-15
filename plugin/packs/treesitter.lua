local langs = {
	"python",
	"javascript",
	"rust",
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",
	"html",
	"latex",
	"yaml",
}
require("nvim-treesitter").install(langs)

-- Register LTSA parser (custom parser not in nvim-treesitter registry)
require("nvim-treesitter.parsers").ltsa = {
	install_info = {
		url = "https://github.com/gregovilardo/tree-sitter-ltsa",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "ltsa",
}

require("nvim-treesitter.parsers").alloy = {
	install_info = {
		url = "https://github.com/fore-stun/tree-sitter-alloy",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "alloy",
}

-- Register language and filetype
vim.treesitter.language.register("ltsa", "lts")
vim.filetype.add({ extension = { lts = "ltsa" } })
vim.treesitter.language.register("als", "alloy")
vim.filetype.add({ extension = { als = "alloy" } })

-- Add ltsa to the autocmd patterns for treesitter activation
local all_langs = vim.list_extend(vim.list_slice(langs), { "ltsa" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = all_langs,
	callback = function()
		vim.treesitter.start() -- highlighting
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- folds
		vim.wo.foldmethod = "expr"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
	end,
})
