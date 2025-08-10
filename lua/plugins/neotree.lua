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
    require("window-picker").setup {
      autoselect_one = false,
      include_current = false,
      filter_rules = {
        bo = {
          filetype = { "neo-tree", "neo-tree-popup", "notify" },
          buftype = { "terminal", "quickfix" },
        },
      },
      other_win_hl_color = "#e35e4f",
    }

    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    for type, icon in pairs({
      Error = " ",
      Warn = " ",
      Info = " ",
      Hint = ""
    }) do
      vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type })
    end

    require("neo-tree").setup {
      window = {
        mappings = {
          ["l"] = "open",
          ["<CR>"] = "open",
          ["h"] = "close_node",
          ["<leader>l"] = "focus_preview",
        },
      },
    }
  end,
}

