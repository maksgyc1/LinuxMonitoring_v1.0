#!/bin/bash

# Подключаем модули
source validation.sh
source system_info.sh
source print_info.sh

# Проверка параметров
validate_params "$@"

# Загружаем данные
get_system_info

# Вывод данных
print_all_info