return {
		{
				"mfussenegger/nvim-dap",
				dependencies = { "wojciech-kulik/xcodebuild.nvim" },
				config = function()
						local xcodebuild = require("xcodebuild.integrations.dap")
						 
						-- TODO: change it to your local codelldb path
						local codelldbPath = os.getenv("HOME") .. "/tools/codelldb-aarch64-darwin/extension/adapter/codelldb"
						 
						xcodebuild.setup(codelldbPath)
						 
						vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
						vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
						vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
						vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
						vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
						vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
						vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })

						local dap = require("dap")
						if not dap.adapters.lldb then
							local lldb_dap_path = vim.fn.trim(vim.fn.system("xcrun -f lldb-dap"))
							dap.adapters.lldb = {
								type = "executable",
								command = lldb_dap_path, -- adjust as needed, must be absolute path
								name = "lldb",
							}
						end

						dap.configurations.swift = {
							{
								name = "Launch file",
								type = "lldb",
								request = "launch",
								program = function()
									return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
								end,
								cwd = "${workspaceFolder}",
								stopOnEntry = false,
							},
						}
					end,
		},
		-- golang
		{ 
		    "leoluz/nvim-dap-go",
				ft = "go",
				dependencies = "mfussenegger/nvim-dap",
				config = function(_, opts)
						require("dap-go").setup(opts)
				end
		},
}
