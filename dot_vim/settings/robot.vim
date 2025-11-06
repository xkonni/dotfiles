autocmd Filetype robot call SetRobot()

function! SetRobot()
  " set nosmarttab
  " set noexpandtab
  set shiftwidth=4
  set tabstop=4
  set softtabstop=4
endfunction
