# Systemd Service: Sensor Logger

This project implements a `systemd` service in C that periodically reads data from a mock sensor device and logs it to a file with a timestamp.

It is designed to be robust, configurable, and easy to build, install, and manage on a Linux system. The mock sensor used by default is `/dev/urandom`, chosen for its universal availability on Linux systems and its ability to provide a continuous stream of random data without blocking.

## Prerequisites

To clone, build, and install this project, you will need the following tools:
- `git`
- `gcc` and `make` (typically provided by the `build-essential` package on Debian/Ubuntu)

You can install them on a Debian-based system (like Ubuntu or Raspberry Pi OS) with:
```bash
sudo apt-get update
sudo apt-get install -y build-essential git

Interactive Management Script
For easier day-to-day management of the service, an interactive Bash script is included. This script provides a simple menu to start, stop, and monitor the sensor-logger service without needing to remember the specific systemctl commands.

# How to Run

You can launch the management panel in two ways:

Using the Makefile shortcut:


make menu
By running the script directly:

## Bash :

./manage.sh

Available Options.

Once running, the script will display the current status of the service and present the following menu:

# 1. Start and Enable Service: Enables the service to start on boot and starts it immediately.

# 2. View Log in Real-Time: Shows a live feed of the log file (/tmp/sensor-logger.log). Press Ctrl+C to return to the menu.

# 3. Stop Service: Stops the running service.

# 4. View Detailed Service Status: Displays the full output of systemctl status for detailed diagnostics.

# 5. Exit: Closes the management script.
