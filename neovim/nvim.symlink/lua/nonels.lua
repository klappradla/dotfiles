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
    diagnostics.yamllint,
    --
    -- TODO: use jsonls instead of jq
    formatting.jq,
    formatting.prettier,
    formatting.rubocop,
    formatting.stylua,
  },
  on_attach = lsp.on_attach,
})
