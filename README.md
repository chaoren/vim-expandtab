# Context sensitive tab expansion for Vim [![Build Status][1]][2]

With this plugin, hitting `<Tab>` in insert mode will insert a tab or spaces
depending on the characters around the cursor:

1.  If the character before the cursor is a space, then spaces will be inserted
    up to the next `'tabstop'`.
2.  If the character before the cursor is a tab, then a literal `<Tab>` will be
    inserted.
3.  If the character before the cursor is neither a tab nor a space, and the
    character after the cursor is a space, then spaces will be inserted
    up to the next `'tabstop'`.
4.  If the character before the cursor is neither a tab nor a space, and the
    character after the cursor is a tab, then a literal `<Tab>` will be
    inserted.
5.  If none of these cases apply, then this behaves like a regular `i_<Tab>`
    that respects `'expandtab'`.

Let `_` be a space and `--->` be a tab.

Suppose you hit `<Tab>` here:

```
--->
    ^<Tab>
```

It doesn't make sense to insert spaces here, but if `'expandtab'` is on, then
spaces would get inserted anyway.

Suppose you hit `<Tab>` here:

```
____
    ^<Tab>
```

It doesn't make sense to insert a tab here, but if `'expandtab'` is off, then a
tab would get inserted anyway.

Using `'smarttab'` or `'softtabstop'` forces your `'expandtab'` behavior onto
the file, while using this plugin will respect whatever choice of indentation or
alignment that was already there.

## Customization

Use `g:expandtab_nomap` to disable the default `<Tab>` mapping. \
E.g.,

```vim
let g:expandtab_nomap = 1
```

Use `<Plug>ExpandTab` to define your own mapping. \
E.g.,

```vim
imap <Leader><Tab> <Plug>ExpandTab
```

## Caveats

Vim mixes tabs and spaces in these cases when `'expandtab'` is off:

1.  at the start of a line, `'smarttab'` is on, and `'shiftwidth'` is not a
    multiple of `'tabstop'`.
2.  `'softtabstop'` is negative, and `'shiftwidth'` is not a multiple of
    `'tabstop'`.
3.  `'softtabstop'` is set, and not a multiple of `'tabstop'`.

It doesn't make sense for the plugin to function in these cases, so it will just
behave like a regular `i_<Tab>`.

[1]: https://travis-ci.com/chaoren/vim-expandtab.svg?branch=master
[2]: https://travis-ci.com/chaoren/vim-expandtab
