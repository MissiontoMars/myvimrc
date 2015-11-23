:set cscopequickfix=s-,c-,d-,i-,t-,e-
:set nu
:set foldmethod=marker
:set foldlevel=99
:set ts=4
:set autoindent
set t_Co=256
"将当前编辑的文件所在的路径设置成VIM的当前路径
set autochdir

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1   
let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1 
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos="right"
let NERDTreeWinSize=30
let NERDChristmasTree=1
let NERDTreeAutoCenter=1


map <f3> :NERDTree<cr>
"map <f2> :Tlist<cr>
map <f6> :QFix<cr>
map <f4> zf%			#创建代码折叠
map <z> zc
map <f7> :%s///gn<cr>

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_WinWidth = 25
let Tlist_Show_One_File = 1

"colorscheme evening
"colorscheme molokai
syntax enable
syntax on
syntax keyword cTodo contained TODO FIXME XXX WARNNING:
set background=dark
let g:solarized_termcolors = 256
colorscheme solarized

set cursorline
hi CursorLine ctermbg=none cterm=underline

map <C-n> :bp<cr>
map <C-m> :bn<cr>
"let &termencoding=&encoding    "For Chinese
set encoding=utf-8
"set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

"set smarttab
"set tabstop=4
"set shiftwidth=4
"set expandtab

"high light
set hlsearch
"实时看到查找的结果
set incsearch

"TAB 补全
set wildmode=longest,list,full
set wildmenu

set so=15

"for comment
nmap <C-j>s <C-[>I//<C-[>
nmap <C-j>S <C-[>I/*<C-[>A*/<C-[>
nmap <C-j>d <C-[>^xx<C-[>
nmap <C-j>D <C-[>^xx<C-[>$xx<C-[>

"for ctags and scope
execute "cs add cscope.out"
map <F12> :call Do_CsTag()<CR>
nmap <C-a>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-a>g :cs find g <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-a>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-a>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-a>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-a>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-a>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-a>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
"set tags=./tags,./TAGS,tags;~,TAGS;~
"set tags=./tags
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.cc' -o -name '*.java' -o -name '*.cs' > cscope.files"
        silent! execute "!cscope -Rbq"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction

function! AutoLoadCTagsAndCScope()
    let max = 10
    let dir = './'
    let i = 0
    let break = 0
    while isdirectory(dir) && i < max
        if filereadable(dir . 'GTAGS')
            execute 'cs add ' . dir . 'GTAGS ' . glob("`pwd`")
            let break = 1
        endif
        if filereadable(dir . 'cscope.out')
            execute 'cs add ' . dir . 'cscope.out'
            let break = 1
        endif
        if filereadable(dir . 'tags')
            execute 'set tags =' . dir . 'tags'
            let break = 1
        endif
        if break == 1
            execute 'lcd ' . dir
            break
        endif
        let dir = dir . '../'
        let i = i + 1
    endwhile
endf
nmap <F8> :call AutoLoadCTagsAndCScope()<CR>
" call AutoLoadCTagsAndCScope()
" http://vifix.cn/blog/vim-auto-load-ctags-and-cscope.html

"键入)、] 、}，显示(、[、{ 
set showmatch
"在插入模式下通过按[Ctrl]N自动地将任何类、方法或者字段名补齐 
set complete+=k 
"自动加注释的*星号
set formatoptions=tcro
"要用声音烦我！ 
set visualbell
"for vimroom
"autocmd vimenter * VimroomToggle
let g:vimroom_sidebar_height = 0
let g:vimroom_background="white"
let g:vimroom_width=110


""for vimroom
"自动打开NERDTree
"autocmd vimenter * NERDTree
"焦点切换到代码窗口
"autocmd vimenter * wincmd p

"好用的命令，必须知道哇  http://webcache.googleusercontent.com/search?q=cache:lhHA-G0mrXoJ:hi.baidu.com/yanyulou/item/d0ccf59b87cdacdd1f427134+&cd=2&hl=zh-CN&ct=clnk&gl=cn
"   n+S     删除n行，并且进入insert模式
"   n+S     删除n个字符，并且进入insert模式
"   Ctrl+[  相当于Esc，用起来更顺手
"   Ctrl+r  重做
"   o       在当前行之下新开一行插入
"   O       在当前行之上新开一行插入
"   0       到行首
"   ^       到本行的第一个非blank字符
"   $       到行尾
"   g_      到本行最后一个不是blank字符的位置

"   r       替换当前字符
"   R       替换当前及后续字符，直到按Esc

"   ab      选择()中的内容(V模式)
"   ib      选择()中的内容(不含())(V模式)
"   ab      选择{}中的内容(V模式)
"   ib      选择{}中的内容(不含R{}(V模式)

"   '.      跳转到最后修改的那一行

"   Ctrl+n Ctrl+p   我擦，自动补全啊，这么容易就粗线了？？！！

"ctags命令
"   Ctrl+]  跳转到光标所在函数标识符的定义处
"   Ctrl+t  退回上层
"   gd      转到当前光标所指的局部变量的定义
