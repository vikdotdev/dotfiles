## Bootstrapping

Run the following script to bootstrap a fresh Fedora GNOME install:
```shell
wget https://raw.githubusercontent.com/vikdotdev/dotfiles/master/bin/bin/s-fedora-bootstrap
chmod +x s-fedora-bootstrap
./s-fedora-bootstrap
rm s-fedora-bootstrap
```
# commands to incorporate into my setup
screenkey -p fixed -g $(slop -n -f '%g')
find . -xtype l -delete
git diff --color-words='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+'
sudo dnf install git-delta
dnf install fira-code-fonts

## cool cli stuff
read about nvim -es ? or neovim remote?

echo -n test:password | base64 | awk '{print "Basic " $0}'

## Neovim
### Thing to do
- add more autopairs
- fix issues with autochdir or whatever with telescope search
- think about blackhole register yanking a pasting (gy and gp shortcuts?)
  <!-- vnoremap gp "_c<C-r><C-o>+<Esc> -->
- improve ripgrep matching to be similar to DOOM * (with spaces)
- custom buffer manager like bufkill in lua
- when killing a buffer go to last visited buffer instead of the one higher on stack?
- set alternate buffer alter killing a buffer
- light theme switcher for term and vim
- fix blaming toggle timeout
- rest client
- swiper (viw// with a quickfix window) or with telescope?
- nav flash
- better % matching plugins in lua
- snippet support for html, css for lsp
- tag completion html, jsx (emmet?)
- chaoren/vim-wordmotion
- suda.vim
- minimap.vim
- folke/todo-comments.nvim
- jdaddy.vim
- endwise.vim
- copy from sensible.vim
- signature.vim
- sneak.vim
### Thing to future
- consider nvim-compe
- maybe try diagnostic ls
- add dap https://alpha2phi.medium.com/neovim-lsp-and-dap-using-lua-3fb24610ac9f
- SPC-' to open last telescope / subscribed to issue
- slim treesitter
- show searched results in folds/ open fold when searching? close em afterwards?
- show jump list in mini buffer when jumping, close it with any other keystroke

```
print(vim.api.nvim_buf_add_highlight(0, -1, 'Visual', 0, 0, -1))
```

### some vim stuff
- read about registers
zz for center
CTRL-o in insert mode
q: command history and editing in normal mode, <cr> to execute
q/ to search search history
:h navigation

gv to return to last visual selection
gi to go to last place where insert mode was used
gn and gN to visual last search

vib to select inside block

(hello test)
does not work with multiple ?

vit to select inside tag

can map something to ga
or to C-g
==
g$
g0
gJ to join lines wihtout a space in between
g~<motion> switch capitalization
~ change cap. of one letter
g& redo last substitution s/.../.../g for all selected text with /

<a>...</a>

:cle[arjumps]		Clear the jump list of the current window.
:changes

						*[(*
[(			Go to [count] previous unmatched '('.
			|exclusive| motion.

						*[{*
[{			Go to [count] previous unmatched '{'.
			|exclusive| motion.

						*])*
])			Go to [count] next unmatched ')'.
			|exclusive| motion.

						*]}*
]}			Go to [count] next unmatched '}'.
			|exclusive| motion.


						*]m*
]m			Go to [count] next start of a method (for Java or
			similar structured language).  When not before the
			start of a method, jump to the start or end of the
			class.  When no '{' is found after the cursor, this is
			an error.  |exclusive| motion.
						*]M*
]M			Go to [count] next end of a method (for Java or
			similar structured language).  When not before the end
			of a method, jump to the start or end of the class.
			When no '}' is found after the cursor, this is an
			error. |exclusive| motion.
						*[m*
[m			Go to [count] previous start of a method (for Java or
			similar structured language).  When not after the
			start of a method, jump to the start or end of the
			class.  When no '{' is found before the cursor this is
			an error. |exclusive| motion.
						*[M*
[M			Go to [count] previous end of a method (for Java or
			similar structured language).  When not after the
			end of a method, jump to the start or end of the
			class.  When no '}' is found before the cursor this is
			an error. |exclusive| motion.

						*[#*
[#			Go to [count] previous unmatched "#if" or "#else".
			|exclusive| motion.

						*]#*
]#			Go to [count] next unmatched "#else" or "#endif".
			|exclusive| motion.




(hello test)
does not work with multiple ?
