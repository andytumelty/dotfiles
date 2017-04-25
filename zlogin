#if [ "$(uname)" == "Darwin" ]; then
#  date_cmd="gdate"
#else
#  date_cmd="date"
#fi
#
#PD_DAY=6
#
#d=$($date_cmd +%d)
#d=${d#0}
#m=$($date_cmd +%m)
#m=${m#0}
#y=$($date_cmd +%y)
#
#if [[ $d -gt $PD_DAY ]]; then
#  if [[ $m -eq 12 ]]; then
#    y=$((y + 1))
#    m=1
#  else
#    m=$((m + 1))
#  fi
#fi
#
#next_pd=$($date_cmd +%s -d "$y-$m-$PD_DAY")
#days_til_payday=$(((next_pd - $($date_cmd +%s))/86400 + 1))
#
#output="$days_til_payday days until payday!"
#( command -v fortune > /dev/null ) && output="$output\n$(fortune -s)"
( command -v fortune > /dev/null ) && output="$(fortune -s)"

if ( command -v lolcat > /dev/null ); then
  echo $output | lolcat
else
  echo $output
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
