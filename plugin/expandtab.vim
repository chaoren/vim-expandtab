if exists('g:loaded_expandtab')
	finish
endif
let g:loaded_expandtab = 1

inoremap <silent><expr><Plug>ExpandTab expandtab#expand()

if !get(g:, 'expandtab_nomap', 0)
	let s:map = maparg('<Tab>', 'i', 0, 1)
	if empty(s:map)
		imap <Tab> <Plug>ExpandTab
	elseif s:map.rhs =~? '<Tab>'
		let s:map.rhs = substitute(s:map.rhs, '\c<Tab>', '<Plug>ExpandTab', 'g')
		let s:map.noremap = 0
		call mapset(s:map.mode, 0, s:map)
	endif
	unlet s:map
endif
