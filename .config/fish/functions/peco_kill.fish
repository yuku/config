function peco_kill
  ps ax -o pid,time,command | peco --query "$LBUFFER" | awk '{print $1}' | xargs kill
end
