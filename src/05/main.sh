#!/bin/bash

# Проверка на наличие параметра
if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_directory>"
    exit 1
fi

DIR="$1"

# Проверка, что это директория
if [ ! -d "$DIR" ]; then
    echo "The provided path is not a directory."
    exit 1
fi

# Старт отсчета времени
start_time=$(date +%s)

# Получаем общее число папок, включая вложенные
total_folders=$(find "$DIR" -type d | wc -l)

# Топ-5 папок с максимальным размером
top_folders=$(du -h "$DIR" | sort -rh | head -n 5)

# Общее число файлов
total_files=$(find "$DIR" -type f | wc -l)

# Число конфигурационных файлов (.conf), текстовых файлов, исполняемых файлов, логов (.log), архивов и символических ссылок
conf_files=$(find "$DIR" -type f -name "*.conf" | wc -l)
text_files=$(find "$DIR" -type f -name "*.txt" | wc -l)
exec_files=$(find "$DIR" -type f -executable | wc -l)
log_files=$(find "$DIR" -type f -name "*.log" | wc -l)
archive_files=$(find "$DIR" -type f -name "*.tar*" -or -name "*.zip" -or -name "*.gz" | wc -l)
symlink_files=$(find "$DIR" -type l | wc -l)


# Топ-10 файлов с максимальным размером
top_files=($(find "$DIR" -maxdepth 1 -type f | sort -rh | head -n 10))

for i in "${!top_files[@]}"; do
    size_files[$i]=$(du -ah "${top_files[$i]}" | awk '{print $1}')
    type_files[$i]="${top_files[$i]##*.}"
done

# Топ-10 исполняемых файлов с максимальным размером и их MD5-хэшами
top_exec_files=($(find "$DIR" -maxdepth 1 -type f -executable | sort -rh | head -n 10))


for i in "${!top_exec_files[@]}"; do
    size_exec_files[$i]=$(du -h "${top_exec_files[$i]}" | awk '{print $1}')
    hash_exec_files[$i]=$(md5sum "${top_exec_files[$i]}" | awk '{print $1}')
done


# Время выполнения скрипта
end_time=$(date +%s)
execution_time=$(echo "$end_time - $start_time" | bc)

# Выводим результат
echo "Total number of folders (including all nested ones) = $total_folders"
echo -e "\nTOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$top_folders" 

echo -e "\nTotal number of files = $total_files"
echo -e "\nNumber of:"
echo "Configuration files (with the .conf extension) = $conf_files"
echo "Text files = $text_files"
echo "Executable files = $exec_files"
echo "Log files (with the extension .log) = $log_files"
echo "Archive files = $archive_files"
echo "Symbolic links = $symlink_files"

echo -e "\nTOP 10 files of maximum size arranged in descending order (path, size and type):"
for i in "${!top_files[@]}"; do
    echo $((i+1))" - Размер: ${size_files[$i]}, Путь: ${top_files[$i]}, Тип: ${type_files[$i]}" 
done
echo -e "\nTOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
for i in "${!top_exec_files[@]}"; do
    echo $((i+1))" - Размер: ${size_exec_files[$i]}, Путь: ${top_exec_files[$i]}, Хеш: ${hash_exec_files[$i]}" 
done
 # size_exec_files $top_exec_files $hash_exec_files

echo -e "\nScript execution time (in seconds) = $execution_time"
