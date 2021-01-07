#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    FILE *fp;
    int capacity;
	char status[12];
    char* prefix = "E";

	char* icons[11] = {"", "", "", "", "", "", "", "", "", "", ""};
	char* char_icons[11] = {"", "", "", "", "", "", "", "", "", "", ""};

    if ((fp = fopen("/sys/class/power_supply/BAT0/capacity","r")) == NULL){
        printf("Battery capacity file not found");

        // Program exits if the file pointer returns NULL.
        exit(1);
    }

    fscanf(fp,"%d", &capacity);
    fclose(fp);

	if ((fp = fopen("/sys/class/power_supply/BAT0/status","r")) == NULL){
        printf("Battery status file not found");
        exit(1);
    }

	fscanf(fp,"%s", &status);
    fclose(fp);

	if (status[0] == 'D'){
		prefix = icons[(capacity /10)];
	} else{
		prefix = char_icons[(capacity /10)];
	}


    printf("%s %d%%", prefix, capacity);
    return 0;
}