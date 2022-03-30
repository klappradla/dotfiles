local null_ls = require 'null-ls'
local timeout_ms = 30000

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.styllua,
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, timeout_ms)
      augroup END
      ]])
    end
  end,
})
