#  ╔═╗╔═╗╦ ╦╦═╗╔═╗  ╔═╗╔═╗╔╗╔╔═╗╦╔═╗	- z0mbi3
#  ╔═╝╚═╗╠═╣╠╦╝║    ║  ║ ║║║║╠╣ ║║ ╦	- https://github.com/gh0stzk/dotfiles
#  ╚═╝╚═╝╩ ╩╩╚═╚═╝  ╚═╝╚═╝╝╚╝╚  ╩╚═╝	- My zsh conf

#  ┬  ┬┌─┐┬─┐┌─┐
#  └┐┌┘├─┤├┬┘└─┐
#   └┘ ┴ ┴┴└─└─┘
source ~/.zsh/catppuccin_frappe-zsh-syntax-highlighting.zsh
export VISUAL="${EDITOR}"
export EDITOR='emacs'
export TERM='kitty'
export TERMINAL='kitty'
export BROWSER='floorp'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

#Paths
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export LANG=ja_GP.UTF-8

#  ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌┐┌┌─┐┬┌┐┌┌─┐
#  │  │ │├─┤ ││  ├┤ ││││ ┬││││├┤ 
#  ┴─┘└─┘┴ ┴─┴┘  └─┘┘└┘└─┘┴┘└┘└─┘
autoload -Uz compinit

for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done

compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

#  ┬ ┬┌─┐┬┌┬┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌┬┐┌─┐
#  │││├─┤│ │ │││││ ┬   │││ │ │ └─┐
#  └┴┘┴ ┴┴ ┴ ┴┘└┘└─┘  ─┴┘└─┘ ┴ └─┘
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

#  ┬ ┬┬┌─┐┌┬┐┌─┐┬─┐┬ ┬
#  ├─┤│└─┐ │ │ │├┬┘└┬┘
#  ┴ ┴┴└─┘ ┴ └─┘┴└─ ┴ 
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000

#  ┌─┐┌─┐┬ ┬  ┌─┐┌─┐┌─┐┬    ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
#  ┌─┘└─┐├─┤  │  │ ││ ││    │ │├─┘ │ ││ ││││└─┐
#  └─┘└─┘┴ ┴  └─┘└─┘└─┘┴─┘  └─┘┴   ┴ ┴└─┘┘└┘└─┘
setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt HIST_IGNORE_DUPS	   # Do not write events to history that are duplicates of previous events
setopt HIST_FIND_NO_DUPS   # When searching history don't display results already cycled through twice
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

#  ┌┬┐┬ ┬┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┌┬┐
#   │ ├─┤├┤   ├─┘├┬┘│ ││││├─┘ │ 
#   ┴ ┴ ┴└─┘  ┴  ┴└─└─┘┴ ┴┴   ┴
function dir_icon {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "%B%F{black}%f%b"
  else
    echo "%B%F{cyan}%f%b"
  fi
}

PS1='%B%F{blue}%f%b  %B%F{magenta}%n%f%b $(dir_icon)  %B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{green}.%F{red})%f%b '

#  ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
#  ├─┘│  │ ││ ┬││││└─┐
#  ┴  ┴─┘└─┘└─┘┴┘└┘└─┘
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#  ┌─┐┬ ┬┌─┐┌┐┌┌─┐┌─┐  ┌┬┐┌─┐┬─┐┌┬┐┬┌┐┌┌─┐┬  ┌─┐  ┌┬┐┬┌┬┐┬  ┌─┐
#  │  ├─┤├─┤││││ ┬├┤    │ ├┤ ├┬┘│││││││├─┤│  └─┐   │ │ │ │  ├┤ 
#  └─┘┴ ┴┴ ┴┘└┘└─┘└─┘   ┴ └─┘┴└─┴ ┴┴┘└┘┴ ┴┴─┘└─┘   ┴ ┴ ┴ ┴─┘└─┘
function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (kitty*|alacritty*|termite*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

#  ┌─┐┬  ┬┌─┐┌─┐
#  ├─┤│  │├─┤└─┐
#  ┴ ┴┴─┘┴┴ ┴└─┘

# Watson
alias w.s='watson stop'
alias w.c='watson status'
alias w.a='watson aggregate'
alias w.v='watson start Japanese +Immersion'
alias w.l='watson start Japanese +Reading'
alias w.p='watson start Japanese +Passive'
alias w.r='watson remove -1'

#Yt-dlp
alias yd.arch='yt-dlp -P ~/Media/VisualMedia/Youtube/Software/Arch'
alias yd.hypr='yt-dlp -P ~/Media/VisualMedia/Youtube/Software/Hyprland'
alias yd.emacs='yt-dlp -P ~/Media/VisualMedia/Youtube/Software/Emacs'
alias yd.hard='yt-dlp -P ~/Media/VisualMedia/Youtube/Software/Hardware'

alias yd.ind='yt-dlp -P ~/Media/VisualMedia/Youtube/Education/Independent'
alias yd.schl='yt-dlp -P ~/Media/VisualMedia/Youtube/Education/School'
alias yd.ja='yt-dlp -P ~/Media/VisualMedia/Youtube/Education/日本語'

alias yd.eng='yt-dlp -P ~/Media/VisualMedia/Youtube/Leisure/English'
alias yd.leis='yt-dlp -P ~/Media/VisualMedia/Youtube/Leisure/アニメ'

alias yd.comp='yt-dlp -P ~/Media/VisualMedia/Youtube/Music/Composing'
alias yd.piano='yt-dlp -P ~/Media/VisualMedia/Youtube/Music/Piano'
alias yd.thry='yt-dlp -P ~/Media/VisualMedia/Youtube/Music/Theory'
alias yd.jathry='yt-dlp -P ~/Media/VisualMedia/Youtube/Music/日本音楽理論'


alias yd.japyt='yt-dlp -P ~/Media/VisualMedia/日本語のYOUTUBE'
alias yd.japyt.1h='yt-dlp -P ~/Media/VisualMedia/日本語のYOUTUBE/1h+'
alias yd='yt-dlp -P ~/Media/Downloads/yt-dlp '

alias yda='yt-dlp -x -P ~/Media/Audiobooks'
alias yda.e='yt-dlp -x P ~/Media/Audiobooks/English'
alias yda.j='yt-dlp -x P ~/Media/Audiobooks/Japanese'

alias y='yt-dlp'
alias as='--write-auto-sub'
alias ja='--sub-lang "ja.*"'
#----------------------------music-------------------------#
alias ydm.clas='yt-dlp -x -P ~/Media/Music/Classical --no-video'
alias ydm.mv='yt-dlp -x -P ~/Media/Music/MV'
alias ydm.rock='yt-dlp -x -P ~/Media/Music/Rock --no-video'
alias ydm.shoe='yt-dlp -x -P ~/Media/Music/Shoegaze --no-video'
alias ydm.ja='yt-dlp -x -P ~/Media/Music/日本の音楽 --no-video'

alias ydm.amb='yt-dlp -x -P ~/Media/Music/Noise/Ambient'
alias ydm.chill='yt-dlp -x -P ~/Media/Music/Noise/Chill'
alias ydm.nos='yt-dlp -x -P ~/Media/Music/Noise/Nostalgic'
alias ydm.rom='yt-dlp -x -P ~/Media/Music/Noise/Romanticize'
alias ydm.ind='yt-dlp -x -P ~/Media/Music/Noise/Romanticize/IndividualSongs'

alias ydm.pno='yd-dlp -P /home/safri/Media/Music/Performance/Piano'
alias ydm.perc.solo='yt-dlp -P /home/safri/Media/Music/Performance/Percussion/Solo'
alias ydm.perc.conc='yt-dlp -P /home/safri/Media/Music/Performance/Percussion/Concerto'
alias ydm.perc.ens='yt-dlp -P /home/safri/Media/Music/Performance/Percussion/SmallGroup'
alias ydm.other='yt-dlp -P /home/safri/Media/Music/Performance/Other'

# MPC
alias m='ncmpcpp'
alias tog='mpc toggle'
alias f='mpc next'
alias b='mpc prev'
alias m.ls='mpc playlist'
alias m.up='mpc update'
alias m.ra='mpc random'

alias 10='mpc volume 10'
alias 20='mpc volume 20'
alias 30='mpc volume 30'
alias 40='mpc volume 40'
alias 50='mpc volume 50'
alias 60='mpc volume 60'
alias 70='mpc volume 70'
alias 80='mpc volume 80'
alias 90='mpc volume 90'
alias 0='mpc volume 100'

alias p.ja='mpc clear; mpc load Japanese\ Music; mpc play'
alias p.clas='mpc clear; mpc load Classical; mpc play'
alias p.rock='mpc clear; mpc load Rock; mpc play'
alias p.shoe='mpc clear; mpc load Shoegaze; mpc play'

alias p.amb='mpc clear; mpc load \!\ White\ Noise; mpc play'
alias p.chill='mpc clear; mpc load \!\ Chill; mpc play'
alias p.nos='mpc clear; mpc load \!\ Nostalgic; mpc play'
alias p.rom='mpc clear; mpc load \!\ Romanticize; mpc play'
alias p.ind='mpc clear; mpc load \!\ Romanticize\ \(Individual\); mpc play'


# MPV
alias p.mv='mpv ~/Media/Music/MV --shuffle'
alias p.yd='mpv ~/Media/Yt-dlp'

alias way='killall waybar;waybar'
alias pom='tatsumato -t 60 -b 10 -l 30 -L 4'
alias e='emacs -nw'
alias n='nnn -E -H'
alias ew='emacs'
alias spot='spotifyd'
alias sub='cd /home/safri/Media/VisualMedia/アニメ/RenameThemSubs; python3 renamethemsubs.py'
alias r='ranger'

#pbpctrl
alias bat='pbpctrl show battery'
alias ncoff='pbpctrl set anc off'
alias ncon='pbpctrl set anc active'
alias ncs='pbpctrl get anc'
alias nc='pbpctrl set anc cycle-next'


# Ranger
alias r.perf='ranger ~/#/Music/Performance'
alias r.books='ranger ~/#/Books'
alias r.yt='ranger ~/#/Yt-dlp'
alias r.txtb='ranger ~/#/Textbooks'
alias r.japyt='ranger ~/#/Downloads/日本語のYOUTUBE'
alias r.japtxtb='ranger ~/#/Downloads/'
alias r.mpv='ranger ~/.config/mpv/'
alias r.temp='ranger ~/Temp'
alias r.sof='ranger ~/#/Downloads/Youtube/Software'
alias r.edu.ind='ranger ~/#/Downloads/Youtube/Education/Independent'
alias r.edu.sch='ranger ~/#/Downloads/Youtube/Education/School'
alias r.edu.jap='ranger ~/#/Downloads/Youtube/Education/日本語'
alias r.pno='ranger /home/safri/#/Music/Performance/Piano'
alias r.perc.solo='ranger /home/safri/#/Music/Performance/Percussion/Solo'
alias r.perc.conc='ranger /home/safri/#/Music/Performance/Percussion/Concerto'
alias r.perc.ens='ranger /home/safri/#/Music/Performance/Percussion/SmallGroup'
alias r.other='ranger /home/safri/#/Music/Performance/Other'

# Emacs
alias e.a='emacs -nw ~/org/agenda.org'
alias e.z='emacs -nw .zshrc'
alias e.h='emacs -nw ~/.config/hypr/hyprland.conf'
alias e.c='emacs -nw ~/org/cheatsheet.org'
alias e.k='emacs -nw ~/.config/kitty/kitty.conf'
alias e.w='emacs -nw ~/.config/waybar/config.jsonc'
alias e.n='sudo emacs -nw ~/.newsboat/urls'
alias e.s='emacs -nw ~/bin/scripts/'
alias e.y='emacs -nw ~/.config/yazi/'
alias se='sudo emacs -nw'

# Timer
alias 15m='p.amb --no-terminal & tatsumato -t 15 -k 1'
alias 30m='p.amb --no-terminal & tatsumato -t 30 -k 1'
alias 45m='p.amb --no-terminal & tatsumato -t 45 -k 1'
alias 60m='p.amb --no-terminal & tatsumato -t 60 -k 1'

# System
alias need='--needed'
alias mkd='mkdir'
alias mk='makepkg -si'
alias spac='sudo pacman'
alias pacs='sudo pacman -S'
alias pacr='sudo pacman -Rcn'
alias yays='yay -S'
alias yayr='yay -Rcn'
alias pacu='sudo pacman -Syu'

# Qutebrowser
alias qt='qutebrowser'
alias anilist='qutebrowser https://anilist.co/home'
alias shana='qutebrowser https://www.shanaproject.com/'
alias anna='qutebrowser https://annas-archive.org/'
alias tatsu='qutebrowser https://tatsumoto-ren.github.io/'
alias g='qutebrowser https://github.com/SafriXV/Personal'

# Executables
alias y='yazi'
alias tj='tjournal'
alias kit='cd Media/VisualMedia/アニメ/Subtitles/kitsunekko-downloader; python kitsunekko-downloader.py'
alias td='transmission-cli -w Media/VisualMedia/アニメ/Downloads'

alias new='newsboat'
alias s='p.amb --no-terminal & pom'
alias pno='fluidsynth & upiano'
alias blue='bluetuith'
alias kitsunekko='kitsunekko-downloader;python kitsunekko-downloader.py'
alias shizuku='adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh'
alias met='play -n -c1 synth 0.004 sine 2000 pad $(awk "BEGIN { print 60/$bpm -.004  }") repeat -'
alias amnt='simple-mtpfs --device 1 ~/android'
alias services='systemctl list-unit-files | grep enabled'

# Git
alias g.tracking='git push -u https://SafriXV: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@github.com/SafriXV/Personal tracking'
alias gu.agenda='cp ~/org/agenda.org ~/git/personal/ ; cd git/personal; git add agenda.org; git commit -m "agenda"; git push -u https://SafriXV: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@github.com/SafriXV/Personal tracking; cd'

#  ┌─┐┬ ┬┌┬┐┌─┐  ┌─┐┌┬┐┌─┐┬─┐┌┬┐
#  ├─┤│ │ │ │ │  └─┐ │ ├─┤├┬┘ │ 
#  ┴ ┴└─┘ ┴ └─┘  └─┘ ┴ ┴ ┴┴└─ ┴ 
#$HOME/.local/bin/colorscript -r
pfetch

