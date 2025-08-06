return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
  },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup {
      defaults = {
        vimgrep_arguments = {
          'rg', '--hidden', '--max-columns=200',
          '--no-heading', '--with-filename', '--line-number',
          '--column', '--smart-case',
          '--glob', '!.git/*',
          '--glob', '!.venv/*',
          '--glob', '!node_modules/*',
          '--glob', '!dist/*',
          '--glob', '!build/*',
          '--glob', '!.idea/*',
          '--glob', '!.vscode/*',
          '--glob', '!__pycache__/*',
        },
        mappings = {
          i = {
            ["<C-c>"] = actions.close,
            ["<C-s>"] = actions.select_vertical,
          },
        },
      },
    }
  end,
}

