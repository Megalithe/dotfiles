if has("unix")
    let s:uname = system("uname -s")
        if s:uname == "Darwin"
          " set the runtime path to include Vundle and initialize
            set rtp+=~/.vim/bundle/Vundle.vim
            call vundle#begin()
          " let Vundle manage Vundle, required
            Plugin 'VundleVim/Vundle.vim'
            Plugin 'vitorgalvao/autoswap_mac'

          " All of your Plugins must be added before the following line
            call vundle#end()            " required
            filetype plugin indent on    " required
          " To ignore plugin indent changes, instead use:
          " filetype plugin on
          "
          " Brief help
          " :PluginList       - lists configured plugins
          " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
          " :PluginSearch foo - searches for foo; append `!` to refresh local cache
          " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
          "
          " see :h vundle for more details or wiki for FAQ
          " Put your non-Plugin stuff after this line
   endif
endif

set nocompatible                    "Be iMproved, required
filetype on                         "File type detection

syntax on                           "Syntax highlighting - can be changed for language"
colorscheme desert
set number                          "set line numbers"
set ruler                           "x-axis cursor position details listed at bottom"
set showmatch                       "Highlight matching [{()}]
set hlsearch                        "Highlight search"
 noremap <silent> n n:call HLNext(0.4)<cr>
 noremap <silent> N N:call HLNext(0.4)<cr>
  function! HLNext (blinktime)
     set invcursorline
     redraw
     exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
     set invcursorline 
     redraw
  endfunction
set incsearch                       "Search as characters are entered
set ignorecase                      "Case insensitive searchingi"
set smartcase                       "Unless you use upper case in your search"
set autoindent                      "Applies indenting on preceeding line to line below"
"set smartindent                     Indenting according to syntax "
"set mouse=a                         Allows clicking of terminal"
set listchars=tab:>>,nbsp:_,trail:.        "display characters for set lists" #tab:>>,
set list                            ""
set wildmenu                        "enables a menu at the bottom of the vim/gvim window."
set wildmode=list:longest,full      "colon command completion"

