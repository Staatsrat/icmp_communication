#!/bin/bash
sudo tcpdump -l -n -i any icmp and icmp[icmptype] == icmp-echo 2>/dev/null | awk '
match($0, /length ([0-9]+)/, a) {
    l = a[1]; if (l == 64) next;
    if (l >= 32 && l <= 126) {
        c = sprintf("%c", l);
        if (c != "*") m = m c;
        else {
            print m;
            if (substr(m, length(m)-1) == "+x") {
                msg_clean = substr(m, 1, length(m)-2);
                #Command execution if +x Be aware!
	            	#system(msg_clean);
            }
            m = "";
        }
    }
}'

