paydayday=6
d=$(date +%d)
d=${d#0}
if [[ $d -gt $paydayday ]]; then
  payday=$(date +%s -d "$(date +%Y)-$(($(date +%m) + 1))-$paydayday")
else
  payday=$(date +%s -d "$(date +%Y-%m)-$paydayday")
fi
days_til_payday=$(((payday - $(date +%s))/86400 + 1))

output="$days_til_payday days until payday!"
( command -v fortune > /dev/null ) && output="$output\n$(fortune -s)"

if ( command -v lolcat > /dev/null ); then
  echo $output | lolcat
else
  echo $output
fi
