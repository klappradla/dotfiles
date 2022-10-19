local lspconfig = require("lspconfig")

-- Mappings
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>D", vim.diagnostic.setloclist, opts)

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls" -- use only null-ls for formatting
		end,
		bufnr = bufnr,
		async = true,
	})
end

local on_attach = function(_client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- Mappings
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>fm", function()
		lsp_formatting(bufnr)
	end, bufopts)
end

-- Language servers
lspconfig.tsserver.setup({
	on_attach = on_attach,
})

return { on_attach = on_attach }
