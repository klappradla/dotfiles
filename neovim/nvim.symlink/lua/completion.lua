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
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        end
        cmp.confirm()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "supermaven" },
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "snippy" },
  }, {
    { name = "path" },
    { name = "buffer", keyword_length = 3, option = { get_bufnrs = get_all_buffers } },
  }),
})

supermaven.setup({
  disable_keymaps = true,
  disable_inline_completion = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

require("cmp_nvim_lsp").default_capabilities(capabilities)
