#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <getopt.h>
#include <time.h>
#include <signal.h>
#include <errno.h>

volatile sig_atomic_t terminate_flag = 0;

void signal_handler(int signum) {
    if (signum == SIGTERM) {
        terminate_flag = 1;
    }
}

void print_usage(const char *prog_name) {
    fprintf(stderr, "Usage: %s [options]\n", prog_name);
    fprintf(stderr, "  --interval <seconds>  (default: 5)\n");
    fprintf(stderr, "  --logfile <path>      (default: /tmp/sensor-logger.log)\n");
    fprintf(stderr, "  --device <path>       (default: /dev/urandom)\n");
}
int main(int argc, char *argv[]) {
    int interval = 5;
    const char *logfile_path = "/tmp/sensor-logger.log";
    const char *device_path = "/dev/urandom";
    const char *fallback_logfile_path = "/var/tmp/sensor-logger.log";

    struct option long_options[] = {
        {"interval", required_argument, 0, 'i'},
        {"logfile",  required_argument, 0, 'l'},
        {"device",   required_argument, 0, 'd'},
        {"help",     no_argument,       0, 'h'},
        {0, 0, 0, 0}
    };

    int opt;
    while ((opt = getopt_long(argc, argv, "i:l:d:h", long_options, NULL)) != -1) {
        switch (opt) {
            case 'i': interval = atoi(optarg); break;
            case 'l': logfile_path = optarg; break;
            case 'd': device_path = optarg; break;
            case 'h': print_usage(argv[0]); return EXIT_SUCCESS;
            default: print_usage(argv[0]); return EXIT_FAILURE;
        }
    }

    struct sigaction action;
    memset(&action, 0, sizeof(struct sigaction));
    action.sa_handler = signal_handler;
    sigaction(SIGTERM, &action, NULL);

    FILE *log_fp = fopen(logfile_path, "a");
    if (log_fp == NULL) {
        log_fp = fopen(fallback_logfile_path, "a");
        if (log_fp == NULL) {
            perror("Fatal: Could not open any log file");
            return EXIT_FAILURE;
        }
    }
FILE *device_fp = fopen(device_path, "rb");
    if (device_fp == NULL) {
        perror("Fatal: Could not open sensor device");
        fclose(log_fp);
        return EXIT_FAILURE;
    }

    while (!terminate_flag) {
        unsigned char buffer[4];
        if (fread(buffer, 1, 4, device_fp) == 4) {
            char time_str[21];
            time_t now = time(NULL);
            strftime(time_str, sizeof(time_str), "%Y-%m-%dT%H:%M:%SZ", gmtime(&now));
            unsigned int value = (buffer[0] << 24) | (buffer[1] << 16) | (buffer[2] << 8) | buffer[3];
            fprintf(log_fp, "%s | 0x%08X\n", time_str, value);
            fflush(log_fp);
        }
        sleep(interval);
    }

    fprintf(log_fp, "SIGTERM received. Shutting down.\n");
    fclose(log_fp);
    fclose(device_fp);
    return EXIT_SUCCESS;
}
