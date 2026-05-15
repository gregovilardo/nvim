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
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",

	"nvim-telescope/telescope-fzf-native.nvim",
	"nvim-telescope/telescope-smart-history.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	"isak102/telescope-git-file-history.nvim",
	"tpope/vim-fugitive",

	"stevearc/oil.nvim",
	"nvim-mini/mini.nvim",

	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"nvim-neotest/nvim-nio",

	"stevearc/conform.nvim",

	"folke/which-key.nvim",

	"saghen/blink.cmp",
	"rafamadriz/friendly-snippets",

	"MeanderingProgrammer/render-markdown.nvim",

	-- "Thiago4532/mdmath.nvim",
})

vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2", build = "cargo build --release" },
})

-- this add the path of meson to current instance of neovim
require("mason").setup()

-- this enable the server that we define in lsp/
local servers = { "clangd", "lua_ls", "pyright", "rust_analyzer" }
vim.lsp.enable(servers)

-- stand alone plugins without config or with priority
require("oil").setup()
