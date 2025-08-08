return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local function find_local_pylsp()
      local root = util.root_pattern(".venv", "pyproject.toml", "setup.py", ".git")(vim.fn.getcwd())
      if not root then return nil end

      local pylsp_path = root .. "/.venv/bin/python_lsp_server"
      if vim.fn.executable(pylsp_path) == 1 then
        return pylsp_path
      end

      return nil
    end
   

    local local_pylsp = find_local_pylsp()
    -- if not local_pylsp then
    --   vim.notify("pylsp not found in local .venv. Falling back to global pylsp (if any)", vim.log.levels.WARN)
    -- end

    lspconfig.pylsp.setup {
      cmd = local_pylsp and { local_pylsp } or { "pylsp" },
      root_dir = util.root_pattern("pyproject.toml", "setup.cfg", "setup.py", "requirements.txt", ".git"),
      settings = {
        pylsp = {
          plugins = {
          mypy = {
              enabled = true,
              strict = true
            },
           pycodestyle = {
              enabled = true,
              maxLineLength = 120,
            },
            ruff = { enabled = true },
            black = { enabled = true },
          },
        },
      },
    }
    lspconfig.clangd.setup {}
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

