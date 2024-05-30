local ms = require("vim.lsp.protocol").Methods
return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({ PATH = "prepend" })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "tsserver", "omnisharp" } })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.tsserver.setup({ capabilities = capabilities })
			lspconfig.omnisharp.setup({
				capabilities = capabilities,
				enable_roslyn_analysers = true,
				enable_import_completion = true,
				organize_imports_on_format = true,
				enable_decompilation_support = true,
				filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
			})

			vim.diagnostic.config({ virtual_text = false })
			vim.api.nvim_create_autocmd({ "CursorHold" }, {
				callback = function()
					vim.diagnostic.open_float()
				end,
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
	---	{
	---		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	---		event = "VeryLazy",
	---		config = function()
	------			require("lsp_lines").setup()
	---
	---			vim.diagnostic.config({
	---				virtual_lines = false,
	---				virtual_text = true,
	---			})
	---
	---			local function toggleLines()
	---				local new_value = not vim.diagnostic.config().virtual_lines
	---				vim.diagnostic.config({ virtual_lines = new_value, virtual_text = not new_value })
	---				return new_value
	---			end
	---
	---			vim.keymap.set("n", "<leader>lu", toggleLines, { desc = "Toggle Underline Diagnostics", silent = true })
	---		end,
	---	},
}
