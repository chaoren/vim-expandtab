if exists('g:loaded_expandtab')
	finish
endif
let g:loaded_expandtab = 1

inoremap <expr><Plug>ExpandTab expandtab#expand()

if !get(g:, 'expandtab_nomap', 0)
	call expandtab#map()
endif
