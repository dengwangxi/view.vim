# view.vim

preview search result in quickfix window of vim

## To work with ack.vim

Configure ack mappings to close preview window before action:

```
let g:ack_mappings = {                                                                                                                          
        \ "t": ":pclose<CR><C-W><CR><C-W>T",                                                                                                                 
        \ "T": ":pclose<CR><C-W><CR><C-W>TgT<C-W>j",                                                                                                         
        \ "o": ":pclose<CR><CR>",                                                                                                                            
        \ "O": ":pclose<CR><CR><C-W>p<C-W>c",                                                                                                                
        \ "go": ":pclose<CR><CR><C-W>p",                                                                                                                     
        \ "h": ":pclose<CR><C-W><CR><C-W>K",                                                                                                                 
        \ "H": ":pclose<CR><C-W><CR><C-W>K<C-W>b",                                                                                                           
        \ "v": ":pclose<CR><C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t",                                                                                               
        \ "gv": ":pclose<CR><C-W><CR><C-W>H<C-W>b<C-W>J",
        \ "q": ":cclose<CR>:pclose<CR>"}
```

## Commands and key maps

* ViewQuickfix    # preview quickfix line
* ViewScrollUp    # scroll up preview page
* ViewScrollDown  # scroll down preview page

Default mappings in quickfix buffer:

* u # scroll up page
* d # scroll down page

## acknowledgement

[skywind3000/vim-preview](https://github.com/skywind3000/vim-preview)<br>
[mileszs/ack.vim](https://github.com/mileszs/ack.vim)
