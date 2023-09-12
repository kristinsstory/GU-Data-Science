### 1. Создать пользователя user_new и предоставить ему права на
# редактирование файла с программой, выводящей на экран Hello, world!

# редактирование файла с программой, выводящей на экран Hello, world!
sudo useradd -m -s /bin/bash user_new
sudo passwd user_new

# Можно добавить право записи для всех
sudo chmod o+w hello.py

# Можно изменить владельца файла
sudo chown user_new hello.py

# Можно добавить пользователя в группу файла
sudo usermod -aG student user_new


student@Ubuntu-MySQL-VirtualBox:~$ sudo useradd -m -d /home/user55 -s /bin/bash user55

student@Ubuntu-MySQL-VirtualBox:~$ ll /home
итого 16
drwxr-xr-x  4 root    root    4096 фев 25 14:47 ./
drwxr-xr-x 24 root    root    4096 фев 23 19:31 ../
drwxr-xr-x 23 student student 4096 фев 25 14:28 student/
drwxr-xr-x  2 user55  user55  4096 фев 25 14:47 user55/

student@Ubuntu-MySQL-VirtualBox:~$ sudo su - user55
user55@Ubuntu-MySQL-VirtualBox:~$ 
student@Ubuntu-MySQL-VirtualBox:~$ sudo su - user55
user55@Ubuntu-MySQL-VirtualBox:~$ exit
выход
student@Ubuntu-MySQL-VirtualBox:~$ sudo passwd user55
Введите новый пароль UNIX: 
Повторите ввод нового пароля UNIX: 
passwd: пароль успешно обновлён

student@Ubuntu-MySQL-VirtualBox:~$ su user55
Пароль: 
user55@Ubuntu-MySQL-VirtualBox:/home/student$ 

-rw-rw-r--  1 student student   19 фев 24 01:46 Hello.py

student@Ubuntu-MySQL-VirtualBox:~$ chmod o+w Hello.py
student@Ubuntu-MySQL-VirtualBox:~$ ls -l Hello.py
-rw-rw-rw- 1 student student 19 фев 24 01:46 Hello.py

### 2. Зайти под юзером user_new и с помощью редактора Vim поменять фразу в
# скрипте из пункта 1 на любую другую.
vim hello.py
cat hello.py


user55@Ubuntu-MySQL-VirtualBox:/home/student$ vim Hello.py
user55@Ubuntu-MySQL-VirtualBox:/home/student$ cat Hello.py
print  "Hello Python world!"

user55@Ubuntu-MySQL-VirtualBox:/home/student$ python Hello.py
Hello Python world!

# Либо права на файл можно было поменять через добавление нового юзера в суперюзер
student@Ubuntu-MySQL-VirtualBox:~$ sudo usermod -G sudo user55
[sudo] пароль для student: 
student@Ubuntu-MySQL-VirtualBox:~$ groups user55
user55 : user55 sudo


### 3.* Под юзером user_new зайти в его домашнюю директорию и создать
# программу на Python, выводящую в консоль цифры от 1 до 10 включительно с
# интервалом в 1 секунду.

su user_new
cd ~
vim numbers.py

import time
for i in range(1,11):
  time.sleep(1)
  print(i)

python numbers.py
