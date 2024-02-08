local augroup = ape.vim.augroup
local autocmd = ape.vim.autocmd

augroup('WincentAutocmds', function()
  autocmd('BufWritePost', '*/spell/*.add', 'silent! :mkspell! %')
  autocmd('InsertLeave', '*', 'set nopaste')
  autocmd('TextYankPost', '*', "silent! lua vim.highlight.on_yank {higroup='Substitute', timeout=200}")
  autocmd('VimResized', '*', 'execute "normal! \\<c-w>="')
end)
