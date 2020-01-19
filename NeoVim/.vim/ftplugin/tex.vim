" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

"So now it's going to compile in pdf
let g:Tex_DefaultTargetFormat='pdf'

"This is just for want of nonstopmode so theres no more errors getting in my
"way
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $* >/dev/null'
    "If you want warnings and errors get rid of nonstopmode,
    "just comment out this line and it'll be fine


"This is a more precise way to specify the chain
"let g:Tex_FormatDependency_dvi = 'dvi,ps,pdf'
