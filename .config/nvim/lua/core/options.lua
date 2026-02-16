if vim.g.neovide then
   vim.g.neovide_cursor_animation_length = 0
   vim.g.neovide_scroll_animation_length = 0
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.cmd([[set path+=**]])

vim.o.relativenumber = true
vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.cmd([[set noshowmode]])

-- Minimum # of lines to keep above/below the cursor
vim.opt.scrolloff = 4

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight the line the cursor is on
vim.opt.cursorline = true

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "list:full,full"

-- LSP --
vim.lsp.config['clangd'] = {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    single_file_support = true,
    capabilities = {
	textDocument = {
	    completion = {
		editsNearCursor = true,
	    },
	},
	offsetEncoding = { 'utf-8', 'utf-16' },
    },
}
vim.lsp.enable('clangd')

vim.lsp.config['lua_ls'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { 'init.lua' },
}
vim.lsp.enable('lua_ls')

vim.lsp.config['tinymist'] = {
    cmd = { 'tinymist' },
    filetypes = { 'typ' }
}
vim.lsp.enable('tinymist')