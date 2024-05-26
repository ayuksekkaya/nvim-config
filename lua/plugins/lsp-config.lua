return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "tsserver" } })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			--- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.tsserver.setup({})

		---	lspconfig.omnisharp.setup({
	---			capabilities = capabilities,
------				enable_roslyn_analysers = true,
---				enable_import_completion = true,
---				organize_imports_on_format = true,
---				enable_decompilation_support = true,
---				filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
---			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
