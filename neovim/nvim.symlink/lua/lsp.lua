local lspconfig = require("lspconfig")

-- Mappings
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>D", vim.diagnostic.setloclist, opts)

local on_attach = function(_client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- Mappings
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Language servers
lspconfig.tsserver.setup({
  on_attach = on_attach,
})
lspconfig.elixirls.setup({
  cmd = { "elixir-ls" },
  on_attach = on_attach
})

return { on_attach = on_attach }
