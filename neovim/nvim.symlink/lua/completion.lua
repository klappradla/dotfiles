local cmp = require("cmp")
local snippy = require("snippy")
local supermaven = require("supermaven-nvim")

local get_all_buffers = function()
  return vim.api.nvim_list_bufs()
end

cmp.setup({
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "snippy" },
  }, {
    { name = "path" },
    { name = "buffer", keyword_length = 3, option = { get_bufnrs = get_all_buffers } },
  }),
})

supermaven.setup({
   keymaps = {
    accept_suggestion = "<tab>",
  }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

require("cmp_nvim_lsp").default_capabilities(capabilities)
