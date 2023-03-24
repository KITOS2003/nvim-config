let g:vimtex_general_viewer = "zathura"
let g:vimtex_view_method = "zathura"

let g:vimtex_compile_method = "latexmk"
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '.',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
