" --------------------------------------------------------
" Unite
" --------------------------------------------------------
"
let g:unite_split_rule="botright"
" バッファ一覧
nnoremap <silent> <Space>b :<C-u>Unite buffer_tab<CR>
" ファイル一覧
"nnoremap <silent> <Space>f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Space>f :<C-u>Unite file<CR>
" レジスタ一覧
nnoremap <silent> <Space>r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> <Space>m :<C-u>Unite file_mru<CR>
" 常用セット
"nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> <Space>u :<C-u>Unite buffer file<CR>
" 全部乗せ
nnoremap <silent> <Space>a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>


"let g:unite_enable_split_vertically = 1 "縦分割で開く
"let g:unite_winwidth = 30 "横幅30で開く
let g:unite_winheight=10

"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1


