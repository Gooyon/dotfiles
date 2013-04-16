# Terminalでも Macvim KaoriYa を使う。
# 参考 http://www.tokoro.me/2012/12/31/mac-terminal-japanese/
if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
fi

export EDITOR=/usr/local/bin/subl

#=============================
## rbenv
##=============================
#if [ -d ${HOME}/.rbenv  ] ; then
    #PATH=${HOME}/.rbenv/bin:${PATH}
    ##RBENV_ROOT=${HOME}/.rbenv
    #export PATH
    #eval "$(rbenv init -)"
    ## eval "$(phpenv init -)"
#fi
