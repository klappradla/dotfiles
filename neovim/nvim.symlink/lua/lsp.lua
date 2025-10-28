local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")

mason.setup()
mason_lspconfig.setup({ ensure_installed = { "elixirls", "ts_ls", "ruby_lsp" } })

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
vim.lsp.config("ts_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config("elixirls", {
  cmd = { vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh" },
  -- For better usage with monorepos: search for a mix.exs file first
  root_dir = vim.fs.root(0, { "mix.exs", ".git" }) or vim.loop.os_homedir(),
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config("ruby_lsp", {
  on_attach = on_attach,
  capabilities = capabilities,
})

return { on_attach = on_attach }
