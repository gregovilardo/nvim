return {
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_markers = { "build.zig", "zls.json", ".git" },
	settings = {
		zls = {
			enable_autofix = true,
			warn_style = true,
			highlight_global_var_declarations = true,
		},
	},
}
