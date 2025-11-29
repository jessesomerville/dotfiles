local opt = vim.opt
local o = vim.o
local g = vim.g


o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.relativenumber = true
o.splitbelow = true
o.splitright = true
o.mouse = "a"
o.timeoutlen = 200
o.termguicolors = true
o.signcolumn = "yes"

opt.fillchars:append({ eob = ' ' })

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- disable netrw for nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
