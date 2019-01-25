# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
#   ENVIRONMENT CONFIGURATION
#   ------------------------------
        source "`brew --prefix`/etc/grc.bashrc"    #Colorize logfiles and command output - brew install grc

#   -------------------------------
#   Set Paths
#   ------------------------------------------------------------
    export PATH="$PATH:/usr/local/bin"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH" #brew install coreutils

#Define UserNames:
Username=''

#   Set Defaults
#   ------------------------------------------------------------
    export EDITOR=/usr/bin/vim   # Assigns default editor - Alternatives: nano or subl -w
    export PAGER="less" 
    export BLOCKSIZE=1k          # Set default blocksize for ls, df, du

#   Add color to terminal
#   ------------------------------------------------------------
    export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " #terminal colors
    export CLICOLOR=1 
    export LSCOLORS=ExFxBxDxCxegedabagacad
    export GREP_OPTIONS='--color=auto'
    alias cat='pygmentize -g'                  #Colorize cat output with pygments #brew info python & brew install python & pip install pygment    s
    #TBD color diff?
    #TBD color less/more/most output

#   -----------------------------
#   TERMINAL Optimizations
#   -----------------------------
    #History
        export HISTCONTROL=ignoreboth              #don't save duplicate lines or lines starting with space
        export HISTSIZE=10000                      #Doubles the history file size
        shopt -s histappend
        PROMPT_COMMAND='history -a;history -n'
        bind '"\e[A": history-search-backward'     #Should I put it .inputrc
        bind '"\e[B": history-search-forward'      #
        bind '"\e[C": forward-char'                #
        bind '"\e[D": backward-char'               #
    #Completion
        complete -cf sudo                          # Tab complete for sudo
        complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh  #tab completion for knownhosts
        #[ -e "${HOME}/.ssh/known_hosts" ] && complete -o "default" -o "nospace" -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g     | uniq | cut -f 1 -d ':' | cut -f 1 -d     ']' | cut -d '[' -f2`;)" scp sftp ssh;
    #NYI
        #   set show-all-if-ambiguous on
        #   set completion-ignore-case on

#  aliases :
#   -----------------------------------------------------------
    #Pref Flags
        alias cp='cp -iv'                                          # Copy verbos + prompts for confirmation if overwrite
        alias mv='mv -iv'                                          # move verbos + prompts for confirmation if overwrite
        alias rm='rm -iv'                                          # remove verbos + prompts for confirmation to erase
        alias ls='ls -FGAp'                                        # ls -all but . & .., color, denotes types, sym link ref
        alias ll='ls -FGAplh'                                      # long ls + file size and ^ ls alias
        alias less='less -FSRXc'                                   # Preferred 'less' implementation
        alias more='more -FSRXc'                                   # Preferred 'more' settings
    #Shortcuts
        alias reload='source ~/.bash_profile && source ~/.bashrc'  # reloads .bash_profile and .bashrc
        alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
        alias subl='sublime'  # edit: Opens any file in sublime editor ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime
        trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
        #alias ssh='ssh $1 -l $Username'                           # ssh to host without having to specify your username ssh hostname.domain.___
        alias ~="cd ~"                              # ~:            Go Home
        alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
        #alias scpkey='scp authorized_keys $Username@$:~/.ssh/'    # scp authorized key to remote hosts .ssh directory
        alias tar='gtar'
        alias top='htop'                                           # Replace top with htop download via brew install htop....
        alias p='ping 8.8.8.8'

#   -------------------------------
#   FILE AND FOLDER MANAGEMENT
#   -------------------------------
    #zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
    alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }

#   ---------------------------
#   SEARCHING
#   ---------------------------
     alias qfind="find . -name "                            # qfind: Quickly search for file
     ff () { /usr/bin/find . -name "$@" ; }                 # ff: Find file under the current directory
     ffs () { /usr/bin/find . -name "$@"'*' ; }             # ffs: Find file whose name starts with a given string
     ffe () { /usr/bin/find . -name '*'"$@" ; }             # ffe: Find file whose name ends with a given string
     spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; } # spotlight: Search for a file using MacOS Spotlight's metadata


#   ---------------------------
#   NETWORKING
#   ---------------------------
    alias myip='curl ip.appspot.com; echo '              # myip: Public facing IP Address
    alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip' #
              #Alternate'curl -o /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip'
    alias localip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'" #cleans up ifconfig output to show local ip

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ; myip
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }

#   ---------------------------------------
#   SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'   # finderShowHidden:   Show hidden files in Finder
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'  # finderHideHidden:   Hide hidden files in Finder
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background' # screensaverDesktop: Run a screensaver on the Desktop

#   ---------------------------------------
#   WEB DEVELOPMENT
#   ---------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; } # httpDebug:  Download a web page and show info on what took time

#   ---------------------------------------
#   REMINDERS & NOTES
#   ---------------------------------------
#   brew installed instructions from brew.sh website
#   plugin install string: brew install apg colordiff htop-osx mtr python wget coreutils git ccat curl grc most pwgen tree

