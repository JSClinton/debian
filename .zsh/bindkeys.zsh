# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

bindkey "^K"      kill-whole-line                      # ctrl-k
bindkey "^R"      history-incremental-search-backward  # ctrl-r
bindkey "^A"      beginning-of-line                    # ctrl-a
bindkey "^[[1~"   beginning-of-line                    # beginning of line debian
bindkey "^[[H"    beginning-of-line		       # beginning of line redhat
bindkey "^E"      end-of-line                          # ctrl-e
bindkey "^[[4~"   end-of-line                          # end of line debian
bindkey "^[[F"    end-of-line			       # end of line redhat
bindkey "[B"      history-search-forward               # down arrow
bindkey "[A"      history-search-backward              # up arrow
bindkey "^D"      delete-char                          # ctrl-d
bindkey "^[[3~"   delete-char			       # delete key-redhat
bindkey "^F"      forward-char                         # ctrl-f
bindkey "^B"      backward-char                        # ctrl-b
#bindkey -v   # Default to standard vi bindings, regardless of editor string
bindkey -e   # emacs key bindings
bindkey ' ' magic-space # do history expansion on space
