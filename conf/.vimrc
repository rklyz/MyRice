call plug#begin()
Plug 'danishprakash/vim-yami'
Plug 'elkowar/yuck.vim'
Plug 'mangeshrex/everblush.vim'
call plug#end()

if has('termguicolors')
      set termguicolors
endif

set noeb vb t_vb=
colorscheme everblush
