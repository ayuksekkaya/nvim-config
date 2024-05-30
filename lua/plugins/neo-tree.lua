return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},

	config = function()
		require("neo-tree").setup({
			opts = {
			sources = { 'filesystem' },
			sort_case_insensitive = true,
			enable_cursor_hijack = true,
			auto_clean_after_session_restore = true,
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_by_name = {
						'.git',
						'.DS_Store',
						'thumbs.db',
						'node_modules',
					},
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
			}},
			event_handlers = {

				{
					event = "file_opened",
					handler = function(file_path)
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		})
		vim.keymap.set("n", "<leader>	", ":Neotree<CR>", {})
	end,
}
