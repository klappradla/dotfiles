local cmp = require("cmp")

local get_all_buffers = function()
  return vim.api.nvim_list_bufs()
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "ultisnips" },
	}, {
		{ name = "path" },
		{ name = "buffer", keyword_length = 3, option = { get_bufnrs = get_all_buffers } },
	}),
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

require("cmp_nvim_lsp").default_capabilities(capabilities)
