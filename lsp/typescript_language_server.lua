return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact" },
	-- Cambiamos los marcadores de raíz para que se adapten a un proyecto Django/JS tradicional
	root_markers = { "package.json", "jsconfig.json", ".git" },
	settings = {
		javascript = {
			implicitProjectConfig = {
				checkJs = true, -- Cambia a false si no quieres que te marque errores de tipo en JS
				target = "ES2022",
			},
			suggest = {
				completeFunctionCalls = true,
			},
			inlayHints = {
				parameterNames = { enabled = "all" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
			},
		},
	},
	on_attach = function(client, bufnr)
		-- Mantenemos tu misma lógica de auto-completado e inlay hints
		if vim.lsp.completion then
			vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
		end

		if client.supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end
	end,
}
