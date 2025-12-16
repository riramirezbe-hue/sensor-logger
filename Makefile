# Makefile for the systemd sensor-logger assignment

# Compiler and Flags
CC = gcc
CFLAGS = -Wall -Wextra -g -std=c11 -D_POSIX_C_SOURCE=200809L
LDFLAGS =

# Project Structure
TARGET = sensor-logger
SRC = src/main.c
BIN_DIR = /usr/local/bin
SYSTEMD_DIR = /etc/systemd/system
SERVICE_FILE = systemd/$(TARGET).service

# Default target
all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

# Removes the compiled binary
clean:
	@echo "Cleaning up project files..."
	rm -f $(TARGET)

# Installs the binary and systemd service file.
# Requires sudo privileges.
install: all
	@echo "Installing sensor-logger binary and systemd service..."
	@echo "This operation requires superuser privileges."
	sudo cp $(TARGET) $(BIN_DIR)/
	sudo cp $(SERVICE_FILE) $(SYSTEMD_DIR)/
	@echo "Reloading systemd daemon..."
	sudo systemctl daemon-reload
	@echo "Installation complete."
	@echo "Enable the service with: sudo systemctl enable --now $(TARGET).service"

# Uninstalls the binary and systemd service file.
# Requires sudo privileges.
uninstall:
	@echo "Uninstalling sensor-logger service and binary..."
	@echo "This operation requires superuser privileges."
	sudo systemctl disable --now $(TARGET).service || true
	sudo rm -f $(BIN_DIR)/$(TARGET)
	sudo rm -f $(SYSTEMD_DIR)/$(TARGET).service
	@echo "Reloading systemd daemon..."
	sudo systemctl daemon-reload
	@echo "Uninstallation complete."

# Phony targets do not represent files
.PHONY: all clean install uninstall