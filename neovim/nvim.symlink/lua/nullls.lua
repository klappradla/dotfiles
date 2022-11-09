local null_ls = require("null-ls")
local lsp = require("lsp")

local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting

null_ls.setup({
	sources = {
		diagnostics.ansiblelint,
		diagnostics.eslint,
		diagnostics.luacheck,
		diagnostics.rubocop.with({
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE
    }),
		diagnostics.yamllint,
		--
		code_actions.eslint,
		--
		formatting.eslint,
		formatting.jq,
		formatting.mix,
		formatting.prettier,
		formatting.rubocop,
		formatting.stylua,
	},
	on_attach = lsp.on_attach,
})
