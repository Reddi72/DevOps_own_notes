###  Scripting ###
# SHELL:
a program that interprets the commands you type in your terminal and passes them on the operating system
# bash: Bourne again shell
# Adavantages of Bash shell :
It's feature rich
It's fast
It's very common use shell
# Shell script; a shell script is a file containing commands for the shell
#!/bin/bash  --> shebang line:
 after the hash bank part comes to the interpreter that is used to read our file since were writing scripts
# Bash scripts have  3 core compnents
 1. Shebang line:
 2. Commands:
 3. Exit Statement:
./ --> means in this directory and if a script is obviously the file that  we want to run

1. the HOME and USER variables tell you about the user who is logged in
2. the HOSTNAME and HOSTTYPE variables tell you about the computer they are using

Examples:

#echo $HOME  --> here shows /root

#echo $HOSTTYPE --> here shows x86_64 (  HOSTTYPE variable tells u what type of proccer architecture the computer running)

#echo $HOSTNAME --> here shows "ip-172-31-11-242.ec2.internal"

#echo $PS1--> [\u@\h \W]\$      (ps1 variables contains the prompt string shown in the terminal before each command )
If #PS1="Prasad"
 your giving like this then it will be show the Prasad instead of prompt
              Prasad:ls -> it shows the list of files

#name="PRASAD"                                           
$ echo $name --> PRASAD
Let’s say that we wanted to convert the first letter of my name to lower case
#echo ${name,}--> pRASAD
#echo ${name,,}-->prasad

#name="prasad"
#echo $name  -----> prasad
-- let's say that we want to first letter Captial 
#echo ${name^}---> Prasad
---> all letters converted into captials 
#echo ${name^^}---> PRASAD
## we want see how character in word ##
#name="prasad"
#echo ${#name} --> here shows 6 letters in ur name
## Numbers ##
#numbers=0123456789
#echo ${numbers:0:7} --> 0123456 [it  shows from 0 to 7  numbers]
#echo ${numbers:1:5} -->it shows 1 after 5 numbers
#echo ${numbers:3} --> it shows 3456789
#echo ${numbers:  -3:2} --> 78    [it shows last from 3number 2 characters from the backside]
#echo ${numbers: -3} --->789[it shows last three numbers]
========================================================
## Basic calculator(bc) ##
#echo "2+3"|bc ---> it shows 5
#echo "2-3"|bc  --> it shows -1
#echo "6/3"|bc --> it shows 2
#echo "5/2"|bc --> it shows 2 (aprx value)
#echo "scale=2;5/2"|bc --> it shows 2.50 (it scale 2 measn after . shows 2 digits)
#echo "4/3"|bc ---> it shows 1 (aprx value)
#echo "4*3"|bc  --> it shows 12
#echo "4*34544"|bc --> it shows 138176
#echo "4*34544+454-485/2"|bc ---> it shows 138388
#echo "4*34544.66"|bc ---> 138178.64
=========================================================
## Arthamatic Script ##
#vi arthamatic.sh
#!/bin/bash
x=2
y=4
echo addition of $x and $y is:  $(($x+$y))
echo substraction of $x and $y is: $(($x-$y))
echo multiplication of $x and $y is:  $(($x*$y))
echo division of $x and $y is: $(($x/$y))

#chmod +x arthamatic.sh
#./arthamatic.sh
---> it shows like this
addition of 2 and 4 is: 6
substraction of 2 and 4 is: -2
multiplication of 2 and 4 is: 8
division of 2 and 4 is: 0
=========================================
#echo {1..5} ---> it shows 1 2 3 4 5
#echo {1..100..3} --> it shows 1 4 7 10 13 16 19 22 25 28 31 34 37 40 43 46 49 52 55 58 61 64 67 70 73 76 79 82 85 88 91 94 97 100
#echo {A..Z} --> it shows A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
#echo file{1.5} --> it will create 5 files at a time
#echo month{1..12} --> it shows month1 month2 month3 month4 month5 month6 month7 month8 month9 month10 month11 month12
=========================================================
### SHELL SCRIPTING #####
SHELL SCRIPTING is a sequence of system commands passed in a text file..
## Example :: we want know httpd,httpd version,port  number
1. Step1= get all  manual commands
2. Step2=writing shell scripting
   1. Open a text file with extension as .sh ( here .sh not mandatory ,,we are providing that extension  just to know that is a shell script)
   2. Write first shebang line #!/bin/bash..( shebang line is by using which shell you want to run  your script )
3. Step3: excuting shell script
   1.	Providing execution permission using “ chmod +x filename” or “chmod 755 filename”
    2.	Run with   ./ or sh file name or with complete path /home/root/filename 
    3.	Assume that your in different location and ur script is another location then if u want run ur script …then  u have to provide complete path ur script..ex= /home/ec2-user/filename
    4.	If  u want run ur script with out execution permisssions  cmnd; sh filename or bash filename

# which httpd  --> /usr/sbin/httpd
# httpd –v --> Server version: Apache/2.4.53 ()
Server built:   Apr 12 2022 12:00:44
#cat /etc/httpd/conf/httpd.conf | grep ^Listen --> Listen 80
# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:httpd.service(8)
 
 ****These topic repeated in my work why should I type these commands again and again…instead of these  I will  write scripting………


# vi httpd.sh
#!/bin/bash

which httpd
echo "============================================="
httpd -v
echo "============================================="
systemctl status httpd

# chmod +x httpd.sh
# ./httpd.sh
  here shows
  /usr/sbin/httpd
============
Server version: Apache/2.4.53 ()
Server built:   Apr 12 2022 12:00:44
=============
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:httpd.service(8)

HERE i need only vesrion and port number and status only
# vi httpd.sh
# !/bin/bash
httpd_v=$(httpd -v 2>&1 | awk -F  '/' 'NR==1{print $2}' | awk '{print $1}')
httpd_s=$(systemctl status httpd |grep Active | awk '{print $2}')
httpd_p=$(cat /etc/httpd/conf/httpd.conf | grep ^Listen | awk '{print $2}')
echo "the httpd version is: $httpd_v"
echo "the current status of httpd is: $httpd_s"
echo "the port for httpd is: $httpd_p"
# ./httpd.sh
the httpd version is: 2.4.53
the current status of httpd is: inactive
the port for httpd is: 80
========================================================
# echo $SHELL 
/bin/bash
# whatis pwd
pwd (1)              - print name of current/working directory
pwd (1p)             - return working directory name
# whatis mkdir
mkdir (1)            - make directories
mkdir (1p)           - make directories
mkdir (2)            - create a directory
mkdir (3p)           - make a directory
===================================================
## REDIRECTION OPERATORS & STANADARD INPUT(stdin) & STANDARD OUTPUT(stdout) & STANDARD ERROR (stderr) ##
*by default input is being with the keyboard and output /error are displaying on the screen
*sometimes you will want to output of a command into a file
 ## OUTPUT Redirections operators ::=>
" > "is to create a new file
# ls >file1

“ >> “ is  to append the data
# ls –lrt >>file1

## INPUT Redirections::
" < " is to provide the input ---> 
# cat < file1
Combining Redirection Operators => to send the standard output of one command to another command as standard input
# ls –lrt|awk '{print $1}'
 -->here only shows the first line of ls –lrt
drwxr--r--
drwxr-xr-x
drwxr-xr-x
-rw-r--r--
-rw-r--r—
# ls -ltr|awk '{print $1}'|grep d
drwxr--r--
drwxr-xr-x
drwxr-xr-x
drwxr-xr-x

## How To Separate STDOUT and STDIN and STDERR ##
0 : STDIN   1 : STDOUT   2 : STDERR
# ls 1>success.txt
meaning for this store only success output result into that file
# ls 2>error.txt
 meaning for this store only success input result into that file
# ls 1>success.txt  2>error.txt
--> here my intension is ls will give success output then stored into a success.txt   if ls will give error input then stored into error.txt
=====================================================
# ECHO :
is one of the most basic and frequently used command in linux
Echo used to:  disply message 
               Disply command output
               Disply variable name
Exmples:::	              
# echo Prasad 
Prasad
# x=4
# echo $x 
 4
# echo $(date) 
---> Wed May 18 13:15:59 UTC 2022
=======================================================

## BLACK SLASH \ separator
1.	\b--> this option created new line from where is it is used
 Ex "-$ echo -e "this is a first line \b this is second line
this is a first line this is second line
2.	\n --> this option used to remove one space back from where it is used 
Ex- echo -e "this is a first line \n this is second line"
this is a first line
 this is second line
3.	\t --> used to create horizontal tab space
Ex: echo -e "this is a first line \t this is second line"
this is a first line     this is second line
4.	\v --> used to create vertical tab space
Ex: echo -e "this is a first line \v this is second line"
this is a first line
                      this is second line
5.	\a --> used to create a sound alert
Ex: echo -e "this is a first line \a this is second line" this is a first line  this is second line
6.	\r--> used to carriage return
Ex: echo -e "this is a first line \r this is second line"--> this is second line
7.	\c--> used to suppress any further output
Ex: echo -e "this is a first line \c this is second line"
this is a first line [ec2-user@ip-172-31-11-242 ~]$
8.	\\--> used to escape or eliminate the special purpose of ur  escaped  character
ex: echo -e "this is a first line \\ this is second line"
this is a first line \ this is second line
=====================================================
## echo with clour ##

Reset                        Bold with colour
Colour off= “\033[0m”        Instead of 0 here give 1
Black = “\033[0;30m”         Black = “\033[1;30m”
Red = “\033[0;31m”           Red = “\033[1;31m”
Green = “\033[0;32m”         Green = “\033[1;32m”
Yellow = “\033[0;33m”        Yellow = “\033[1;33m”
Blue = “\033[0;34m”          Blue = “\033[1;34m”
Purple = “\033[0;35m”        Purple = “\033[1;35m”
Cyan = “\033[0;36m”          Cyan = “\033[1;36m”
White = “\033[0;37m”         White = “\033[1;37m”

Colour with underline         
 Instead of 0 here give 4       
Black = “\033[4;30m”          
Red = “\033[4;31m”            
Green = “\033[4;32m”          
Yellow = “\033[4;33m”          
Blue = “\033[4;34m”           
Purple = “\033[4;35m”          
Cyan = “\033[4;36m”             
White = “\033[4;37m”             
======================================================
Background clr      High intencity clr 
Black = “\033[40m”  Black = “\033[90m”
Red = “\033[41m”    Red = “\033[91m”
Green = “\033[42m”  Green = “\033[92m”
Yellow = “\033[43m” Yellow = “\033[93m”
Blue = “\033[44m”    Blue = “\033[94m”
Purple = “\033[45m”  Purple = “\033[95m”
Cyan = “\033[46m”    Cyan = “\033[96m”
White = “\033[47m”   White = “\033[97m”

Bold and high intensity  High intensity background
Black = “\033[1;90m”     Black = “\033[0;100m”
Red = “\033[1;91m”       Red = “\033[0;101m”
Green = “\033[1;92m”     Green = “\033[0;102m”
Yellow = “\033[1;93m”    Yelow = “\033[0;103m”
Blue = “\033[1;94m”      Blue = “\033[0;104m”
Purple = “\033[1;95m”    Puple = “\033[0;105m”
Cyan = “\033[1;96m”      Cyan = “\033[0;106m”
White = “\033[1;97m”     White = “\033[0;107m”
========================================================
Reset= 0   Bold =1  Under line =4    Inverse = 7  
Bold off = 21  Underline off = 24    Invesre off = 27

# Vi clr.sh
#!/bin/bash
echo "welcome clr script"
echo -e "\033[omprasad reddi"
echo -e "\033[0;30mprasad reddi"
echo -e "\033[0;31mprasad reddi"
echo -e "\033[0;32mprasad reddi"
echo -e "\033[0;33mprasad reddi"
echo -e "\033[0;34mprasad reddi"
echo -e "\033[0;35mprasad reddi"
echo -e "\033[0;36mprasad reddi"
echo -e "\033[0;37mprasad reddi"

echo -e "\033[1;30mprasad reddi"
echo -e "\033[1;31mprasad reddi"
echo -e "\033[1;32mprasad reddi"
echo -e "\033[1;33mprasad reddi"
echo -e "\033[1;34mprasad reddi"
echo -e "\033[1;35mprasad reddi"
echo -e "\033[1;36mprasad reddi"
echo -e "\033[1;37mprasad reddi"

echo -e "\033[4;30mprasad reddi"
echo -e "\033[4;31mprasad reddi"
echo -e "\033[4;32mprasad reddi"
echo -e "\033[4;33mprasad reddi"
echo -e "\033[4;34mprasad reddi"
echo -e "\033[4;35mprasad reddi"
echo -e "\033[4;36mprasad reddi"
echo -e "\033[4;37mprasad reddi"

echo -e "\033[24;30mprasad reddi\033[0m"

echo -e "\033[40mprasad reddi"
echo -e "\033[41mprasad reddi"
echo -e "\033[42mprasad reddi"
echo -e "\033[43mprasad reddi"
echo -e "\033[44mprasad reddi"
echo -e "\033[45mprasad reddi"
echo -e "\033[46mprasad reddi"
echo -e "\033[47mprasad reddi"

echo -e "\033[0mprasad reddi"

echo -e "\033[90mprasad reddi"
echo -e "\033[92mprasad reddi"
echo -e "\033[93mprasad reddi"
echo -e "\033[94mprasad reddi"
echo -e "\033[95mprasad reddi"
echo -e "\033[96mprasad reddi"
echo -e "\033[97mprasad reddi"

echo -e "\033[1;90mprasad reddi"
exit

# the exit status of a command:=>
Each linux commands returns a status when it is excuted we can disply the exit status of a command with  
# echo  $? 
0 exit status means the command was successful without any errors
1-255	on zero values)  exit status means command was failure
1--> Command failed
2--> incorrect command usage ..etc
127 --->command not found
=========================================================
#ls      -->command success so code is 0 shows 
   # echo $? --> 0
#lss   --> -bash: lss: command not found   
# echo $? --> 127
#ls –xyz  --> ls: invalid option -- 'y'   
  # echo $? --> 2
#cat scripts --> Is a directory  
#echo $? --> 1
========================================================
If you want excute a shell script from another shell script ……
1. both shell scripts are in same path you will source ./ scriptname (or) . ./ script name
# !/bin/bash
. ./sub.sh                
((((( this another sub.sh script we inserted in add.sh script)))))
echo "enter first number";
read a
echo "enter second name";
read b
x=$( expr "$a" + "$b")
echo sum = $x
====================================================
2. if both scripts are in different paths then u will give complete path --> source /home/ec2-user/script name [example] (or) . /home/ec2-user/script name [example]
# vi add
#!/bin/bash
source /home/ec2-user/new.sh   --> ((( this is complte path of new.sh script))))
echo "enter first number";     --> ((((in add script we are insert new.sh script)))
read a
echo "enter second name";
read b
x=$( expr "$a" + "$b")
echo sum = $x
======================================================
# VARIABLES:-  variables plays an important role in any program/script language

1.system defined variables  like date,calnder…etc ( cmnd=env --> shows the system variables)
2.user defined variables  (which variables given by us)                                                                                                               Variables are used to store data/value
Define /declare a variable
# x=2 
( don’t provide space on either side of = symbol
To read variable use echo $x or echo “$x” or echo “{$x}”
# y=5.6    $ m=shell     $ n=”reddi Prasad”(when you are data having some spaces than use quotations)

# vi Vi variable.sh
#!/bin/bash
x=56
y=78.4
my_name="reddi Prasad"
X2=67
echo "$x"
echo "$y"
echo "$my_name"
echo "x2"
======================================================
# GREP Command:  is a filter command,it is used to search a string in given file
Syntx=> grep [options]”string/pattern” file

# grep Prasad file1
Reddi Prasad
Prasad is very good boy
# grep "Prasad" file1|grep Reddi
Reddi Prasad
# grep -i "prasad" file1 
(-i to ignore case for match/search))
Reddi Prasad
Prasad is very good boy
my name is prasad
# grep -w "prasad" file1
( -w to matching whole word)
my name is prasad
#  grep -v "prasad" file1
( -v  to print the lines which are not having given string/text)
file1
httpd.sh
Reddi Prasad
Prasad is very good boy
kuncham learns devops
# grep -o "prasad" file1    
( -o to print /disply only matched words )
Prasad
# grep -n "prasad" file1     ( -n to disply the matched line numbers)
2:reddi Prasad
# grep -c "prasad" file1  ( -c  to disply matched number of lines)
1
# grep -A1 "prasad" file1    ( -A1 to disply lines after match)
reddi prasad is gud boy
# grep -B1 "prasad" file1    ( B1 to disply lines lines before match)
reddi prasad is gud boy
# grep -C1 "prasad" file1    (( -C1  to disply lines around match)
reddi prasad is gud boy
# grep -r "bash" *   (( -r to disply under current directory & it’s sub directories))
# grep -l "file1" *   (( -l to disply only file names))
file1
# vi abc --> prasad  devops

# grep -f abc file1  (-f takes searching string/pattern from a file ,one per line))
reddi prasad is gud boy
Prasad learns devops

# grep -e "prasad" -e "shell" file1 (( -e to search multiple strings/patterns)
reddi prasad is gud boy
shell scripting is very task when u learn properly

# grep -E "prasad" -e "shell" file1 (( -E to search multiple strings/patterns)
reddi prasad is gud boy
shell scripting is very task when u learn properly

# grep ^reddi file1  (^reddi means disply the lines which starting with reddi)
reddi prasad is gud boy

# grep boy$ file1 (( boy$ to disply which line ends with boy))
reddi prasad is gud boy

# grep ^$ file1 --> ( disply the empty lines)
# grep .a file1  (.  Matches the any charcter))
reddi prasad is gud boy
Prasad learns devops

?--> the preceding charcter will be matches one time
*--> the preceding charcter will be matches one or more time
+ --> the preceding charcter will be matches one or more time

[abc]--> Matches a/b/c
[a-c]--> matches a/b/c
[a-ds-z]-->  matches the a-z letters
[^abc]--> matches the lines which are not starting with a/b/c
^[abc] --> matches the lines which are starting with a/b/c

 [[:alunm:]]---> matches the alphbates and numbers
[[:alpha:]]---> matches the alphbates
[[:blank:]] --->matches the blank spaces
[[:digit:]]--->matches the numbers
[[:lower:]]--->atches the lower case letters
[[:space:]]--->matches the space tab,new line,vertical tab
[[:upper:]] -->matches the  upper case letters
























