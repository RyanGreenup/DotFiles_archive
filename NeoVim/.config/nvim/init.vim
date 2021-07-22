

""" ##################################################
"####### My Vim Settings ##########################
"##################################################
"
"
"
""" Generic Settings
"##############################
"####### Generic Settings #####
"##############################

" set autochdir " this might bake plugins but it's just way too fucking confusing otherwise, I keep forgetting to hit `SPC f c d`
set nocompatible
set mouse=a " this is brillian for touch screen ; requires `apt install vim-gtk`
filetype plugin on
syntax on
set number "Absolute Number
"set autochdir "This will conflict with some things
"                " So instead I'm just going to be minful to open
"                vim in ranger in the desired working directory
nnoremap <silent><Leader>fcd :cd %:p:h<CR>
nnoremap <silent><Leader>fcd :lcd %:p:h<CR>

set relativenumber
imap jj <Esc> " What I'm Used to
imap fd <Esc> " What Spacemacs Uses
imap jk <Esc> " What Doom Uses

" If latent files get annoying consider doing:
" set undodir/.vim/undodir
" 	Or whatever directory
set ignorecase
set smartcase " if you search for something purely lowercase, it will do a case insensitive search
set autoread  "Automatically re-read files
set encoding=utf-8

""""" Keyboard Remaps
nmap <Leader><Space> :Commands<CR>
nmap <C-x><C-k> :bd<CR>
nmap <Leader>rr "
nmap <leader>wd :q<CR>
nmap <leader>w <C-w>
nmap <leader>fd :! rm "%"
nmap <leader>ss :BLines<CR>
nmap <leader>bb :Buffers<CR>


"""" Plugins
"############################## 
"###### Plugins ############### 
"############################## 

""""" Vim-Plug

" Set up if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

""""" Programming
""""" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'


""""" End Plugins
" Initialize plugin system
call plug#end()

"""" Programming
""""" Completion-Nvim (Completion Framework for LSP)
" https://github.com/nvim-lua/completion-nvim 

" On all Buffers
autocmd BufEnter * lua require'completion'.on_attach()
let g:completion_enable_snippet = 'UltiSnips'
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

""""" LSP
lua require'lspconfig'.rust_analyzer.setup{}
lua require'lspconfig'.clangd.setup{}
lua require'lspconfig'.cssls.setup{}
lua require'lspconfig'.dockerls.setup{}
lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.html.setup{}
lua require'lspconfig'.java_language_server.setup{}
lua require'lspconfig'.texlab.setup{}
lua require'lspconfig'.pyright.setup{}
lua require'lspconfig'.julials.setup{}
lua require'lspconfig'.r_language_server.setup{}
lua require'lspconfig'.sqlls.setup{}
lua require'lspconfig'.stylelint_lsp.setup{}
lua require'lspconfig'.vala_ls.setup{}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.zls.setup{}
lua require'lspconfig'.texlab.setup{}

" Probably won't need these
" lua require'lspconfig'.dartls.setup{}
" lua require'lspconfig'.angularls.setup{}

""""" Tree Sitter


""" Modeline Folding
set modeline
set modelineexpr  "This does all the magic folding
   " This is always enabled in OG vim, in nvim it must be physically enabled
     " Vim will giv a warning about not recognising this command, which is
     " fine because it shouldn't and it notifies us that we are using vim and
     " not nvim. Google "vim modeline vulnerability 2019" for more info 


" Found this [here](https://vi.stackexchange.com/a/3820)

" vim:fdm=expr:fdl=0
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
"
" Comments MUST be on the first column or this will break, that's the issue


