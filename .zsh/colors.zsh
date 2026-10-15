autoload colors; colors

# The variables are wrapped in \%\{\%\}. This should be the case for every
# variable that does not contain space.
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
	eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
	eval PRB_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

eval PR_RESET="%{$reset_color%}"
export PR_RED PR_GREEN PR_YELLOW PR_BLUE PR_WHITE PR_BLACK
export PRB_RED PRB_GREEN PRB_YELLOW PRB_BLUE PRB_WHITE PRB_BLACK

# Clear LSCOLORS
unset LSCOLORS

# Main change, you can see directories on a dark background
#expor tLSCOLORS=gxfxcxdxbxegedabagacad

export CLICOLOR=1
export LS_COLORS='di=1;34:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=1;36:*.rpm=90:*.tar=1;31'

# Setup EXA veriables
# da = timestamp
# uu = user that's you
# gu = group that's you
# di = directory
export EXA_COLORS="da=38;5;99:uu=38;5;150:gu=38;5;151:di=38;5;31"


#FILE-TYPE: is file type like DIR (for directories) type: dircolors to check it out
#Attribute codes:
# 00=none
# 01=bold
# 04=underscore
# 05=blink
# 07=reverse
# 08=concealed
#Text color codes:
# 30=black
# 31=red
# 32=green
# 33=yellow
# 34=blue
# 35=magenta
# 36=cyan
# 37=white
#Background color codes:
# 40=black
# 41=red
# 42=green
# 43=yellow
# 44=blue
# 45=magenta
# 46=cyan
# 47=white
