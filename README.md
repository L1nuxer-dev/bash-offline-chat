# 🗨️ Bash Offline Chat

A simple offline, terminal-based chat app built with pure Bash. It allows multiple users on the same system to communicate via a shared log file, with color-coded messages and notification sounds.

## 🚀 Features
- Color-coded messages (Green for self, Blue for others)
- Timestamped logs
- Works on all POSIX-compliant systems
- No internet or network needed — just one system and a terminal
- Lightweight and dependency-free

## 🛠️ Usage

1. Create the shared chat file (only once):
   ```bash
   touch /tmp/chat_channel.log
   chmod 666 /tmp/chat_channel.log
