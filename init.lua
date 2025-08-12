vim.g.mapleader = ' '
vim.opt.timeoutlen=1000

-- Basic
require("core.plugins")
require("core.configs")
require("core.commands")
require("core.mappings") 

-- Functions 
_G.dump = require("core.functions").dump
