vim.g.mapleader = ' '
vim.opt.timeoutlen=1000

-- Basic
require("core.plugins")
require("core.configs")
require("core.commands")
require("core.mappings") 


-- Plugins
require("plugins.neotree")
require("plugins.lsp")
require("plugins.cmp")
require("plugins.comment")
require("plugins.telescope")

-- Functions 
_G.dump = require("core.functions").dump
