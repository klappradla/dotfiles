local null_ls = require("null-ls")
local lsp = require("lsp")

local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting

null_ls.setup({
	sources = {
    diagnostics.ansiblelint,
    diagnostics.eslint,
    diagnostics.haml_lint,
    diagnostics.rubocop,
    diagnostics.yamllint,
		--
		code_actions.eslint,
		--
		formatting.eslint,
		formatting.prettier,
		formatting.stylua,
    formatting.jq,
    formatting.mix,
	},
	on_attach = lsp.on_attach,
})
