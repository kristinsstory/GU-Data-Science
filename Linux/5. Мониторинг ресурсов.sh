### 1. Запустить htop и посмотреть, сколько процессоров и оперативной
# памяти есть на сервере.

# установка утилиты
sudo apt install htop
# запуск
htop

student@Ubuntu-MySQL-VirtualBox:~$ sudo apt-get install htop:
MEM 782M /1.95G;
Процессор - 1;
Tasks: 103, 222 thr; 2 running
см Скриншот 1

### 2. Найти все программы с расширением .py.
find *.py
find . -type f -name "*.py"
find ~ -maxdepth 1 -type f -name "*.py"


student@Ubuntu-MySQL-VirtualBox:~$ find *.py
Hello.py
Linear.py

### 3. * Создать и запустить программу на Python, выводящую числа от 0 до 100
# включительно.
### Запустить htop во время выполнения программы и найти выполняемую
# программу в списке процессов, используя поиск по ключевому слову python
# (использовать средства поиска htop).
python counter100.py > counter.log &

# Работа с фоновыми задачами
python counter100.py > /dev/null &
jobs
fg 1
Ctrl+Z
jobs
bg 1
jobs
python counter100.py > /dev/null &
jobs
kill -15 %2

student@Ubuntu-MySQL-VirtualBox:~$ vim numbers.py

for i in range(0, 101): 
        print(i))