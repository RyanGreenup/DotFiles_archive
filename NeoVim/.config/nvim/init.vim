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

set nocompatible
set mouse=a " this is brillian for touch screen ; requires `apt install vim-gtk`
filetype plugin on
syntax on
set number "Absolute Number
set relativenumber
imap jj <Esc>
imap fd <Esc>
" If latent files get annoying consider doing:
" set undodir/.vim/undodir
" 	Or whatever directory
set ignorecase
set smartcase " if you search for something purely lowercase, it will do a case insensitive search
set autoread  "Automatically re-read files
set encoding=utf-8


"""" Plugins
"############################## 
"###### Plugins ############### 
"############################## 

"""" Vim-Plug

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
"
""""" General Stuff
"Auto-Save
Plug '907th/vim-auto-save'
" example
let g:nv_search_paths = ['~/Notes/MD/notes/', '~/Dropbox/Notes/MD/notes/', '~/writing', '~/code', 'docs.md' , './notes.md']


" Notational Velocity
Plug 'https://github.com/alok/notational-fzf-vim'

"Folding plugin to work like org-mode
"Plug 'msuperdock/vim-foldout'
"   "This get's rid of any writing on the fold,
"      It also breaks all the time,
"      leave it off

"SpeedDating
Plug 'tpope/vim-speeddating'


"Distraction Free Editing
Plug 'junegunn/goyo.vim'

"Thesaurus
Plug 'ron89/thesaurus_query.vim'



"Org Mode
Plug 'jceb/vim-orgmode'

"Use Ranger as the file explorer
Plug 'iberianpig/ranger-explorer.vim'
Plug 'rbgrouleff/bclose.vim'
" Refer to 
"https://github.com/iberianpig/ranger-explorer.vim
"
nnoremap <silent><Leader>ft :RangerOpenCurrentDir<CR>
nnoremap <silent><Leader>f :RangerOpenProjectRootDir<CR>
"

""""" vim-markdown-wiki NOT VimWiki
Plug 'mmai/vim-markdown-wiki'

" Fix the titles
 function! MdwiWriteTitle(word)
   return 'normal!\ a# '.strftime('%c').' - '.escape(a:word, ' \').'\<esc>'
 endfunction


""""" Vim-Emoji
"Plug 'junegunn/vim-emoji'
"Plug 'junegunn/vim-github-dashboard'
Plug 'kyuhi/vim-emoji-complete'

""""" Python-Mode
Plug 'python-mode/python-mode'


""""" LaTeX Stuff
" 
" 
"VimTeX
Plug 'lervag/vimtex'

"Conceal Tex
Plug   'KeitaNakamura/tex-conceal.vim', {'for': 'tex'} " for VimPlug
autocmd BufEnter *.tex set conceallevel=2
autocmd BufEnter *.md set conceallevel=2
let g:tex_conceal="abdgms"
hi clear Conceal "This removes the stupid highlighting

"""""" Markdown Stuff

"PlasticBoy Plugin
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'


" This enables syntax highlighting  for Math environments
let g:vim_markdown_math = 1
    "Highlighting is necessary for UltiSnips
    "set syntax=latex sucks because headings don't get highlighted
" Autosave before BuffJump
let g:vim_markdown_autowrite = 1
" Conceal Bold etc.

"Markdown Preview
"Requires yarn and nodejs, they're in apt
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" see if this one let's you follow links
"Plug 'suan/vim-instant-markdown', {'for': 'markdown'}



"R-Markdown Preview
Plug 'vim-pandoc/vim-rmarkdown'


""""""" Text Objects
Plug 'kana/vim-textobj-user'
" use if/af to search forward for code block, iF/aF goes back
" Then you could fold it with zif
Plug 'coachshea/vim-textobj-markdown' 
"Use i$/a$ for inline math and ie/ae for environments
Plug 'rbonvall/vim-textobj-latex'

"""""" Sandwhich
" use s for sandwhich a/d/r for add delete replace then just text object
Plug 'machakann/vim-sandwich'



""""" Defaults

Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'


"""" Themes
Plug 'NLKNguyen/papercolor-theme'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

" Initialize plugin system
call plug#end()


""" Editing Workflow
"##############################
"##### Editing ################
"##############################


"""""" UltiSnips

" Alt only seems to work in NeoVim, not in Vim,
" I tried using M-j and A-j no dice, just use NeoVim.
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
 
 let g:UltiSnipsExpandTrigger="<A-l>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"let g:UltiSnipsExpandTrigger="<M-l>"
let g:UltiSnipsJumpForwardTrigger="<A-l>"
let g:UltiSnipsJumpBackwardTrigger="<A-h>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/UltiSnips']

 " If you want :UltiSnipsEdit to split your window.
 let g:UltiSnipsEditSplit="vertical"



     


 """" Right Align Text
function! RightAlignVisual() range
    let lim = [virtcol("'<"), virtcol("'>")]
    let [l, r] = [min(lim), max(lim)]
    exe "'<,'>" 's/\%'.l.'v.*\%<'.(r+1).'v./\=StrPadLeft(submatch(0),r-l+1)'
endfunction
function! StrPadLeft(s, w)
    let s = substitute(a:s, '^\s\+\|\s\+$', '', 'g')
    return repeat(' ', a:w - strwidth(s)) . s
endfunction
"""" FileType Remap

"""" AutoCmd

"Use F2 to Compile markdown
autocmd BufEnter *.tex :map <f2> :w<cr><leader>ll 
autocmd BufEnter *.md :map <f2> :! prevmd "%" <Enter> <Enter>
autocmd BufEnter *.md :map <leader>lv  :! firefox --new-window "$(echo "%" \| cut -f 1 -d '.').html" & disown <Enter>

""""" Boostnote
"autocmd BufEnter *.md :setlocal filetype=markdown
autocmd BufEnter *.md :setlocal filetype=markdown
autocmd BufEnter *.cson :setlocal filetype=markdown 
autocmd BufEnter *.Rmd :setlocal filetype=markdown 


autocmd BufEnter *.t :setlocal filetype=javascript

	" all my snippets are in markdown not md
autocmd BufEnter *.cson :set syntax=markdown 
" Switch between math mode editing and tex
" This is handy to quickly switch snippets but
" generally make sure vim-pandoc-syntax means
" markdown snippets will work as well.
" This could be good for RStudio where we have tikz and aligned integration
nnoremap <Leader>t :set syntax=tex<CR> 
nnoremap <Leader>t :setlocal filetype=tex<CR>
nnoremap <Leader>m :set syntax=markdown<CR> 
nnoremap <Leader>m :setlocal filetype=markdown<CR> 

"nnoremap <Leader>r :set syntax=expand('%:e')<CR> 
nnoremap <Leader>r :e!<CR>

"Map F3 to XeLaTeX


" F12  Mappings
 " Open TexStudio with F12
autocmd BufEnter *.tex :map <f12> :w<cr>:!texstudio "%" <Enter>
autocmd BufEnter *.md :map <f12> :w<cr>:!typora "%" & disown <Enter>
"autocmd BufEnter *.md :map <f12> :w<cr>:!marktext "%" & disown <Enter>
"autocmd BufEnter *.Rmd :map <f12> :w<cr>:!marktext "%" & disown <Enter>


"""" Templates
autocmd BufNewFile *.tex 0r  ~/Dropbox/profiles/Templates/LaTeX/LaTeX.tex
autocmd BufNewFile *.sh 0r  ~/Dropbox/profiles/bin/hworld.sh





"""" LaTeX Settings

""""" My Settings 
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_levelmarker = "*"
let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-shell-escape',
      \   '-silent',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ],
      \ 'build_dir' : 'livepreview',
      \}
"disable errors but for good cause
" to view quickfix warning buffer use `<leader>le` 
" they disappear with =fks= mode
let g:vimtex_quickfix_enabled=0


""""" Castel Dev


"    Plug 'lervag/vimtex'
        let g:tex_flavor='latex'
        let g:vimtex_view_method='mupdf'
"         let g:vimtex_view_method='evince'
"        let g:vimtex_view_method='zathura'
"       let g:vimtex_quickfix_mode=0
    




"""" YouCompleteMe
Plug 'ycm-core/YouCompleteMe'

"""" MarkDown
""""" PlasticBoy Settings
" Don't Hide Code Blocks
let g:vim_markdown_conceal_code_blocks = 0
" Syntax highligt code blocks
let g:vim_markdown_fenced_languages = ['csharp=cs', 'bash=sh', 'R=r', 'elisp=el', 'markdown=md', 'python=py', 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'mathematica=wsl']
" Follow Anchors
let g:vim_markdown_follow_anchor = 1
" Syntax Highting
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
" Adjust new item indent
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_new_list_item_indent


""""" Syntax Highlighting
"This is now handled by a plugin 'vim-pandoc/vim-pandoc-syntax'
  " Because I'm not using `vim-pandoc` as my Plugin of Choise:

"""""" Old method
"Don't Use this method because it means you get
"no Syntax highlighting for non-TeX stuff in MD
   "Have markdown files highlighted like tex so math() context will work
   "autocmd BufEnter *.md :set syntax=tex
   "autocmd BufEnter *.md :set syntax 


""""" Markdown Preview
"""""" iamcco
"Refer to [iamcco/markdown-preview](https://github.com/iamcco/markdown-preview.nvim)

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0 "Auto only works in chromium, if using firefox maybe turn it off
    " This causes crashes when you have more than one vim window

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1 "only works in chromium"

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 1

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 1

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
"
" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
"let g:mkdp_open_ip = '192.168.0.134'
" You have to set up a static ip by modifying `NetworkManager`
" just open the Advanced Network Settings in Ubuntu
"
"
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
"let g:mkdp_browser = ''
" chromium is way too slow
"let g:mkdp_browser = 'epiphany'
let g:mkdp_browser = 'epiphany'

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 1

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {}
    \ }

" use a custom markdown style must be absolute path
"let g:mkdp_markdown_css = '/home/ryan/Dropbox/profiles/Templates/CSS/pandocoffic.css'
"let g:mkdp_markdown_css = '/home/ryan/Dropbox/profiles/Emacs/dotemacs/org-css/Killercup.css'
"
let g:mkdp_markdown_css = '/home/ryan/Dropbox/profiles/Templates/CSS/gitOrgWrapped.css'
"let g:mkdp_markdown_css = '/home/ryan/Dropbox/profiles/Templates/CSS/iamccoGithub.css'
    " This is the default but I must specify it in order to change the
    " Code Block Preview
    " Also the iamcco doesn't work for pandoc but only works for the preview
    " The gitorgwrapped one works for pandoc but not for preview, I don't know
	    " well it works for preview but scales too small on mobile
    " why :shrug:

"let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
"let g:mkdp_highlight_css = '/home/ryan/Dropbox/profiles/Templates/CSS/TomorrowNight_HighlightJS.css'
let g:mkdp_highlight_css = '/home/ryan/Dropbox/profiles/Templates/CSS/TomorrowNight_HighlightJS.css'

" let g:mkdp_highlight_css = 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.15.10/styles/dracula.min.css'

" let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
 let g:mkdp_port = '8353'

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'


""""" iamcco Markdown Preview Mappings
"This used KaTeX, which is quicker and probably preferable anyway,
"refer to ~/Notes/Notable/KaTeX_and_MD_Notes.md
"
""""" VimWiki
"let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
"let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
"let g:vimwiki_global_ext = 0 "only set filetype of of markdown inside wiki folder
""""" Default Maps

"nmap <C-x> <Plug>MarkdownPreview
nmap <Leader>v <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle
" This is a little bit quicker to load
"command! OpenBrowser :silent ! start chrome "file://%:p"
   " Not disowning leaves it tied to vim
"nmap <Leader>b :silent ! start chrome "file://%:p" 
"This has the massive advantage of allowing links to be followed
" This is way fucking better than iamcco!!
nmap <Leader>b :silent ! vivaldi "file://%:p" & disown <CR> 

"This with the code copier single click (includes history!) extension is the
"way to go for sure.
"No script breakes this [read this fix](https://support.mozilla.org/en-US/questions/1157703)

" you might also want to look at [`shiba`](https://github.com/rhysd/Shiba/blob/master/docs/installation.md)


"""""" Using Suan/Vim-instant-Markdown 
" I'm hoping that this will allow me to follow links
"filetype plugin on
"Uncomment to override defaults:
"let g:instant_markdown_slow = 1
"let g:instant_markdown_autostart = 1
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 1
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1



"Plug 'vimwiki/vimwiki' The extra features are nice
" I only want a markdown wiki so it wil /just/ work with mweb on ios 
" (as well as other apps), vimwiki incorporates /vim-markdown-wiki/ but
" I don't need all the hassle of vimwiki if `vim-markdown-wiki` will just
" work, vimwiki will break putting underscores in and it will break the very
" sensible syntax.
"
:map <leader>ww :e ~/Dropbox/Notes/MD/notes/index.md <CR>
" make this run the 'ns' script as well. or maybe use <leader>ws
" This conflicted with Tocv in Plastic boy,
" I remapped it but normal enter seems to 
" just work with CR anyway so whatever
nnoremap <S-CR> :MdwiGotoLink 
nnoremap <leader><CR> :MdwiReturn

" Fix the titles
" function! MdwiWriteTitle(word)
"   "return 'normal!\ a# '.strftime('%c').' - '.escape(a:word, ' \').'\<esc>'
"   return 'normal!\ a#  '.escape(a:word, ' \').'\<esc>'
" endfunction

" Make sure the path has ./ in it for MWeb
   " I changed this here
   " /home/ryan/Dropbox/profiles/.vim/plugged/vim-markdown-wiki/after/ftplugin/markdown.vim
   " ~/.vim/plugged/vim-markdown-wiki/after/ftplugin/markdown.vim






"############################## 
"###### Re Mapping ############ 
"############################## 
""""" Vim-Emoji
"let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
"let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
"let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
"let g:gitgutter_sign_modified_removed = emoji#for('collision')
"set completefunc=emoji#complete
"for e in emoji#list()
"  call append(line('$'), printf('%s (%s)', emoji#for(e), e))
"endfor


"""" Useful mappings
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>


" Focus Mode
nnoremap fks :Goyo<CR><CR>

"Enable Auto Save
let g:auto_save = 1  " enable AutoSave on Vim startup
"Silent Save
"let g:auto_save_silent = 1  " do not display the auto-save notification

" Clipboard sharing
" Don't use this, use the remapings at leader-clip-reymap
"set clipboard=unnamedplus
" Maybe us this instead? read :help clipboard
"set clipboard+=unnamed

" Remap FZF
nnoremap <C-p> :<C-u>FZF<CR>


" Remap F4 to CopyFileDirectory
noremap <silent> <F4> :let @+=expand("%:p")<CR>
noremap <silent> <leader>fy :let @+=expand("%:p")<CR>

" Return to previous Buffer
"Jump back to last edited buffer
nnoremap <C-b> <C-^>
inoremap <C-b> <esc><C-^>

"Cycle Buffers (p. 64 Mastering Vim)
noremap <C-k> :bprev<CR>
map backspace :bprev<CR>
map <leader>bp :bprev<CR>
noremap <C-j> :bnext<CR>
map <Leader>bn :bnext<CR>



"Save Document


"""" Leader Key
"This is probably for the best because matches spacemacs
"let mapleader="\<Space>"
map <Space> <Leader>

""""" Clipboard-Map
" Write file leader-clip-reymap
"
"
nnoremap <Leader>fs :w<CR> 
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P















""""" Visual Selection

" Run the dot command over visually selected lines
vnoremap . :normal.<CR>

" Move visual selection
  " So the problem with this is it get's rid of 
  " Join so instead, Alt+j/k
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv



""""" Folding
  set foldenable           "Enable folding
  set nofoldenable           "Enable folding
"  set foldlevelstart=0     "Open most of the folds by default. If set to 0, all folds will be closed.
  set foldnestmax=10       "Folds can be nested. Setting a max value protects you from too many folds.
  set foldmethod=expr    "Defines the type of folding. globally, so if you don't have an 
"                        " Auto method defined, it expects instructions at the
"                        end like in this file
":autocmd BufRead /path/to/file setlocal foldmethod=marker
":autocmd FileType java setlocal foldmethod=marker
":autocmd BufEnter *.tex set foldmethod=manual " This will use the inbuild, but it will let
"                                              fold things manually, like
"                                              equations/code blocks

  let r_syntax_folding=1   "R code folding
  let sh_fold_enabled=1    "Shell Scirpts
" unfourtunately manual folding doesn't work in markdown because plasticboy,
" the following let's plasticboy fold and let's manual folding of say code
" blocks
:map <leader>fm :set foldmethod=manual<CR>


"""" fzf mappings fzf-vim-usage 
  " Mapping selecting mappings
"    nmap <leader><tab> <plug>(fzf-maps-n)   "I couldn't fix these?
"    xmap <leader><tab> <plug>(fzf-maps-x)
"    omap <leader><tab> <plug>(fzf-maps-o)
"
"    " Insert mode completion
"    imap <c-x><c-k> <plug>(fzf-complete-word)
"    imap <c-x><c-f> <plug>(fzf-complete-path)
"    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
"    imap <c-x><c-l> <plug>(fzf-complete-line)
"
"may work in bash/zsh
"inoremap <expr> <c-x><c-f> fzf#vim#complete#path( 
"    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
"    \ fzf#wrap({'dir': expand('%:p:h')}))
"
" invoke fzf files with <C-p>
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <leader>bW :Buffers<CR>
nnoremap <leader>bW :Buffers<CR>


""" Themes 
" Theme Must go at the bottom
set t_Co=256   " This is may or may not needed.

"set background=light
"colorscheme PaperColor
"colorscheme challenger_deep




""" Modeline Folding

" Nah this breaks all the time, instead I'm going to use 2 whitespace
" characters and change > to use 2 white spaces (I know 4 is standed but it's
" going to prohibit deep nesting
" using indent folding also allows manual folding with zfip or zfif (markdown
" plugin)
"set shiftwidth=2





set modeline
set modelineexpr  "This does all the magic folding
   " This is always enabled in OG vim, in nvim it must be physically enabled
     " Vim will giv a warning about not recognising this command, which is
     " fine because it shouldn't and it notifies us that we are using vim and
     " not nvim. Google "vim modeline vulnerability 2019" for more info 


" Found this [here](https://vi.stackexchange.com/a/3820)


" Found this [here](https://vi.stackexchange.com/a/3820)

" vim:fdm=expr:fdl=0
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
"
" Comments MUST be on the first column or this will break, that's the issue
