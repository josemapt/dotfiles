#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <alloca.h>
#include <alsa/asoundlib.h>

#define BIGGER(A, B)     ((A) > (B) ? (A) : (B))

typedef int (* poll_init_handler_t)();

typedef struct {
	int fd;
	poll_init_handler_t init; /* initialize and return fd */

} poll_fd_t;

typedef struct {
	long volume;
	int  unmuted;
	long max, min;
	long oneper;
	int  has_switch;
} alsa_info_t;

static poll_fd_t pfd = { 0 };
static alsa_info_t info = { 0 };
static snd_ctl_t *ctl;
static snd_mixer_t *mixer;
static int initialized = 0;

void get_info(snd_mixer_elem_t *elem) {
	if (!initialized) {
		snd_mixer_selem_get_playback_volume_range(elem, &info.min, &info.max);
		info.has_switch = snd_mixer_selem_has_playback_switch(elem);
		info.oneper = BIGGER((info.max - info.min) / 100, 1);
		initialized = 1;
	}

	snd_mixer_selem_get_playback_volume(elem, 0, &info.volume);
	if (info.has_switch)
		snd_mixer_selem_get_playback_switch(elem, 0, &info.unmuted);
	else
		info.unmuted = 1;
}

void alsa_control(uint8_t ctlno) {
	snd_mixer_elem_t *elem = NULL;
	snd_mixer_selem_id_t *sid = NULL;

	snd_mixer_selem_id_alloca(&sid);
	snd_mixer_selem_id_set_index(sid, 0);
	snd_mixer_selem_id_set_name(sid, "Master");
	if (!(elem = snd_mixer_find_selem(mixer, sid))) {
		info.max = 1;
		return;
	}

	if (ctlno = 1)
		get_info(elem);
}

int alsa_connect() {
	if (snd_ctl_open(&ctl, "default", SND_CTL_READONLY | SND_CTL_NONBLOCK))
		return -1;

	if (snd_ctl_subscribe_events(ctl, 1)) {
		snd_ctl_close(ctl);
		return -1;
	}

	/* mixer initialization */
	if (snd_mixer_open(&mixer, 0)) {
		snd_ctl_close(ctl);
		return -1;
	}
	snd_mixer_attach(mixer, "default");
	snd_mixer_selem_register(mixer, NULL, NULL);
	snd_mixer_load(mixer);

	/* get poll fd */
	struct pollfd pfds;
	if (!snd_ctl_poll_descriptors(ctl, &pfds, 1)) {
		snd_ctl_close(ctl);
		return -1;
	}
	return pfds.fd;
}

int main() {
	if (!pfd.fd){
        pfd.fd = alsa_connect();
	    pfd.init = alsa_connect;
    }

	if (!info.volume)
		alsa_control(1);

	const char *icon = (info.unmuted) ? "墳 " : "婢 ";

    printf("%s%.0lf%%", icon, (double)info.volume / info.max * 100);

    return 0;
}