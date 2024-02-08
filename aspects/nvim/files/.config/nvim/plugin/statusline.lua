local augroup = ape.vim.augroup
local autocmd = ape.vim.autocmd

ape.statusline.set()

augroup('ApeStatusline', function()
  autocmd(
    'BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter',
    '*',
    ape.statusline.check_modified
  )
  autocmd('ColorScheme', '*', ape.statusline.update_highlight)
end)
