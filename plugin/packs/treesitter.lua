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
	"zig",
	-- "alloy6",
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

-- Register language and filetype
vim.treesitter.language.register("ltsa", "lts")
vim.filetype.add({ extension = { lts = "ltsa" } })

-- vim.treesitter.language.register("alloy6", "alloy6")
-- vim.filetype.add({ extension = { als = "alloy6" } })

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").alloy6 = {
			install_info = {
				path = vim.fn.expand("~/Programming/tree-sitter-alloy6"),
				files = { "src/parser.c" },
				queries = "queries/alloy6",
			},
			filetype = "als",
		}
	end,
})

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
