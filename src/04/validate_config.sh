#!/bin/bash

BG1=$1
FG1=$2
BG2=$3
FG2=$4

validate_colors() {
    if [[ "$BG1" -eq "$FG1" || "$BG2" -eq "$FG2" ]]; then
        echo "Ошибка: Цвет фона и шрифта одной из колонок совпадают. Измените настройки в config.conf и перезапустите скрипт."
        exit 1
    fi
}

