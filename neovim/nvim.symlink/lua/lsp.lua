local lspconfig = require("lspconfig")
local util = require 'lspconfig.util'
local cmp_lsp = require("cmp_nvim_lsp")

local capabilities = cmp_lsp.default_capabilities()

local format_buffer = function()
  vim.lsp.buf.format({ async = true })
end

-- Mappings
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>D", vim.diagnostic.setloclist, opts)

local on_attach = function(_client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- Mappings
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>fm", format_buffer, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
end

-- Language servers
lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.elixirls.setup({
  cmd = { "/Users/max/dotfiles/lsp/elixir-ls/language_server.sh" },
  root_dir = function(fname)
    -- For better usage with monorepos: search fro a mix.exs file first
    return util.root_pattern 'mix.exs'(fname) or util.find_git_ancestor(fname) or vim.loop.os_homedir()
  end,
  on_attach = on_attach,
  capabilities = capabilities,
})

return { on_attach = on_attach }
