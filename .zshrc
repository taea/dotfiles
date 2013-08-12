#文字コード
export LANG=ja_JP.UTF-8

#プロンプト
autoload colors
colors

#補間
autoload -U compinit
compinit -u

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# path
export PATH="$(brew --prefix)/bin:$PATH"

# Alias
alias ls='ls -G'
alias ll='ls -l'
alias la='ll -a'
alias cdh='cd ~'
alias cds='cd ~/Sites/'
alias cddw='cd ~/Dropbox/work/'
alias cdds='cd ~/Dropbox/sites/'
alias cddp='cd ~/Dropbox/public/'
alias g='git'
alias bx='bundle exec'
alias bi='bundle install'
alias bu='bundle'
alias ap='rake assets:precompile'
alias r='rails'
alias kebab='ssh -v akatsuka@tae.grooves.jp -R 4300:127.0.0.1:3000 sleep 99999'
alias mid='middleman'
alias mig='rake db:migrate'

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '%{'${fg[red]}'%}(%s %b) %{'$reset_color'%}'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "*"
zstyle ':vcs_info:*' formats '%{${fg[red]}%}(%s %b%{${fg[cyan]}%}%c%u%{${fg[red]}%}) %{$reset_color%}'

setopt prompt_subst
precmd () {
  LANG=en_US.UTF-8 vcs_info
  if [ -z "${SSH_CONNECTION}" ]; then
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
[%n]$ "
  else
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
%{${fg[green]}%}[%n@%m]$%{${reset_color}%} "
  fi
}
PROMPT2='[%n]> ' 

#履歴
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

#エディタ
export EDITOR=vi

setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space

#キーバインド
bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
bindkey '^R' history-incremental-pattern-search-backward

# 簡易サーバー起動
alias serv='python -m SimpleHTTPServer 8080'
alias serv2='python -m SimpleHTTPServer 8090'
alias serv3='python -m SimpleHTTPServer 8100'



#ビープ音ならなさない
setopt nobeep

#cd
setopt auto_cd
setopt auto_pushd 
setopt pushd_ignore_dups

#lsと補間にでる一覧の色
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

#デフォルトパーミッションの設定
umask 022

#alias
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GFa"
  ;;
linux*)
  alias ls="ls -Fa --color"
  ;;
esac

alias pg="ps auxw | grep"

alias svnadd="svn st | grep '^?' | awk '{ print \$2 }' | xargs svn add"
alias svndel="svn st | grep '^!' | awk '{ print \$2 }' | xargs svn delete"

alias -g G="| grep"
alias -g L="| less"
alias -g V="| vi -"

#alias gs="git svn"

alias jsonview="perl -MJSON::XS -e 'print JSON::XS->new->utf8->pretty->encode(decode_json <STDIN>)'"

#alias server='python -m SimpleHTTPServer'

#改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

# screen auto startup
if [ $TERM != "screen" -a "`screen -ls | grep Attache`" = "" ]; then
    screen -US `hoami` -xRR
fi

#screenのステータスラインに最後に実行したコマンドを表示
if [ "$TERM" = "screen" ]; then
    #chpwd () { echo -n "_`dirs`\\" }
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
                if (( $#cmd == 1 )); then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*) 
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
            cmd=(${(z)${(e):-\$jt$num}})
            echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    chpwd () {}
fi

#w3m4alc
function alc() {
  if [ $# != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa" | less +37
    #w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
  else
    echo 'usage: alc word'
  fi
}

#pminfo
function pminfo() {
  if [ $# != 0 ]; then
    perl -le 'eval "require $ARGV[0]";print ${"${ARGV[0]}::VERSION"};print qx/perldoc -ml $ARGV[0]/' $*
  else
    echo 'usage: pminfo perlmodule'
  fi
}

#url_decode
function url_decode() {
  if [ $# != 0 ]; then
    perl -MURI::Escape -wle 'print uri_unescape $ARGV[0]' $*
  else
    echo 'usage: url_decode url'
  fi
}

#imageinfo
function imageinfo() {
  if [ $# != 0 ]; then
    perl -MImage::Info -MYAML -le 'print $_, "\n", Dump Image::Info::image_info($_) for @ARGV'
  else
    echo 'usage: imageinfo file [file..]'
  fi
}

#base64 encode
function base64() {
  if [ $# != 0 ]; then
    perl -MMIME::Base64 -0777 -wne 'print encode_base64($_,"")' < $*
  else
    echo 'usage: base64 file'
  fi
}

#個別設定を読み込む
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# node.jsの設定
if [[ -f ~/.nvm/nvm.sh ]]; then
    source ~/.nvm/nvm.sh
    nvm use v0.6.6
    pwd
fi

#mvim
alias mvim='$HOME/shellscripts/mvim.sh'
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.

alias mvi="mvim --remote-tab-silent"

export PATH="$HOME/bin:$PATH"
#Enter で ls と git status を表示する
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls
    # ↓おすすめ
    # ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter
