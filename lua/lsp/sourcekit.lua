---@type vim.lsp.Config
return {
	cmd = { "sourcekit-lsp" },
	filetypes = { "swift", "objective-c", "objective-cpp" },
	root_markers = {
		"Package.swift",
		".git",
		"*.xcodeproj",
		"*.xcworkspace",
	},
	settings = {
		sourcekit = {
			index = {
				enable = true,
			},
			inlayHints = {
				enabled = false,
			},
		},
	},
}
