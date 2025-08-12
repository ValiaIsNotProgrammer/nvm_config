return {
    "LunarVim/bigfile.nvim",
    event = "BufReadPre",
    config = function()
        require("bigfile").setup({
            filesize = 10, -- MB
            pattern = { "*" },
            features = {
                "indent_blankline",
                "lsp",
                "treesitter",
                "syntax",
                "matchparen",
                "vimopts",
                "filetype",
            },
        })
    end,
}

