
# 1. Создать каталоги first и second в домашней директории, а в них — текстовые файлы first.py и second.py, содержащие программы, выводящие на экран числа 1 и 2 соответственно.

student@Ubuntu-MySQL-VirtualBox:~$ mkdir first
student@Ubuntu-MySQL-VirtualBox:~$ mkdir second

student@Ubuntu-MySQL-VirtualBox:~/first$ echo "1" > first.py
student@Ubuntu-MySQL-VirtualBox:~$ cd second
student@Ubuntu-MySQL-VirtualBox:~/second$ echo "2" > second.py
student@Ubuntu-MySQL-VirtualBox:~/second$ cat second.py

# 2. Переместите файл second.py в папку first.
student@Ubuntu-MySQL-VirtualBox:~/second$ sudo mv second.py /first

mv second/second.py first/

# 3. Удалите папку second.

student@Ubuntu-MySQL-VirtualBox:~/second$ cd
student@Ubuntu-MySQL-VirtualBox:~$ rm -r second

rm -rf second/

# 4. Переименуйте папку first в first_second.
student@Ubuntu-MySQL-VirtualBox:~$ mv first first_second

# 5. Удалите папку first_second вместе с содержимым.
student@Ubuntu-MySQL-VirtualBox:~$ rm -r first_second
rm -rf first_second
