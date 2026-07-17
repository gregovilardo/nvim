require("flutter-tools").setup({
	ui = {
		border = "rounded",
	},
	lsp = {
		settings = {
			showTodos = true,
			completeFunctionCalls = true,
			updateImportsOnRename = true,
			enableSnippets = true,
		},
	},
	debugger = {
		enabled = true,
	},
})
