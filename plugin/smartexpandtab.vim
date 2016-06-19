if exists('g:loaded_smartexpandtab')
	finish
endif
let g:loaded_smartexpandtab = 1

inoremap <silent><expr><Plug>SmartExpandTab smartexpandtab#tab()

let s:map = get(g:, 'smartexpandtab_map', 1)

if s:map
	imap <Tab> <Plug>SmartExpandTab
endif
