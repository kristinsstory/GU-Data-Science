### 1. Выбрать из домашней директории пользователя ubuntu файлы с расширением 
# .py, название которых начинается на букву t.
ls ~/t*.py
ls ~ | grep '^t.*\.py$'
find . -name "*.py" -name "t*"

student@Ubuntu-MySQL-VirtualBox:~$ ls | grep '.py$'
123.py
Hello.py
Linear.py
numbers.py
test.py


### 2. Из всех файлов с расширением .py, расположенных в домашней директории 
# пользователя ubuntu, выбрать строки, содержащие команду print, и вывести их 
# на экран.
grep print *.py
cat *.py | grep 'print'
cat *\.py | grep 'print'

grep -w 'print' --include=*.py ./
grep -r -i --include=\*.py '^print' ./

grep -r --exclude-dir='.*' print | grep '.*\.py:'


student@Ubuntu-MySQL-VirtualBox:~$ ls /home | grep -w -r "print.*.py$"
.local/lib/python3.5/site-packages/numpy/lib/user_array.py:    print(shape(ua), ua.shape)  # I have changed Numeric.py
.bash_history:echo "print new day" > test.py
.bash_history:echo "print 1234" > 123.py

### 3. Из результатов работы команды uptime выведите число дней, которое 
# система работает без перезагрузки

# Примеры решения с помощью sed 
uptime | sed 's/.*up \([0-9]\+\) days.*/\1/'

uptime | sed 's/^.* \([0-9]\+\) \+days.*/\1/'
uptime | sed 's/.*up \([^,]*\), .*/\1/'

echo "15:48:57 up 2 days,  1 user,  load average: 0.00, 0.00, 0.00" | sed 's/.*up \([0-9]\+\) days.*/\1/'

# Примеры решения с помощью awk
uptime | awk '{print $3}'

# Пример решения с помощью grep
uptime | grep -oh 'up [0-9]\+ days'
uptime | grep -oh 'up [0-9]\+ min'

student@Ubuntu-MySQL-VirtualBox:~$ uptime | awk '{print $3 $4}'
58min,
