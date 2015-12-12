PD_DAY=6

d=$(date +%d)
d=${d#0}
m=$(date +%m)
m=${m#0}
y=$(date +%y)

if [[ $d -gt $PD_DAY ]]; then
  if [[ $m -eq 12 ]]; then
    y=$((y + 1))
    m=1
  else
    m=$((m + 1))
  fi
fi

next_pd=$(date +%s -d "$y-$m-$PD_DAY")
days_til_payday=$(((next_pd - $(date +%s))/86400 + 1))

output="$days_til_payday days until payday!"
( command -v fortune > /dev/null ) && output="$output\n$(fortune -s)"

if ( command -v lolcat > /dev/null ); then
  echo $output | lolcat
else
  echo $output
fi
