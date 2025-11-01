#3. Автоматическая сортировка файлов: Напишите скрипт, который автоматически сортирует файлы в указанной директории: 
#○ Файлы с расширениями .jpg, .png и .gif перемещает в папку Images. 
#○ Документы (.txt, .pdf, .docx) — в папку Documents. ○ Скрипт должен запускаться автоматически через cron каждую ночь и вести лог всех перемещений.

#!/bin/bash
echo "скрипт запущен"

targetdir=$1
logs="file_sort.log"

if [ -z "$targetdir" ]; then
    echo "Ошибка: необходимо указать директорию"
    exit 1
fi

mkdir -p "$targetdir/Images" "$targetdir/Documents"

for file in "$targetdir"/*; do
    if [ -f "$file" ]; then
        case "$file" in
            *.jpg|*.png|*.gif)
                mv "$file" "$targetdir/Images/"
                echo "$(date '+%Y-%m-%d %H:%M:%S') — Перемещён в Images: $(basename "$file")" >> "$logs"
                ;;
            *.txt|*.pdf|*.docx)
                mv "$file" "$targetdir/Documents/"
                echo "$(date '+%Y-%m-%d %H:%M:%S') — Перемещён в Documents: $(basename "$file")" >> "$logs"
                ;;
        esac
    fi
done

echo "Файлы отсортированы. Лог записан в $logs"

#вывод:
#$ bash zadanie10.sh /c/Users/huawei/Desktop/Mentor\ seminar_HSE
#скрипт запущен
#Файлы отсортированы. Лог записан в file_sort.log
