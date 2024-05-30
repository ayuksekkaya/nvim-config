vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undofile = true
vim.opt.undolevels = 30000
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8


--- This allows me to use the same registers for copy and paste between WSL, Tmux, and Vim.
--- It needs wl-clipboard installed in WSL in order for it to work.
vim.opt.clipboard = "unnamedplus"
if vim.fn.has("wsl") == 1 then
    if vim.fn.executable("wl-copy") == 0 then
        print("wl-clipboard not found, clipboard integration won't work")
    else
        vim.g.clipboard = {
            name = "wl-clipboard (wsl)",
            copy = {
                ["+"] = 'wl-copy --foreground --type text/plain',
                ["*"] = 'wl-copy --foreground --primary --type text/plain',
            },
            paste = {
                ["+"] = (function()
                    return vim.fn.systemlist('wl-paste --no-newline|sed -e "s/\r$//"', {''}, 1) -- '1' keeps empty lines
                end),
                ["*"] = (function() 
                    return vim.fn.systemlist('wl-paste --primary --no-newline|sed -e "s/\r$//"', {''}, 1)
                end),
            },
            cache_enabled = true
        }
    end
end
