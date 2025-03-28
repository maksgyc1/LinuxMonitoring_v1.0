#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_directory>"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "The provided path is not a directory."
    exit 1
fi

start_time=$(date +%s)

total_folders=$(find "$DIR" -type d | wc -l)

top_folders=$(du -h "$DIR" | sort -rh | head -n 5)

total_files=$(find "$DIR" -type f | wc -l)

conf_files=$(find "$DIR" -type f -name "*.conf" | wc -l)
text_files=$(find "$DIR" -type f -name "*.txt" | wc -l)
exec_files=$(find "$DIR" -type f -executable | wc -l)
log_files=$(find "$DIR" -type f -name "*.log" | wc -l)
archive_files=$(find "$DIR" -type f -name "*.tar*" -or -name "*.zip" -or -name "*.gz" | wc -l)
symlink_files=$(find "$DIR" -type l | wc -l)

top_files=($(find "$DIR" -maxdepth 1 -type f | sort -rh | head -n 10))

for i in "${!top_files[@]}"; do
    size_files[$i]=$(du -ah "${top_files[$i]}" | awk '{print $1}')
    type_files[$i]="${top_files[$i]##*.}"
done

top_exec_files=($(find "$DIR" -maxdepth 1 -type f -executable | sort -rh | head -n 10))

for i in "${!top_exec_files[@]}"; do
    size_exec_files[$i]=$(du -h "${top_exec_files[$i]}" | awk '{print $1}')
    hash_exec_files[$i]=$(md5sum "${top_exec_files[$i]}" | awk '{print $1}')
done

end_time=$(date +%s)
execution_time=$(echo "$end_time - $start_time" | bc)

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

echo -e "\nScript execution time (in seconds) = $execution_time"
