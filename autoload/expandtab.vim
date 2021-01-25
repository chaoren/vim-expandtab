function expandtab#expand()
	let l:tab = "\<Tab>"

	" When 'expandtab' is off, Vim does its own automatic thing with tabs and
	" spaces in these cases:
	" 1. at the start of a string, 'smarttab' is on, and 'shiftwidth' is not
	"    a multiple of 'tabstop'
	" 2. 'softtabstop' is negative, and 'shiftwidth' is not a multiple of
	"    'tabstop'
	" 3. 'softtabstop' is set, and not a multiple of 'tabstop'
	" don't mess with these
	if !&l:expandtab
		if strpart(getline('.'), 0, col('.') - 1) =~ '^\s\+$' &&
					\ &l:smarttab && &l:shiftwidth % &l:tabstop
			return l:tab
		elseif &l:softtabstop < 0 && &l:shiftwidth % &l:tabstop
			return l:tab
		elseif &l:softtabstop && &l:softtabstop % &l:tabstop
			return l:tab
		endif
	endif

	let l:col = col('.')
	if l:col == 1
		" no previous character, change nothing
		return l:tab
	elseif !&l:expandtab && getline('.')[l:col - 2] == ' '
		" previous character was a space, so we're going to follow with
		" enough spaces to get to the next tab stop
		let l:tabstop = &l:softtabstop ? &l:softtabstop : &l:tabstop
		let l:spaces = &l:tabstop - (virtcol('.') - 1) % l:tabstop
		return repeat(' ', l:spaces)
	elseif &l:expandtab && getline('.')[l:col - 2] == "\t"
		" previous character was a real tab, so we're going to follow with
		" a real tab
		return "\<C-V>".l:tab
	endif

	" previous character was neither a tab nor a space, change nothing
	return l:tab
endfunction
