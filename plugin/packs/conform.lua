require("conform").setup({
	log_level = vim.log.levels.DEBUG,
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_format" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		-- html = { "prettierd", "prettier", stop_after_first = true },
		htmldjango = { "djlint" },
		dart = { "dart_format" },
	},
	formatters = {
		ruff_format = {

			args = { "format", "--config", "line-length=100", "--stdin-filename", "$FILENAME", "-" },
		},
	},
})
