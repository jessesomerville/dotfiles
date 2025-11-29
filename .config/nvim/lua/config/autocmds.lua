vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = false
    vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>ko", { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = filegroup,
  pattern = "json",
  command = [[syntax match Comment +\/\/.\+$+]],
})

vim.api.nvim_create_autocmd("FileType", {
  group = filegroup,
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})
