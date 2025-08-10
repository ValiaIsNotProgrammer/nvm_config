return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "s1n7ax/nvim-window-picker"
  },
  lazy = false,
  cmd = "Neotree",
  config = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])


    require("neo-tree").setup {
      window = {
        mappings = {
          ["l"] = "open",
          ["<CR>"] = "open",
          ["h"] = "close_node",
          ["H"] = "",
          ["<leader>h"] = "toggle_hidden"
        },
      },
    }
  end,
}

