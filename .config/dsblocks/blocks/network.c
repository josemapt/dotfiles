#include <sys/ioctl.h>

#include <err.h>
#include <ifaddrs.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/socket.h>

#include <linux/wireless.h>

#include "../util.h"

size_t strlcpy(char *, const char *, size_t);

#define DPRINTF_S(x)
#define DPRINTF_U(x)
#define DPRINTF_D(x)


size_t
strlcpy(char *dst, const char *src, size_t dsize)
{
	const char *osrc = src;
	size_t nleft = dsize;

	/* Copy as many bytes as will fit. */
	if (nleft != 0) {
		while (--nleft != 0) {
			if ((*dst++ = *src++) == '\0')
				break;
		}
	}

	/* Not enough room in dst, add NUL and traverse rest of src. */
	if (nleft == 0) {
		if (dsize != 0)
			*dst = '\0';		/* NUL-terminate dst */
		while (*src++)
			;
	}

	return(src - osrc - 1);	/* count does not include NUL */
}


void
network(char *str) {
	struct ifaddrs *ifa, *ifas;
	struct iw_quality *max_qual, *qual;
	struct iw_statistics stats;
	struct iw_range range;
	struct iwreq wrq;
	int quality = -1;
	int level;
	int ret, fd;

	if (getifaddrs(&ifas) < 0) {
		warn("getifaddrs");
		snprintf(str, BLOCKLENGTH, "E");
	}
	fd = socket(PF_INET, SOCK_DGRAM, 0);
	if (fd == -1) {
		warn("socket");
		snprintf(str, BLOCKLENGTH, "E");
	}
	for (ifa = ifas; ifa != NULL; ifa = ifa->ifa_next) {
		DPRINTF_S(ifa->ifa_name);
		memset(&wrq, 0, sizeof(wrq));
		strlcpy(wrq.ifr_name, ifa->ifa_name, IFNAMSIZ);
		ret = ioctl(fd, SIOCGIWNAME, &wrq);
		if (ret != 0)
			continue;
		memset(&wrq, 0, sizeof(wrq));
		strlcpy(wrq.ifr_name, ifa->ifa_name, IFNAMSIZ);
		wrq.u.data.pointer = &range;
		wrq.u.data.length = sizeof(range);
		memset(&range, 0, sizeof(range));
		ret = ioctl(fd, SIOCGIWRANGE, &wrq);
		if (ret < 0) {
			warnx("cannot get wifi range");
			continue;
		}
		memset(&wrq, 0, sizeof(wrq));
		strlcpy(wrq.ifr_name, ifa->ifa_name, IFNAMSIZ);
		wrq.u.data.pointer = &stats;
		wrq.u.data.length = sizeof(stats);
		wrq.u.data.flags = 1;
		memset(&stats, 0, sizeof(stats));
		ret = ioctl(fd, SIOCGIWSTATS, &wrq);
		if (ret < 0) {
			warnx("cannot get wifi stats");
			continue;
		}
		max_qual = &range.max_qual;
		qual = &stats.qual;
		DPRINTF_U(max_qual->qual);
		DPRINTF_U(max_qual->level);
		DPRINTF_U(qual->qual);
		DPRINTF_U(qual->level);
		if (max_qual->qual != 0) {
			/* driver provides a quality metric */
			quality = (((float)qual->qual / max_qual->qual) * 100);
		} else if (max_qual->level != 0) {
			/* driver provides signal strength (RSSI) */
			quality = (((float)qual->level / max_qual->level) * 100);
		} else if (max_qual->level == 0) {
			/* driver provides absolute dBm values */
			level = qual->level - 0x100;
			if (level <= -100)
				quality = 0;
			else if (level >= -50)
				quality = 100;
			else
				quality = 2 * (level + 100);
		}
		break;
	}
	close(fd);
	freeifaddrs(ifas);

	DPRINTF_D(quality);
	if (quality == -1)
		snprintf(str, BLOCKLENGTH, "E");
	

	char *icon;

	if (quality == 100)
		icon = "";
	else if (quality >= 75)
		icon = "";
	else if (quality >= 50)
		icon = "";
	else if (quality >= 25)
		icon = "";
	else
		icon = "睊 ";

    snprintf(str, BLOCKLENGTH, COL3 "%s", icon);
}

void
network_c() {
    cspawn((char *[]){ "/usr/local/bin/st", "-ig", "20x8-0+0", "watch", "-t", "iwconfig wlo1 | awk '{print $2 $3}'" , NULL });
}