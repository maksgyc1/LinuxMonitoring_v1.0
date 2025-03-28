#!/bin/bash

get_system_info() {
    HOSTNAME=$(hostname)
    TIMEZONE=$(timedatectl | grep 'Time zone' | awk '{print $3, $4, $5}')
    USER=$(whoami)
    OS=$(cat /etc/os-release | grep "PRETTY_NAME" | cut -d '=' -f2 | tr -d '"')
    DATE=$(date "+%d %b %Y %T")
    UPTIME=$(uptime -p)
    UPTIME_SEC=$(cat /proc/uptime | awk '{print int($1)}')
    IP=$(hostname -I | awk '{print $1}')
    MASK=$(ifconfig | grep -A1 "$IP" | awk '/netmask/ {print $4}')
    GATEWAY=$(ip r | grep default | awk '{print $3}')

    RAM_TOTAL=$(free -m | awk '/Память:/ {printf "%.3f", $2/1024}')
    RAM_USED=$(free -m | awk '/Память:/ {printf "%.3f", $3/1024}')
    RAM_FREE=$(free -m | awk '/Память:/ {printf "%.3f", $4/1024}')

    SPACE_ROOT=$(df / | awk 'NR==2 {printf "%.2f", $2/1024}')
    SPACE_ROOT_USED=$(df / | awk 'NR==2 {printf "%.2f", $3/1024}')
    SPACE_ROOT_FREE=$(df / | awk 'NR==2 {printf "%.2f", $4/1024}')
}
