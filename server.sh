x=`cat tcpdump.txt | grep echo | grep length | grep request | cut -d'h' -f2- | cut -d'h' -f2- | tr -d ' '`

echo "Decimal: " $x

printf "$(printf '\\%03o' $x)"; echo

