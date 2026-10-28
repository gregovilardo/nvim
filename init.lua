-- Kotlin server shared by droid.nvim.
vim.env.KOTLIN_LSP_DIR = vim.fn.expand("~/.local/share/kotlin-lsp/kotlin-server-263.6379.0")

vim.loader.enable()
-- Hook para actualizar parsers automáticamente al instalar/actualizar nvim-treesitter
vim.api.nvim_create_autocmd("User", {
	pattern = "PackChanged",
	callback = function(ev)
		if ev.data.kind ~= "delete" and ev.data.spec.name == "nvim-treesitter" then
			vim.cmd("TSUpdate")
		end
	end,
})

local function add_github_plugins(list)
	local prefix = "https://github.com/"
	for _, repo in ipairs(list) do
		vim.pack.add({ prefix .. repo })
	end
end

add_github_plugins({
	"mason-org/mason.nvim",
	"catppuccin/nvim",

	"nvim-treesitter/nvim-treesitter",
	"nvim-flutter/flutter-tools.nvim",

	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",

	"nvim-telescope/telescope-fzf-native.nvim",
	"nvim-telescope/telescope-smart-history.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	"isak102/telescope-git-file-history.nvim",

	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",

	"stevearc/oil.nvim",
	"nvim-mini/mini.nvim",

	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"nvim-neotest/nvim-nio",

	"stevearc/conform.nvim",

	"mfussenegger/nvim-lint",

	"folke/which-key.nvim",

	"saghen/blink.cmp",
	"rafamadriz/friendly-snippets",

	"MeanderingProgrammer/render-markdown.nvim",

	"lervag/vimtex",

	"akinsho/git-conflict.nvim",

	"tpope/vim-surround",

	"lewis6991/async.nvim",
	"theprimeagen/refactoring.nvim",

	"rizukirr/droid-nvim",
})

vim.pack.add({
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2", build = "cargo build --release" },
})

-- !TODO: Averiguar que esto ande bien
-- vim.filetype.add({
-- 	extension = {
-- 		html = "htmldjango",
-- 	},
-- })

-- this add the path of meson to current instance of neovim
require("mason").setup()

-- this enable the server that we define in lsp/
local servers = {
	"clangd",
	"lua_ls",
	"marksman",
	"pyright",
	"rust_analyzer",
	"zls",
	"htmx",
	"html",
	"typescript_language_server",
	"ols",
	"glsl_analyzer",
}
vim.lsp.enable(servers)

-- stand alone plugins without config or with priority
require("oil").setup()
-- require("mini.files").setup()
