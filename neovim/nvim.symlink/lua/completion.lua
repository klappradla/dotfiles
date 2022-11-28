local cmp = require("cmp")

local get_all_buffers = function()
  return vim.api.nvim_list_bufs()
end

-- simple snippet plugin implementation from
-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#no-snippet-plugin
local expand_snippet = function(args)
	local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
	local indent = string.match(line_text, "^%s*")
	local replace = vim.split(args.body, "\n", true)
	local surround = string.match(line_text, "%S.*") or ""
	local surround_end = surround:sub(col)

	replace[1] = surround:sub(0, col - 1) .. replace[1]
	replace[#replace] = replace[#replace] .. (#surround_end > 1 and " " or "") .. surround_end
	if indent ~= "" then
		for i, line in ipairs(replace) do
			replace[i] = indent .. line
		end
	end

	vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, replace)
end

cmp.setup({
	snippet = {
		expand = expand_snippet,
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
