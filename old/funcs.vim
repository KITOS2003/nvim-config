function MAKE()
    let Command = { 'c'    : '$NVIMCONF/c_make.sh all', 
                \   'cpp'  : '$NVIMCONF/c_make.sh all', 
                \   'rust' : 'cargo build --all-targets',
                \   'tex'  : 'pdflatex %'
                \ }
    let command  = Command[&ft]
    let filename = expand('%:t')
    let command = substitute( command, '%', filename, 'g' )
    return command
endfunction

function CLEAN()
    let Command = {
                \   'c'     : '$NVIMCONF/c_make.sh clean',
                \   'cpp'   : '$NVIMCONF/c_make.sh clean',
                \   'rust'  : 'cargo clean',
                \}
    let command = Command[&ft]
    let filename = expand('%:t')
    let command = substitute( command, '%', filename, 'g' )
    return command
endfunction

function RUN()
    let Command = {
                \   'c'     : '$NVIMCONF/c_make.sh run',   
                \   'cpp'   : '$NVIMCONF/c_make.sh run', 
                \   'rust'  : 'cargo run',                
                \   'python': 'python %',
                \   'tex'   : 'nohup zathura % > /dev/null & disown',
                \}
    let command = Command[&ft]
    let filename = expand('%:t')
    let command = substitute( command, '%', filename, 'g' )
    return command
endfunction
        

