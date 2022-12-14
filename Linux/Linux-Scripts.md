# vi add.sh
#!/bin/bash
#source /home/ec2-user/new.sh
echo "enter first number";
read a
echo "enter second name";
read b
x=$( expr "$a" + "$b")
echo sum = $x

# vi  array_reading.sh
#!/bin/bash
echo -v "enter array values: "
read -a my_arrayy
echo "the given array is: ${my_arrayy[@]}"

# vi arthamatic_scrpit.sh
#!/bin/bash
x=2
y=4
echo addition of $x and $y is:  $(($x+$y))
echo substraction of $x and $y is: $(($x-$y))
echo multiplication of $x and $y is:  $(($x*$y))
echo division of $x and $y is: $(($x/$y))

# vi automate_httpd_actions.sh
#!/bin/bash
#auhor : prasad
# automating httpd actions like ; start stop restart status
user_id = $(id -u)

<< comm1
[[ $user_id -eq 0 ]] && echo " you are root user so u can run this shell script" || echo " you are not the root user to run this shell script "
comm1

<< comm2
if [[ $user_id -eq 0 ]]
then
        echo " you are root user so u can run this shell script"
else
        echo " you are  not root user to  run this shell script"
fi
comm2

<< comm3
if [[ $user_id -ne 0 ]]
then
        echo " you are  not root user to  run this shell script"
fi
comm3

read -p " enter your action for  httpd: " user_action

if [[ $user_action == "start" ]]
then
        echo "starting httpd......."
        systemctl status httpd &> /dev/null || systemctl start httpd
fi

if [[ $user_action == "stop" ]]
then
        echo "stoping httpd......."
        systemctl status httpd &> /dev/null && systemctl stop httpd
fi

if [[ $user_action == "restart" ]]
then
        echo "restarting httpd......."
        systemctl status httpd &> /dev/null || systemctl restart httpd
fi

if [[ $user_action == "status" ]]
        then
        echo "restarting httpd......."
        systemctl status httpd
fi

#  vi automate_httpd_action.sh
#!/bin/bash
#auhor : prasad
# automating httpd actions like ; start stop restart status
<< comm1
user_id = $(id -u)
[[ $user_id -eq 0 ]] && echo " you are root user so u can run this shell script" || echo " you are not the root user to run this shell script "
comm1

<< comm2
if [[ $user_id -eq 0 ]]
then
        echo " you are root user so u can run this shell script"
else
        echo " you are  not root user to  run this shell script"
fi
comm2

if [[ $user_id -ne 0 ]]
then
         echo " you are  not root user to  run this shell script"
fi


read -p " enter your action for  httpd: " user_action
#user_action=$1

<< comm4
if [[ $user_action == "start" ]]
then
        echo "starting httpd......."
        systemctl status httpd &> /dev/null || systemctl start httpd
fi

if [[ $user_action == "stop" ]]
then
        echo "stoping httpd......."
        systemctl status httpd &> /dev/null || systemctl stop httpd
fi

if [[ $user_action == "restart" ]]
fi

if [[ $user_action == "restart" ]]
then
        echo "restarting httpd......."
        systemctl status httpd &> /dev/null || systemctl restart httpd
fi

if [[ $user_action == "status" ]]
        then
        echo "status of  httpd......."
        systemctl status httpd
fi
comm4

<< comm5
if [[ $user_action == "start" ]]
then
         echo "starting httpd......."
        systemctl status httpd &> /dev/null || systemctl start httpd
elif [[ $user_action == "stop" ]]
then
         echo "stoping httpd......."
        systemctl status httpd &> /dev/null && systemctl stop httpd
elif [[ $user_action == "restart" ]]
then
         echo "restarting httpd......."
         systemctl restart httpd
elif [[ $user_action == "status" ]]
then
         echo "getting status of httpd......."
         systemctl status  httpd
 else
         echo "your action is invalid "
         echo " valid actions are start|stop|restart|status"

fi
comm5

 echo "your action is invalid "
         echo " valid actions are start|stop|restart|status"
case $user_action in

        start)
                 echo "starting httpd......."
                 systemctl status httpd &> /dev/null || systemctl start httpd
                 ;;
         stop)
                 echo "stoping httpd......."
                 systemctl status httpd &> /dev/null && systemctl stop httpd
                 ;;
        restart)
                echo "restarting httpd......."
                systemctl restart  httpd
                ;;
        status)
                echo "finding the status"
                systemctl status httpd
                ;;
        *)
                 echo "your action is invalid "
                 echo " valid actions are start|stop|restart|status"
 esac
# vi backup.sh
#!/bin/bash

tar -cvzf my_backup pras
# vi basic_forloop.sh
#!/bin/bash

#for each_value in 1 2 3
        for each_file in $(ls)
do
        echo "this is loop: $each_file"
done
echo "u have different ways to use for loop/this one type of loop script"
# vi break.sh
#!/bin/bash
<< comm1
for each in $(seq 1 10)
do
        if [[ $each -gt 5 ]]
        then
                break
        fi
        echo "$each"
done
comm1

<< comm2
for each in $(seq 1 10)
do
        if [[ $each -ne 5 ]]
        then
                echo "$each"
        fi
done
comm2

for each in $(seq 1 10)
do
        if [[ $each -eq 5 ]]
        then
                continue
        fi
        echo "$each"
done
echo "for loop is over"
# vi center_with_printf.sh
#!/bin/bash
title="PrAsAd ReDdI"
COLUMNS=$(tput cols)
title_size=${#title}
span=$((($COLUMNS + $title_size) / 2))
printf "%${COLUMNS}s" " " | tr " " "*"
printf "%${span}s\n" "$title"
printf "%${COLUMNS}s" " " | tr " " "*"
# vi check_excute_permissions.sh
#!/bin/bash
 echo " checking file excute permissions........."

# [[ -x  install_multiple_packages.sh   ]] && echo "this file have excute permissions" || echo "this file  haven't excute permissions"


<< comm
if [[ -x  install_multiple_packages.sh  ]]
then
         echo "this file have excute permissions"
 else
          echo "this file  haven't excute permissions"
fi

for each in install_multiple_packages.sh  handle_cmndline_arguments_with_for_loop.sh
do
        if [[ -x $each ]]
        then
                 echo "this file have excute permissions"
         else
                 echo "this file  haven't excute permissions"
        fi
done
comm

<< comm2
for each in $(ls)
        do
        if [[ -x $each ]]
        then
                 echo "this file have excute permissions"
         else
                 echo "this file  haven't excute permissions"
        fi
done
comm2

given_path=$1
for each in $(ls $given_path)
        do
        if [[ -x $each ]]
 then
                 echo "this file have excute permissions"
         else
                 echo "this file  haven't excute permissions"
        fi
done
# vi clr.sh
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
echo -e "\033[1;91mprasad reddi"
echo -e "\033[1;92mprasad reddi"
echo -e "\033[1;93mprasad reddi"
echo -e "\033[1;94mprasad reddi"
echo -e "\033[1;95mprasad reddi"
echo -e "\033[1;96mprasad reddi"
echo -e "\033[1;97mprasad reddi"

echo -e "\033[1;100mprasad reddi"
echo -e "\033[1;101mprasad reddi"
echo -e "\033[1;102mprasad reddi"
echo -e "\033[1;103mprasad reddi"
echo -e "\033[1;104mprasad reddi"
echo -e "\033[1;105mprasad reddi"
echo -e "\033[1;106mprasad reddi"
echo -e "\033[1;107mprasad reddi"

echo -e "\033[0mprasad reddi"
exit
# vi cmnd_line_arugments.sh
#!/bin/bash
echo "$1"
echo "$2"
echo "$3"
echo "${10}"
echo "the number command line arguments are:$#"
echo "all the command line arguments are:$@"
echo "all the command line arguments are:$*"
# vi c_type_fileloop.sh
#!/bin/bash
clear
echo " we working with c language loop script"
for ((cnt=1;cnt<=10;cnt++))
do
#echo "this is c type for loop"
echo "$cnt"
done
echo "we are complete the loop"
echo "cnt means count"
# vi diff_and.sh
#!/bin/bash
echo "the below output is for \$*"
for each in "$*"
do
        echo $each
done

echo "the below output is for \$@"
for each in "$@"
do
        echo $each
done

<< comm
when run this script
./diff_$@and$* 1 2 3 a b c
result;
the below output is for $*
1 2 3 a b c
the below output is for &@
1
2
3
a
b
c
 if your remove the "" of $@ and $* then run this
         ./diff_$@and$* 1 2 3 a b c
the below output is for &*
1
2
3
a
b
c
the below output is for &@
1
2
3
a
b
c
comm
# vi diply.sh
#!/bin/bash
#ls
<< comm1
for each_file in $(ls)
do
        echo "$each_file"
done
comm1

<< comm2
for each_file in $(ls *.txt)
do
        echo "$each_file"
done
comm2

<< comm3
cnt=1
for each_file in $(ls)
do
        if [[ $cnt -eq 1 ]]
        then
        echo "$each_file"
        (( cnt++ ))
        fi

done
comm3

echo "starting for loop"
cnt=1
for each_file in $((ls))
do
        if [[ $cnt -eq 1 ]]
        then
                echo "$each_file"
                break
        fi
done
echo "for loop is over"
# vi div.sh
#!/bin/bash
echo "enter first number";
read a
echo "enter seond number";
read b
echo answer = $(expr $a / $b)
# vi echo.sh
#!/bin/bash
echo -e " this is a first line \n this is second line "
echo -n "this is one more line"
echo "this is second line"
echo -e " this is a first line \b this is sec line "
echo -e " this is a first line \t this is fourt line "
echo -e " this is a first line \v this is second line "
echo -e " this is a first line \a this is second line "
echo -e " this is a first line \r this is second line "
echo -e " this is a first line \c this is second line "
echo -e " this is a first line \\ this is second line "
# vi ex2.sh
#!/bin/bash
pwd
ls
date
awk 'BEGIN {print "hi"}'

awk 'BEGIN{print"==========working on /etc/passwd file======="} /prasad/{print $0}END {print "=========completed work on /etc/passwd file====="}' /etc/passwd
# vi ex.awk
#echo /root/scripts | awk -F root -v x=9 '{print $2}'
 awk 'BEGIN {print "hi"}'
# vi file.sh
#!/bin/bash
echo " what is your first name"
read a
echo "what is your second name"
read b
echo "thanks for saying your name $a$b"
echo " are u miss me say yes or no"
read c
if  [ $c == "yes" ]
then
        echo " miss you too "
else
        echo " good bye"
fi
# vi function_arthamatic_calculator.sh
#!/bin/bash
<< comm1
mycode()
{
read -p "enter your first number:" num1
read -p "enter your second number:" num2
}
comm1
clear
echo "welcome to arthamatic calculator"
echo -e  "[1]addition\n[2]substraction\n[3]multiplictin\n[4]division\n"
read -p "enter your choice: " choice
case $choice in
        [1])
                read -p "enter your first number:" num1
                read -p "enter your second number:" num2
                result=$((num1 + num2))
                echo "the result for your choice is: $result"
                ;;
        [2])
                read -p "enter your first number:" num1
                read -p "enter your second number:" num2
                result=$((num1 - num2))
                echo "the result for your choice is: $result"
                ;;
        [3])
                 read -p "enter your first number:" num1
                  read -p "enter your second number:" num2
                result=$((num1 * num2))
                echo "the result for your choice is: $result"
                ;;
        [4])
                   read -p "enter your first number:" num1
                   read -p "enter your second number:" num2
                   result=$((num1 / num2))
                   echo "the result for your choice is: $result"
          ;;
        *)
                echo "wrong coice"
                ;;
esac
# vi handle_cmndline_arguments_with_for_loop.sh
#!/bin/bash
#author;prasad
#purpose;installing multiple pkgs
#write ur package with ./handle_cmndline_arguments_with_for_loop.sh
#exmple="handle_cmndline_arguments_with_for_loop.sh hhtpd"

if [[ $# -eq 0 ]]
then
        echo "usage: $0 pkg1 pkg2....."
        exit 1
fi


if [[ $(id -u) -ne 0 ]]
then
        echo "please run from root user or with sudo previlage"
        exit 2
fi

for each_pkg in $@
do
        if which $each_pkg &>/dev/null
        then
                echo "alredy $each_pkg is installed"
        else
                echo "installing $each_pkg....."
                yum install $each_pkg -y &>/dev/null

                if [[ $? -eq 0 ]]
                then
                        echo "successfully installed  $each_pkg pkg"
                else
                        echo "unable to insatll  $each_pkg "
                fi
        fi
done

echo "write a package name with script"
# vi htpd.sh
#!/bin/bash
read -p " enter your action for httpd: " user_action
if [[ $user_action == "start" ]]
then
         echo "starting httpd......."
        systemctl status httpd &> /dev/null || systemctl start httpd
elif [[ $user_action == "stop" ]]
then
         echo "stoping httpd......."
        systemctl status httpd &> /dev/null && systemctl stop httpd
elif [[ $user_action == "restart" ]]
then
         echo "restarting httpd......."
         systemctl restart httpd
elif [[ $user_action == "status" ]]
then
         echo "getting status of httpd......."
         systemctl status  httpd
fi
# vi httpd2.sh
#!/bin/bash
httpd -v
systemctl status httpd
cat /etc/httpd/conf/httpd.conf | grep ^Listen

# vi httpd3.sh
httpd_v=$(httpd -v 2>&1 | awk -F  '/' 'NR==1{print $2}' | awk '{print $1}')
httpd_s=$(systemctl status httpd |grep Active | awk '{print $2}')
httpd_p=$(cat /etc/httpd/conf/httpd.conf | grep ^Listen | awk '{print $2}')
echo "the httpd version is: $httpd_v"
echo "the current status of httpd is: $httpd_s"
echo "the port for httpd is: $httpd_p"

# vi httpd_version.sh
#!/bin/bash
#practice on &&,||,if, and ifelse statements on to verify httpd is installed or not, if it is installed then find version............
#author: prasad
#finding httpd version
<< comm
which httpd && echo " httpd is installed on this host "
which httpd &>/dev/null && echo " httpd is installed on this host "
if which httpd &>/dev/null
        then
                 echo " httpd is installed on this host "
fi

which httpd &>/dev/null
httpd_status=$?
if
        [[ httpd_statu -eq 0 ]]
then
        echo " httpd is installed on this host "
fi
comm

which httpd &>/dev/null && httpd -v|awk -F '[ /]' '/version/ {print $4}' && echo " httpd is installed on this host " || echo " httpd is not installed "

if which httpd &>/dev/null
        then
                 echo " httpd is installed on this host "
                  httpd -v|awk -F '[ /]' '/version/ {print $4}'
         else
                 echo " httpd is not installed  on this host "
fi

which httpd &>/dev/null
httpd_status=$?
if
        [[ httpd_statu -eq 0 ]]
then
        echo " httpd is installed on this host "
         httpd -v|awk -F '[ /]' '/version/ {print $4}'
else
         echo " httpd is not installed  on this host "

fi
# vi IFS_whileloop.
#!/bin/bash

<< comm1
while read line
do
        echo "$line"

done < file.sh
comm1

<< comm2
while read f1 f2 f3 f4 f5
do
        echo "$f2 $f3"
done < file.sh
echo ".................."
echo " above space taken as a field separarator"
comm2

<< comm3
while IFS="," read f1 f2 f3 f4 f5
do
        echo "$f2"
done < file1
echo ".................."
echo " above ,  taken as a field separarator"
comm3

 cat file1 | awk 'NR=1 {print}'| while IFS="," read f1 f2
do
        echo " $f1 $f2 "
done
# vi infinity_loop.sh
#!/bin/bash
echo "this is a for loop"
for ((;;))
do
        echo "this is infinity loop"
        ((cnt++))
        sleep 1
        if [[ $cnt -eq 5 ]]
        then
                break
        fi
done
echo "out of loop"
# vi infinity_whileloop.sh
#!/bin/bash
<< comm1
while true
do
        echo " hi "
        echo "........"
done
comm1

<< comm2
while :
do
        echo " hi "
        echo "........"
done
comm2

<< comm3
while "date"
do
        echo "excuteing date command by while loop "
        echo "........"
done
comm3

<< comm4
start=1
while [[ $start -le 10 ]]
do
        echo "$start"
              (( start++))
done
comm4

file_name="file.sh"
while read each_line
do
        echo "$each_line"
done <$file_name
# vi install_any_tomcat_v
#!/bin/bash
#req_tom_ver=$1
read -p" required tomacat version: " req_tom_ver
tom_main_ver=$(echo $req_tom_ver|cut -c 1)
url="https://dlcdn.apache.org/tomcat/tomcat-${tom_main_ver}/v${req_tom_ver}/bin/apache-tomcat-${req_tom_ver}.tar.gz"
wget $url
tar -xvzf apache-tomcat-${req_tom_ver}.tar.gz
mv apache-tomcat-${req_tom_ver} tomcat ${tom_main_ver}
rm -rf apache-tomcat-${req_tom_ver}.tar.gz
# vi install_multiple_packages.sh
#!/bin/bash
#Author; prasad
#purpose;install multiple packages

<< comm1
if [[ $(id -u) -ne 0 ]]
then
        echo "please run from root user or with root previlage"
        exit 1
fi

if which vim &>/dev/null
then
        echo "alredy vim is installed"
else
        echo "installing vim....."
        yum install vim -y &>/dev/null
if [[ $? -eq 0 ]]
then
        echo "sucessfully installed vim pkg"
else
        echo "unable to install vim pkg"
fi
fi
comm1

echo "by useing loop installing multiple packages"

for each_pkg in vim httpd nginx
do if which $each_pkg &>/dev/null
then
        echo "already $each_pkg is instlled"
else
        echo "installing $each_pkg........."
        yum install  $each_pkg -y &>/dev/null
        if [[ $? -eq 0 ]]
then
        echo "sucessfully installed $each_pkg pkg"
else
        echo "unable to install $each_pkg pkg"
fi
fi
done
# vi install_tomcat.sh
#!/bin/bash
req_tom_ver="8.5.78"
tom_main_ver=$(echo $req_tom_ver|cut -c 1)
url=https://mirrors.estointernet.in/apache/tomcat/tomcat-${tom_main_ver}/v${req_tom_ver}/bin/apache-tomcat-${req_tom_ver}.tar.gz
https://dlcdn.apache.org/tomcat/tomcat-${tom_main_ver}/v${req_tom_ver}/bin/apache-tomcat-${req_tom_ver}.tar.gz
wget $url
tar -xvzf apache-tomcat-${req_tom_ver}.tar.gz
mv apache-tomcat-${req_tom_ver} tomcat ${tom_main_ver}
rm -rf apache-tomcat-${req_tom_ver}.tar.gz

# vi join_paths.sh
#!/bin/bash
path1="/etc/httpd/conf"
path2="/usr/local/bin"

join_path=${path1}/${path2}
echo "${join_path}"

echo="convert strings into lower/upper"
my_name="shell"
my_name_up=${my_name^^}
my_name_lo=${my_name,,}
echo "upper data: $my_name_up"
echo "lower data: $my_name_lo"
echo "$my_name"

httpd_conf_path_line="/etc/httpd/conf/httpd.conf"
httpd_conf_home=$(dirname $httpd_conf_path_line)
httpd_conf_line=$(basename $httpd_conf_path_line)
echo "httpd conf path line:$httpd_conf_path_line"
echo "httpd conf home: $httpd_conf_home"
echo "httpd conf line: $httpd_conf_line"
~
# vi maths.sh
#! /bin/bash
clear
sum=0
i="y"

echo " Enter one no."
read n1
echo "Enter second no."
read n2
while [ $i = "y" ]
do
echo "1.Addition"
echo "2.Subtraction"
echo "3.Multiplication"
echo "4.Division"
echo "Enter your choice"
read ch
case $ch in
    1)sum=`expr $n1 + $n2`
     echo "Sum ="$sum;;
        2)sum=`expr $n1 - $n2`
     echo "Sub = "$sum;;
    3)sum=`expr $n1 \* $n2`
     echo "Mul = "$sum;;
    4)sum=`expr $n1 / $n2`
     echo "Div = "$sum;;
    *)echo "Invalid choice";;
esac
echo "Do u want to continue (y/n)) ?"
read i
if [ $i != "y" ]
then
    exit
fi
done
# vi mult.sh
#!/bin/bash
echo "enter first number";
read a
echo "enter second number";
read b
echo "answer = $(expr $a \* $b)"

# vi passing_parameters.sh
#!/bin/bash

echo "the \$0 value is : script name is $0"

addition ()
{
        m=$1
        n=$2
        result=$((m+n))
        echo "the addition of $m and $n is: $result"
}
x=6
y=2
addition $x $y

p=3
q=7
addition $p $q

addition  9 99
# vi printf_prasad.sh
#!/bin/bash
echo ".............................."
echo "prasad"
echo "............................."
# vi read_array_by_loop.sh
#!/bin/bash
my_array=(1 4 3 "love" 45)
for each in ${my_array[*]}
do
        echo "${each}"
done
# vi read_value_awk.sh#!/bin/bash
read -p "enter a value: " a
read -p "enter b value: " b
echo "$a $b" | awk '{x=$1;y=$2; print "x=" x "y=" y}'
# vi send_auto_mail_alert.sh
#!/bin/bash
#shell script to send automatic mail alert whrn ram memory gets low
TO="ammananna1216@gmail.com"
TH_L=450
free_RAM=$( free -mt | grep -e "Total" | awk '{print $4}')

if [[ $free_RAM -lt $TH_L ]]
then
        echo -e "server is running with low ram size\navailable RAM is:  $free_RAM" | mail "Ram Info $(date)" $TO
fi
# vi simple_function.sh
#!/bin/bash
read_inputs()
{
echo " enter your first number";
read a
echo " enter your second number";
read b
}
addition()
{
sum=$((a + b ))
echo "the addition of $a and $b is: $sum"
}
substaction()
{
sub=$((a - b))
echo "the substraction of $a and $b is: $sub"
}
read_inputs
addition
substaction
# vi starthttpd.sh
#!/bin/bash
systemctl start httpd
# vi stophttpd.sh
#!/bin/bash
systemctl stop httpd
# vi sub.sh
#!/bin/bash
echo "enter first number";
read a
echo "enter second number";
read b
x=$(expr "$a" - "$b")
echo $a - $b=$x
# vi valaxy_case.sh
#!/bin/bash
read -p "enter any character: " num
case $num in
        [0-9])
                echo "you entered single number"
                ;;
        [a-z])
                echo "you entered lower case alph"
                ;;
        [A-Z])
                echo "you entered upper case alph"
                ;;
        *)
                echo "unable to indentity"
esac
# vi valaxy_maths.sh
#!/bin/bash
clear
read -p "enter your first number:" a
read -p "enter your second number:" b
echo "1.add"
echo "2.sub"
echo "3.mul"
echo "4.div"
read -p "please select your option from above menu:" opt
case $opt in
           1)
                   echo "your selected addition"
                   echo "the addition of $a and $b is: $((a+b))"
                   ;;
           2)
                   echo "your selected sub"
                   echo "the sub of $a and $b is: $((a-b))"
                   ;;
           3)
                   echo "your selected mul"
                   echo "the mul of $a and $b is: $((a*b))"
                   ;;
           4)
                   echo "your selected div"
                   echo "the div of $a and $b is: $((a/b))"
                   ;;
           *)
                   echo "you selected invalid option"
                   ;;
   esac
# vi valaxysimple2_if.sh
#!/bin/bash

#if [[ 4 -eq 4 ]]
#then
#       echo "they are equal"
#       echo " those are 4 and 4"
#fi

#if  [[ !4 -eq 4 ]]
#then
 #       echo "they are equal"
 #      echo " those are 4 and 4"
#fi


if [[ 4 -gt 5 ]]
then
        echo " we are comparing 4 and 5"
        echo " 4 is gt 5 "
else
        echo " we are are comparig 4 and 5 "
        echo " 4 is not gt 5 "
fi

# vi valaxysimple_if.sh
#!/bin/bash
if which httpd &> /dev/null
then
        echo "httpd is present on this host"
        systemctl status httpd
        echo " now starting httpd"
        sudo systemctl start httpd
fi
# vi valaxysum.sh
#!/bin/bash
<< mycom1
x=10
y=65
#((sum=$x+$y))
#echo "the addition of $x and $y is; $sum"
#((div=y/x))
#echo $div
#bc<<<"scale=2;$y/$x"
result=$(bc<<<"scale=3;$y/$x")
echo "division of $y and $x is= $result"
mycom1
read -p "enter your first number;" a
read -p "enter your second number;" b
#((sum=a+b))
#echo $sum
sum=$(bc<<<"scale=3;$a+$b")
echo " the addition of $a and $b is;$sum"
# vi var.sh
#!/bin/bash
x=23
y=56
my_name="prasad"
x2=87
echo "$x"
echo "$y"
echo "$my_name"
echo "$x2"
========================================================
