return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    lspconfig.clangd.setup {}
    lspconfig.pylsp.setup {
      settings = {
        plugins = {
          ruff = { enabled = true },
          black = { enabled = true },
          jedi_completion = { enabled = true },
          jedi_definition = { enabled = true },
          jedi_hover = { enabled = true },
          jedi_references = { enabled = true },
          jedi_signature_help = { enabled = true },
          jedi_symbols = { enabled = true },
          rope_autoimport = { enabled = true },
          rope_completion = { enabled = true },
        },
      },
    }
    lspconfig.ts_ls.setup {}
    lspconfig.prismals.setup {}
    lspconfig.cssls.setup { capabilities = capabilities }
    lspconfig.gopls.setup {
      settings = {
        gopls = {
          analyses = { unusedparams = true },
          staticcheck = true,
          gofumpt = true,
        },
      },
    }
    lspconfig.rust_analyzer.setup {
      settings = {
        ["rust-analyzer"] = {
          diagnostics = { enable = true, experimental = { enable = true } },
        },
      },
    }

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local opts = { buffer = ev.buf }

        local map = vim.keymap.set
        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)
        map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        map("n", "<Leader>lr", vim.lsp.buf.rename, opts)
        map({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, opts)
        map("n", "<Leader>lf", function() vim.lsp.buf.format { async = true } end, opts)
      end,
    })

    vim.keymap.set("n", "<leader>lD", vim.diagnostic.open_float)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist)
  end,
}

