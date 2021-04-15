## Bootstrapping

Run the following script to bootstrap a fresh Fedora GNOME install:
```shell
wget https://raw.githubusercontent.com/vikdotdev/dotfiles/master/bin/bin/s-fedora-bootstrap
chmod +x s-fedora-bootstrap
./s-fedora-bootstrap
rm s-fedora-bootstrap
```
screenkey -p fixed -g $(slop -n -f '%g')
find . -xtype l -delete
autoindent with == (works with motions and range)

## Neovim
### Thing to do
- fix issues with autochdir or whatever with telescope search
- custom buffer manager like bufkill in lua
- when killing a buffer go to last visited buffer instead of the one higher oon stack?
- set alternate buffer alter killing a buffer
- snippet support for html, css for lsp
- tag completion html, jsx (emmet?)
- light theme switcher for term and vim
- fix blaming toggle timeout
- conditional LSP shortcuts based on capabilities
- improve ripgrep matching to be similar to DOOM * (with spaces)
- consider nvim-compe
- maybe try diagnostic ls
- add dap https://alpha2phi.medium.com/neovim-lsp-and-dap-using-lua-3fb24610ac9f
- treesitter ruby interpolation bug with highlight (pattern matching)
- rest client
- mass replace S-R in visual mode
- swiper (viw// with a quickfix window) or with telescope?
- nav flash
- SPC-' to open last telescope / subscribed to issue
- slim treesitter
- show searched results in folds/ open fold when searching? close em afterwards?
- better % matching plugins in lua
- follow url

```
print(vim.api.nvim_buf_add_highlight(0, -1, 'Visual', 0, 0, -1))
```

zz for center
CTRL-o in insert mode
