x=`sudo timeout 5s tcpdump -l | grep --line-buffered echo | grep --line-buffered request | stdbuf -oL cut -d'h' -f2- | stdbuf -oL cut -d'h' -f2- | stdbuf -oL tr -d ' '::`

echo "Decimal: " $x

echo "$(printf '\\%03o' $x)"; echo

y="$(printf '\\%03o' $x)"; echo

#This function will execute every send command! 
#Only use if needed!

# echo "$y" | bash 
