local null_ls = require("null-ls")
local lsp = require("lsp")

local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    diagnostics.ansiblelint,
    diagnostics.rubocop.with({
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
    diagnostics.selene,
    diagnostics.stylelint,
    diagnostics.yamllint,
    formatting.prettier,
    formatting.rubocop,
    formatting.stylua,
    formatting.stylelint,
  },
  on_attach = lsp.on_attach,
})
