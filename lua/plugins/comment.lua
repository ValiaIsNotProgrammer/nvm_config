return {
  "terrortylor/nvim-comment",
  keys = { { "<leader>/", mode = { "n", "v" } } },
  config = function()
    require("nvim_comment").setup({
      line_mapping = "<leader>/"
    })
  end,
}

