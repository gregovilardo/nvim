local kotlin = require("droid.lsp.kotlin")
local default_init_options = kotlin._init_options

-- shortcut: private Droid hook; remove when Droid forwards configured projects.
kotlin._init_options = function(opts)
	local init_options = default_init_options(opts)
	init_options.projects = opts.projects
	return init_options
end

require("droid").setup({})
