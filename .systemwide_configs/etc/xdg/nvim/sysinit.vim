" This line makes pacman-installed global Arch Linux vim packages work.
source /usr/share/nvim/archlinux.vim

filetype plugin on
syntax on

"set visualbell noerrorbells            " don't beep
set nu rnu                              " show line numbers
set hlsearch incsearch                  " highlight search and incremental search
set clipboard+=unnamedplus              " enable clipboard copy / paste
set ignorecase
set smartcase

" Replace all is aliased to S
nnoremap S :%s//g<Left><Left>
