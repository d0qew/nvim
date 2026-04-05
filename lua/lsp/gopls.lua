---@type vim.lsp.Config
return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
	settings = {
		gopls = {
			analyses = {
    			unusedparams = true,
        		unreachable = true,
				shadow = true,
				nilness = true,
			},
    		staticcheck = true,
      		gofumpt = true,
      		completeUnimported = true,
      		usePlaceholders = true,
      		hints = {
        		parameterNames = true,
        		assignVariableTypes = true,
        		constantValues = true,
        		rangeVariableTypes = true,
        		compositeLiteralFields = true,
        		functionTypeParameters = true,
      		},
    	},
	},
}
