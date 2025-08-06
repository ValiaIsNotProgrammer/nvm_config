return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground",
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-context"
  },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "lua", "go", "python", "rust", "json", "yaml", "bash", "markdown", "html", "css", "javascript", "typescript", "php"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      fold = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      auto_install = true,
      context_commentstring = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
        },
      },
      playground = {
        enable = true,
        updatetime = 25,
        persist_queries = false,
      },
    }
  end,
}

