function s:space()
	" spaces until next tab stop
	let l:tabstop = &l:softtabstop ? &l:softtabstop : &l:tabstop
	let l:spaces = &l:tabstop - virtcol([line('.'), col('.')-1, 0]) % l:tabstop
	return repeat(' ', l:spaces)
endfunction

function expandtab#expand()
	let l:auto_tab = "\<Tab>"
	let l:real_tab = "\<C-V>\<Tab>"

	" when 'expandtab' is off, vim mixes tabs and spaces in these cases:
	if !&l:expandtab
		let l:at_start = strpart(getline('.'), 0, col('.')-1) =~# '^\s\+$'
		if  l:at_start && &l:smarttab && &l:shiftwidth % &l:tabstop
			" at the start of a line, 'smarttab' is on, and 'shiftwidth' is not
			" a multiple of 'tabstop'
			return l:auto_tab
		elseif &l:softtabstop < 0 && &l:shiftwidth % &l:tabstop
			" 'softtabstop' is negative, and 'shiftwidth' is not a multiple of
			" 'tabstop'
			return l:auto_tab
		elseif &l:softtabstop && &l:softtabstop % &l:tabstop
			" 'softtabstop' is set, and not a multiple of 'tabstop'
			return l:auto_tab
		endif
	endif

	let l:col = col('.')

	if l:col > 1
		if getline('.')[l:col-2] == ' '
			" after space
			return !&l:expandtab ? s:space() : l:auto_tab
		elseif getline('.')[l:col-2] == "\t"
			" after tab
			return &l:expandtab ? l:real_tab : l:auto_tab
		endif
	endif

	if l:col < col('$')
		if getline('.')[l:col-1] == ' '
			" before space
			return !&l:expandtab ? s:space() : l:auto_tab
		elseif getline('.')[l:col-1] == "\t"
			" before tab
			return &l:expandtab ? l:real_tab : l:auto_tab
		endif
	endif

	" no spaces around cursor, respect 'expandtab'
	return l:auto_tab
endfunction

function s:mapset(map)
	if exists('*mapset')
		call mapset(a:map.mode, 0, a:map)
	else
		let l:map = a:map.noremap ? 'noremap' : 'map'
		let l:map = a:map.mode == '!' ? l:map.a:map.mode : a:map.mode.l:map

		let l:lhs = a:map.lhs
		let l:lhs = a:map.nowait ? '<nowait>'.l:lhs : l:lhs
		let l:lhs = a:map.buffer ? '<buffer>'.l:lhs : l:lhs
		let l:lhs = a:map.expr   ?   '<expr>'.l:lhs : l:lhs
		let l:lhs = a:map.silent ? '<silent>'.l:lhs : l:lhs

		execute l:map l:lhs a:map.rhs
	endif
endfunction

function expandtab#replace(map)
	if a:map.buffer
		let l:map = a:map
		iunmap <buffer><Tab>
		let a:map = maparg('<Tab>', 'i', 0, 1)
		call s:mapset(l:map)
	endif

	if a:map.rhs !~? '<Tab>'
		return
	endif

	let a:map.rhs = substitute(a:map.rhs, '\c<Tab>', '<Plug>ExpandTab', 'g')
	let a:map.noremap = 0
	call s:mapset(a:map)
endfunction
