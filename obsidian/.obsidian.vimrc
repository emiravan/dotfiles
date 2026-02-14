unmap <Space>

" remap esc key
imap kj <Esc>
imap jk <Esc>

" tab navigation
exmap tabnext obcommand workspace:next-tab
nmap <Tab> :tabnext<CR>
exmap tabprev obcommand workspace:previous-tab
nmap <S-Tab> :tabprev<CR>

" better scrolling and searching with centered always
noremap <c-d> <C-d>zz
noremap <c-u> <C-u>zz
noremap <n> nzzzv
noremap <N> Nzzzv

"map leader for local search"
exmap local_search obcommand editor:open-search
nmap <Space>/ :local_search<CR>
vmap <Space>/ :local_search<CR>

" Leader key search/replace (<leader>s)
exmap search_replace obcommand editor:open-search-replace
nmap <Space>s :search_replace<CR>

exmap quick_switch obcommand switcher:open
nmap <Space><Space> :quick_switch<CR>

" Copy file path (similar to your leader-y)
exmap copy_path obcommand workspace:copy-path
nmap <Space>y :copy_path<CR>

" Leader key window/split operations (<space>q to close)
exmap close_others obcommand workspace:close-others
nmap <Space>q :close_others<CR>

" Explorer/file tree (<leader>e)
exmap toggle_sidebar obcommand app:toggle-left-sidebar
nmap <Space>e :toggle_sidebar<CR>

"yank to clipboard
set clipboard=unnamed

" other
nnoremap g gg
nnoremap z zz