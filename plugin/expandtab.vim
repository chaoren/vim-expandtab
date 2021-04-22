if exists('g:loaded_expandtab')
	finish
endif
let g:loaded_expandtab = 1

inoremap <expr><Plug>ExpandTab expandtab#expand()

if !get(g:, 'expandtab_nomap', 0)
	let s:map = maparg('<Tab>', 'i', 0, 1)
	if empty(s:map)
		imap <Tab> <Plug>ExpandTab
	else
		call expandtab#replace(s:map)
	endif
	unlet s:map
endif
