#!/bin/bash

source system_info.sh
source print_info.sh
source validate_config.sh

# Пути к конфигурационному файлу
CONFIG_FILE="config.conf"

# Цвета (ANSI-коды)
COLORS=( "" "\033[47m" "\033[41m" "\033[42m" "\033[44m" "\033[45m" "\033[40m" )  # Фоны
TEXT_COLORS=( "" "\033[37m" "\033[31m" "\033[32m" "\033[34m" "\033[35m" "\033[30m" )  # Текст

# Значения по умолчанию
DEFAULT_BG1=6
DEFAULT_FG1=1
DEFAULT_BG2=2
DEFAULT_FG2=4

# Функция для получения значения из конфигурационного файла или подстановки значения по умолчанию
get_config_value() {
    local key=$1
    local default_value=$2
    local value=$(grep "^$key=" "$CONFIG_FILE" 2>/dev/null | cut -d '=' -f2)

    # Если значение отсутствует, используем значение по умолчанию
    echo "${value:-$default_value}"
}

# Загружаем настройки
BG1=$(get_config_value "column1_background" "$DEFAULT_BG1")
FG1=$(get_config_value "column1_font_color" "$DEFAULT_FG1")
BG2=$(get_config_value "column2_background" "$DEFAULT_BG2")
FG2=$(get_config_value "column2_font_color" "$DEFAULT_FG2")

# Проверяем, чтобы цвета фона и текста не совпадали
validate_colors $BG1 $FG1 $BG2 $FG2 # Запуск проверки

# Параметры для фона и текста
BG_TITLE=${COLORS[$BG1]}
FG_TITLE=${TEXT_COLORS[$FG1]}
BG_VALUE=${COLORS[$BG2]}
FG_VALUE=${TEXT_COLORS[$FG2]}
RESET="\e[0m"

get_system_info

print_all_info

# Вывод данных

# Отступ перед схемой цветов
echo ""

# Таблица соответствия цветов
declare -A COLOR_NAMES
COLOR_NAMES=( [1]="white" [2]="red" [3]="green" [4]="blue" [5]="purple" [6]="black" )

# Вывод цветовой схемы
print_color_scheme() {
    local name=$1
    local value=$2
    local default_value=$3

    if [[ "$value" -eq "$default_value" ]]; then
        echo "Column $name = default (${COLOR_NAMES[$default_value]})"
    else
        echo "Column $name = $value (${COLOR_NAMES[$value]})"
    fi
}

print_color_scheme "1 background" "$BG1" "$DEFAULT_BG1"
print_color_scheme "1 font color" "$FG1" "$DEFAULT_FG1"
print_color_scheme "2 background" "$BG2" "$DEFAULT_BG2"
print_color_scheme "2 font color" "$FG2" "$DEFAULT_FG2"
