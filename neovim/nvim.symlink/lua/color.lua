vim.o.background = "dark"

require("solarized").setup({
  transparent = { enabled = false },
  palette = "solarized",
})

vim.cmd.colorscheme("solarized")
