vim.opt.spellfile= {
  "$HOME/.config/nvim/spell/es.utf-8.add",
  "$HOME/.config/nvim/spell/en.utf-8.add",
}
vim.opt.spelllang = {"en","es"}
vim.opt.spell = true


vim.g.mapleader = " "

vim.opt.filetype = "on"
vim.opt.filetype = "plugin"
vim.opt.filetype = "indent"
vim.opt.filetype = "detect"

vim.opt.foldmethod = "indent"

--vim.opt.guicursor = ""

vim.opt.number = true -- Display line number
vim.opt.relativenumber = true
vim.opt.syntax = "on"

vim.opt.tabstop = 4     -- The width of a TAB is set to 4.
                   	    -- Still it is a \t. It is just that
                        -- Vim will interpret it to be having
                   	    -- a width of 4.
vim.opt.shiftwidth = 4  -- Indents will have a width of 4
vim.opt.softtabstop = 4 -- Sets the number of columns for a TAB
vim.opt.expandtab = true-- Expand TABs to spaces
vim.opt.smarttab = true -- insert spaces or tabs to go to the next 
                   	    -- indent of the next tabstop when the 
		                -- cursor is at the beginning of a line


vim.api.nvim_command("autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab")
vim.api.nvim_command("autocmd FileType tex setlocal ts=2 sts=2 sw=2 expandtab")
vim.api.nvim_command("autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab")

vim.opt.wrap = true

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"

vim.g.netrw_altv = true

--"#Turn off the banner at the top of the sreen on startup
vim.g.netrw_banner=0

--# to change the way netrw shows the files and directories
--vim.g.netrw_liststyle= 0    -- Default view (directory name/file name)
--vim.g.netrw_liststyle= 1    -- Show time and size
--vim.g.netrw_liststyle= 2    -- Shows listing in 2 columns

vim.g.netrw_liststyle= 3    -- show the tree listing


-- Set the split windows to always be equal and open splits to the right
--vim.g.netrw_winsize = 0         --   set default window size to be always equal
vim.g.netrw_preview = 1		    --	open splits to the right

