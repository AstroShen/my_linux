" setlocal makeprg=shellcheck\ -f\ gcc\ %:p
" setlocal errorformat=%f:%l:%c:\ %trror:\ %m\ [SC%n],
" 		       \%f:%l:%c:\ %tarning:\ %m\ [SC%n],
" 		       \%f:%l:%c:\ %tote:\ %m\ [SC%n],
" 		       \%-G%.%#
setlocal makeprg=%:p
setlocal errorformat=%f:\ line\ %l:\ %m
