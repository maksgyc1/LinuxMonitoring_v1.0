#!/bin/bash

# Подключаем модули
source system_info.sh
source format_output.sh
source save_to_file.sh

# Получаем данные о системе
get_system_info

# Выводим данные в форматированном виде
format_output

# Спрашиваем пользователя о сохранении данных
save_to_file