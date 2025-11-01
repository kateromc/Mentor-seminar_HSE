#1. Менеджер резервного копирования: Создайте скрипт, который: 
#○ Создаёт резервную копию всех файлов в указанной директории, добавляя к именам файлов текущую дату. 
#○ Поддерживает сохранение логов операций в отдельный файл и уведомляет пользователя об успешном завершении с указанием количества файлов.

#!/bin/bash
echo "скрипт запущен"

sourcedir=$1
backupdir="./backup_$(date +%Y-%m-%d_%H-%M-%S)"
logs="backup.log"

# Проверю, что директория передана
if [ -z "$sourcedir" ]; then
    echo "ошибка: нужно указать директорию для копирования"
    exit 1
fi

# Создаю директорию для бэкапа
mkdir -p "$backupdir"

# Копирую файлы
count=0
for file in "$sourcedir"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        cp "$file" "$backupdir/${filename}_$(date +%Y-%m-%d)"
        echo "$(date '+%Y-%m-%d %H:%M:%S') — Скопирован файл: $filename" >> "$logs"
        ((count++))
    fi
done

echo "резервное копирование завершено. Сохранено файлов: $count"
echo "лог записан в $logs"

#вывод:
#$ bash zadanie8.sh /c/Users/huawei/Desktop/Mentor\ seminar_HSE
#скрипт запущен
#резервное копирование завершено. Сохранено файлов: 19
#лог записан в backup.log

