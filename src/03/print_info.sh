#!/bin/bash

COLORS=("" "\e[47m" "\e[41m" "\e[42m" "\e[44m" "\e[45m" "\e[40m")
TEXT_COLORS=("" "\e[37m" "\e[31m" "\e[32m" "\e[34m" "\e[35m" "\e[30m")

BG_TITLE=${COLORS[$1]}
FG_TITLE=${TEXT_COLORS[$2]}
BG_VALUE=${COLORS[$3]}
FG_VALUE=${TEXT_COLORS[$4]}
RESET="\e[0m"

print_info() {
    echo -e "${BG_TITLE}${FG_TITLE}$1${RESET} = ${BG_VALUE}${FG_VALUE}$2${RESET}"
}

print_all_info() {
    print_info "HOSTNAME" "$HOSTNAME"
    print_info "TIMEZONE" "$TIMEZONE"
    print_info "USER" "$USER"
    print_info "OS" "$OS"
    print_info "DATE" "$DATE"
    print_info "UPTIME" "$UPTIME"
    print_info "UPTIME_SEC" "$UPTIME_SEC"
    print_info "IP" "$IP"
    print_info "MASK" "$MASK"
    print_info "GATEWAY" "$GATEWAY"
    print_info "RAM_TOTAL" "$RAM_TOTAL GB"
    print_info "RAM_USED" "$RAM_USED GB"
    print_info "RAM_FREE" "$RAM_FREE GB"
    print_info "SPACE_ROOT" "$SPACE_ROOT MB"
    print_info "SPACE_ROOT_USED" "$SPACE_ROOT_USED MB"
    print_info "SPACE_ROOT_FREE" "$SPACE_ROOT_FREE MB"
}
