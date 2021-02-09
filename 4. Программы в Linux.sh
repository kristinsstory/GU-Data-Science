# Урок 4
# Программы в Linux
# Права в Linux. Установка программ. Создание и запуск скриптов Python в Linux


#################################################### Права в Linux

# Информация о пользователе
whoami

# В каких группах состоит текущий пользователь
groups

# Создание пользователя
sudo useradd -m -s /bin/bash user1

# Определяем пароль для пользователя
sudo passwd user1

# Параметры будут даны пользователю после создания по умолчанию
useradd -D

# Зайдём в оболочку под другим пользователем
su user1

# Проверим
whoami

# Выйти из сессии этого пользователя
exit

# удаление пользователя
whatis userdel
userdel -- help
userdel -fr user1

#заблокировать пользователя
sudo usermod –L user1
#разблокировать пользователя
sudo usermod –U user1

# дать пользователю права суперпользователя
sudo usermod -G sudo user1

# Команда chmod
# Предоставить другим пользователям права на запись в файл header.txt
chmod o+w header.txt

# Можно менять несколько прав для ряда категорий
chmod go-rw header.txt

# Другие варианты работы с правами
chmod u+w,g+r header.txt
chmod -rw header.txt

# задание прав триадами цифр
•	0: (000) No permission.
•	1: (001) Execute permission.
•	2: (010) Write permission.
•	3: (011) Write and execute permissions.
•	4: (100) Read permission.
•	5: (101) Read and execute permissions.
•	6: (110) Read and write permissions.
•	7: (111) Read, write, and execute permissions.
chmod 770 header.txt
# флаг -R для задания рекурсивного изменения прав
chmod 777 -R ~/lesson3

# Изменяем владельца файла
sudo chown user1 header.txt

#################################################### Установка программ

# Список всех программ, установленных на данном сервере
dpkg -l

#tree – утилина для вывода структуры файлов и папок деревом
sudo apt install tree
tree

# Удалить zip
sudo apt-get remove zip

#################################################### Создание и запуск скриптов Python в Linux

# Установим pip
sudo apt install python3-pip

# Чтобы создать программу, написанную на Python, потребуется библиотека Numpy
pip3 install numpy

# Запустим python
python3

# Импортируем библиотеку Numpy с помощью команды 
import numpy as np

# Запустим команду, создающую массив из 10 чисел 
np.arange(10)

# Выйти из командной строки интерпретатора Python можно с помощью команды 
exit()

# С помощью текстового редактора vim создадим файл create_matrix.py
# Внесем в него следующую программу:

import numpy as np
a = np.arange(12)
b = a.reshape((-1, 4))
print(b)

# Запустим этот файл, используя команду 
python create_matrix.py
