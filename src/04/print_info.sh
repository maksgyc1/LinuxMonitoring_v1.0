#!/bin/bash

# Функция вывода данных
print_info() {
    echo -e "${BG_TITLE}${FG_TITLE}$1${RESET} = ${BG_VALUE}${FG_VALUE}$2${RESET}"
}

# Функция вывода всей информации
print_all_info() {
    # Проверяем, переданы ли параметры, и вызываем print_info для каждого
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

