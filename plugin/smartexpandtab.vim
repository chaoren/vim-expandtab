if exists('g:loaded_smartexpandtab')
	finish
endif
let g:loaded_smartexpandtab = v:true

inoremap <silent><expr><Plug>SmartExpandTab smartexpandtab#expand()

if !get(g:, 'smartexpandtab_nomap', v:false)
	imap <Tab> <Plug>SmartExpandTab
endif
