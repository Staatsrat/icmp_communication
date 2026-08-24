#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <netinet/ip_icmp.h>
#include <ctype.h>

unsigned short checksum(void *b, int len) {
    unsigned short *buf = b;
    unsigned int sum = 0;
    for (sum = 0; len > 1; len -= 2) sum += *buf++;
    if (len == 1) sum += *(unsigned char *)buf;
    sum = (sum >> 16) + (sum & 0xffff);
    return ~(sum + (sum >> 16));
}

int sendit(int letter) {
    int sock = socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);

    struct sockaddr_in dest = { .sin_family = AF_INET };
    inet_pton(AF_INET, "<serverip>", &dest.sin_addr);

    int target_size = letter;

    char packet[target_size];
    memset(packet, 0, target_size);

    struct icmphdr *icmp = (struct icmphdr *)packet;
    icmp->type = ICMP_ECHO;


    icmp->checksum = checksum(packet, target_size);

    sendto(sock, packet, target_size, 0, (struct sockaddr *)&dest, sizeof(dest));

    close(sock);
    printf("Send!\n");
    return 0;

}

int main() {
    char wort[] = "Hotdog";
    for (int i = 0; wort[i] != '\0'; i++) {
	sendit(wort[i]);
	usleep(100000);
    }
    return 0;
}
