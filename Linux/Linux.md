Linux® is an open source operating system (OS). An operating system is the software that directly manages a system’s hardware and resources, like CPU, memory, and storage. The OS sits between applications and hardware and makes the connections between all of your software and the physical resources that do the work.
## Why linux
it is open source
Most of the softwares are freely aviable 
More secure
cost effective 
kernel source code is availble
# SHELL 
Shell is a program it's have so many commands
Types of Shells
1. SH shell- The bourne shell
2. BASH shell- GNU Bourne-again-shell
3. CSH shell- the c shell
4. ZSH shell- Z shell
#echo $SHELL -- it shows shell name

# VARIABLE 
A variable is nothing more than a pointer to the actual data. The shell enables you to create, assign, and delete variables.
1. Name variable 
The name of a variable can contain only letters (a to z or A to Z), numbers ( 0 to 9) or the underscore character ( _).

1. Create a variable 
syntax: variable name="value"
 ex: NAME= Prasad]
2.  Removeing a variable
syntax: unset varaible name
ex: unset NAME
3. Seeing a variable
Syntax: echo $variable name
ex: echo $NAME   -- here shows u prasad name
4. Seeing System variables
 syntax: set|less

# Variable Types
When a shell is running, three main types of variables are present −

1. Local Variables − A local variable is a variable that is present within the current instance of the shell. It is not available to programs that are started by the shell. They are set at the command prompt.

2. Environment Variables − An environment variable is available to any child process of the shell. Some programs need environment variables in order to function correctly. Usually, a shell script defines only those environment variables that are needed by the programs that it runs.

3. Shell Variables − A shell variable is a special variable that is set by the shell and is required by the shell in order to function correctly. Some of these variables are environment variables whereas others are local variables.

#Local variable: That variable only aviable to that programmer only
ex: v=100
#Global variable: it is avialable for all programmes
ex: EXPORT v=100

# SHELL CHARACTERSTICS
1. COMMAND SEPARATOR: ;
Ex: echo hello;date  -- here shows hello and today date
2. COMMAND SUBSTUTIOON: ` `
Ex: echo today is `date` -- here shows "today is Tue Oct 18 16:23:25 UTC 2022"
3. ESCAPING AND QUTOING: " and ' and /

# COMMANDS
1. Builtin commands[shell commands]-- shell itself understand and react it self
2. External commands: kernal handle it.kernal convert to shell understand launguge

## Commands 
1. ls -a 
 It will give you the whole list of a directory including the hidden files also.hidden files start with a dot (.) 
2. ls -la
 you want your files to be displayed in a long list format, then you can use ls -l command.
 Here, as you can see the list in long list format.

Columns above indicate specific things:

Column 1 indicates information regarding file permission.
Column 2 indicates the number of links to the file.
Column 3 & 4 indicates the owner and group information.
Column 5 indicayes size of the file in bytes.
Column 6 shows th date and time on which the file was recently modified.
Column 7 shows the file or directory name.
3. ls -l --block-size=[SIZE]  
 If you want to display the file size of your list in a particular format or size
 a. ls -l --block-size=M  -- it shows mb size
 K = Kilobyte
 M = Megabyte
 G = Gigabyte
 T = Terabyte
 P = Petabyte
 E = Exabyte
 Z = Zettabyte
 Y = Yottabyte
4. ls -d */
 If you only want to display the sub-directories excluding all other files, you can use this command.
5. ls -g
 If you don't want to display the owner information in your list, then you can exclude this column with the help of this command.
6. ls --color=[VALUE]
This command is used to colorize and decolorize the list. If you replace the [VALUE] by 'auto', it will display the colored list. But, if you will replace the [VALUE] by 'never', it will decolorize the list.
7. ls --color=never and ls --color=auto  
8. ls ~
 Linux ls ~ command shows the contents of the home directory. Let us see the example of ls ~ command.
9. ls ../
 ommand, we have listed out the content of its parent directory "home directory".
10. mkdir <dirname>
 I have made a directory 'created' by passing command "mkdir created".
11. rmdir <dirname>
 This command is used to delete a directory
12. rmdir -p
 This command will delete a directory including its sub-directories all at once
13. mv Old_folder New_folder 
 the mv command is used to move files, but we can also rename the folders and directories by it
14. find . -depth -type d -name "New_folder"
The above command will locate the directory from the file system. If you don't remember the exact directory name, you can type the matching directory name.
15. pwd Command
The pwd command is used to display the location of the current working directory.
16. touch Command
The touch command is used to create empty files. We can create multiple empty files by executing it once.
17. cat Command
for create a file, display content of the file, copy the content of one file to another file, and more.
18. rm Command
The rm command is used to remove a file.
19. cp Command
The cp command is used to copy a file or directory.
20. mv Command
The mv command is used to move a file or a directory form one location to another location.
21. rename Command
The rename command is used to rename files. It is useful for renaming a large group of files.
Syntax:rename 's/old-name/new-name/' files
22. head Command
The head command is used to display the content of a file. It displays the first 10 lines of a file.
23. tail Command
The tail command is similar to the head command. The difference between both commands is that it displays the last ten lines of the file content. It is useful for reading the error message.
Syntax:tail <file name>  
24. tac Command
The tac command is the reverse of cat command, as its name specified. It displays the file content in reverse order (from the last line).
Syntax:tac <file name> 
25. more command
The more command is quite similar to the cat command, as it is used to display the file content in the same way that the cat command does. The only difference between both commands is that, in case of larger files, the more command displays screenful output at a time.

ENTER key: To scroll down page by line.
Space bar: To move to the next page.
b key: To move to the previous page.
/ key: To search the string.
Syntax: more <file name>  
26. less Command
The less command is similar to the more command. It also includes some extra features such as 'adjustment in width and height of the terminal.' Comparatively, the more command cuts the output in the width of the terminal.
Syntax: less <file name>
27. su Command
The su command provides administrative access to another user. In other words, it allows access of the Linux shell to another user.
Syntax: su <user name>    
28. id Command
The id command is used to display the user ID (UID) and group ID (GID).
Syntax:id  
To find a user's specific user ID, execute the command with the '-u' option. For example. Find the user Id for the user 'javatpoint', execute the command as follows:
Ex: id -u javatpoint  
To find a specific user's GID, execute the command with the '-g' option. For example, to find the GID for the user 'javatpoint', execute the command as follows:
Ex: id -g javatpoint
To display all the different GIDs, execute the command with the '-G' option as follows:
Ex: id -G
29. 

# history -- it shows all history of previous used 
commands
#Alias-- is used for shorts names of commands
Ex: alias c=clear
now just type c for clear command
# COMMENTS -- it is starts with # 
comments are read only purpose understand the logic or under the programm they have to do
Ex: echo welcome #this is to display welocme"
 it shows only welcome

## Linux/Unix Filesystem ##
Root folder 
1. sbin: it contains system admin excuter or root user exectuble commands
2. bin: it have user executable commands
3. etc: confugartion files
4. dev: device realated files
5. boot: booting files
6. home: contains home folders
7. root: root user home folder
8. temp: contains tempory folders/files created by system & users
9. usr: it contains binaries,libraies,documents
10. proc: contains information about system process
11. lost+found: recovery
12. lib: system libraies 

# Absolute path:
which path start with root
# Relative path: 
which path is not starts with root
# symobls:
. indicates current directory
.. indicates parent directory
~ indicates home directory
- indicates quickly to move to the directory where we come from
/ indicates root directory

## creation Directory/folder
1. creating directory (mkdir)
ex: mkdir reddi
2. list of directories
ex: ls -d */ or ls -l -d */
2. deleteing directory (rmdir, rm -r)
ex: rmdir reddi or rm -rf reddi
3. renameing and moving directory (mv)
ex: mv reddi & mv reddi/ prasad/
4. copying directory (cp)
ex: cp reddi/ prasad/
5. Finding out which directory we are in (pwd)
ex: pwd
6. movieng one directory to another directory
#cd reddi
7. seeing the directry files
ex: ls reddi/

## Creation of files
1. creating directory (touch,cat,vi)
ex: touch file1 & cat file1 & vi file1
2. deleteing the file (rm)
ex: rm file1
3. rename/moving file (mv)
ex; mv file /reddi mv file1 file2
4. list out the files (ls)
ex: ls 
5. seeing the file data
ex: cat file1
6. add the data/redirecing the data to file
ex:cat > file1 and vi file

# file permissions
u-for owner(4+2+1 = 7)
it has all permissions like read(r)(4),write(w)(2),excute(x)(1)
g-for group(4+2 = 6)
it has only perimissions like read,write
o-for others(1)
it has only read permissions
# how to give file/directory permissins
#chmod ugo+rwx file1 -- giving all permissions to all users like owner,group,others
#chmod ugo-rwx file -- removing all permissions to all users
#chmod +777 file1 -- giving all permissions to all users
#chmod +42 file1 -- giving read and write permissions

## copy command
for copying the data from file palce to another place or folders
#cp file1 file2 -- file1 data copied into file2
#cp file1 file2 reddi/ - file1&2 copied into reddi dir
#cp -i file1 file2 (-i=interactive)
it means he asking u can i copy the file1 into file2 and when u yes then copy the data
#cp -b file1 file2 (-b = backup)
it means cp command creates  the backup of file1 and then copying starts
#cp -r or -R file1 file2 (-r/R = reccersivly)
it means the copy the data reccuresivly 

## moving/renameing files/directries (mv)
#mv file1 file2 - file1 rename as a file2
#mv file1 file2 reddi/ -- here file1 file2 data moves to reddi directory

## file compression or tar file creation(tar=tape archieve)
tar means keep all the files in a one file or compress the files
1. createing the tar file
ex: tar -cvf file.tar file1 file2 file3
2. extract the tar file
ex: tar -xvf file.tar
3. seeing all tar files
ex: tar tvf tfile.tar

## Link files
1. Soft link: 

