" Strip trailing whitespace
" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap ,w :StripTrailingWhitespaces<CR>

" Merge a tab into a split in the previous window
function! MergeTabs()
  if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif
  split
  execute "buffer " . bufferName
endfunction
nmap <C-W>u :call MergeTabs()<CR>

" replace umlaute
function! ReplaceUmlaute()
  %s/Ä/\\"A/g
  %s/Ö/\\"O/g
  %s/Ü/\\"U/g
  %s/ä/\\"a/g
  %s/ö/\\"o/g
  %s/ü/\\"u/g
  %s/ß/\{\\ss}/g
endfunction

" convert to json
function! ConvertJson()
    %s/\'/\"/g
    %s/None/\"None\"/g
    %s/True/true/g
    %s/False/false/g
    % ! python3 -m json.tool
endfunction
command! ConvertJson call ConvertJson()
nmap ,j :ConvertJson<CR>
