if exists('g:loaded_expandtab')
	finish
endif
let g:loaded_expandtab = 1

let s:cpo = &cpoptions
set cpoptions-=<

inoremap <expr><Plug>ExpandTab expandtab#expand()

if !get(g:, 'expandtab_nomap', 0)
	call expandtab#map()
endif

let &cpoptions = s:cpo
unlet s:cpo
