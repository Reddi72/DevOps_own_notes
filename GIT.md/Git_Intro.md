# What is VCS ?
Version Control System(or Revision control or source control ) is all about managing multiple versions of documents,programmas,websites..etc
A Version control system allows you to track the history of a collection of files.

# Centralized VCS:
In subversion,CVS,Perforce..etc. A central server repository holds the "official copy" of the code the server maintains the sole version history of the repo.
You make "checkouts" of it to ur local copy 
- u make local modifiacations
- ur changes are not versioned
when ut done u check in back to the server 
- ur checkin increments the repo's version.
# Distribute VCS:
In git,mercurial...etc  u don't "checkout" from  a central repo.
- u clone it and pull changes from it 
ur local repo is a complete copy of everything on the remote server
urs is just a good as theirs
many operations are local 
- check im/out from local repo
- commit changes to local repo
- local repo keeps version history
When ur ready u can push changes back to server.
## GIT Vcs:
- Git is a ditributed version control system
- git is Tree history storage system
- git is content tracking management system 
** Goals of GIt"
speed   
Support for non-linear development.
fully distributed 
Able to handle large projects efficently created by linus torvalds.
For collaboration/merging with Others,we can use GITHUB,Bitbucket,AWS code commit ..etc
 ## GitBash Download:
 ## Git Install #
1. Windows: Download git bash executable and install git-2.20.1-64-bit.exe
 https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-64-bit.exe

2. Debain/Ubuntu
#apt-get install git

3. Linux
#yum install git

## GIT Hub Account Creation #
Gir Repo: A GIt repo contains the history of a certain directory. The process of copying an existing git repo via git tooling is called  cloning.
A local repository provides at least one collection of files which originate from a certain version of the repo. this collection of files is called the working tree.
# Git Repo Creation #
New-->Create a new repository-->Repository name(Practise)-->Description(This repo for practice)--->Tik on Private-->tik on Add a README file-->Create.

Go to Gitbash and clone this repo
$git clone https://github.com/reddiprasad72/Practise.git
here ask ur credentials beacause of this private repo
userid:Reddiprasad72  and Pwd: Pras@1993

Now ur repo is cloned
$cd practise
$cat .git/config 
--> here u can see ur url
$ touch file1
$ git add file1
$ git status
On branch main
Your branch is up to date with 'origin/main'.
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   file1
$ git commit -m "add new file"
[main 90b378e] add new file
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file1
$ git status
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
$ git push origin main
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 4 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 269 bytes | 89.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To https://github.com/reddiprasad72/Practise.git
   a57e404..90b378e  main -> main

-- Windows can save our credentails
goto-->comd serarch-->credentails manager-->windows credentails-->here u can see github credentails.

$ vi file1
this is my first line
$ git add .
$ git commit -m "add new line into file1"
$ git log
commit ceea80c9557952048bedb9dbf43a25e04af7046c (HEAD -> main, origin/main, origin/HEAD)
Author: prasad <reddiprasd72@gmail.com>
Date:   Thu Dec 1 20:58:26 2022 +0530

    add new line in file1

commit 90b378e001bea35911938cd3dd974077f3b5a921
Author: prasad <reddiprasd72@gmail.com>
Date:   Thu Dec 1 19:47:57 2022 +0530

    add new file

commit a57e404fcebb34edd8eac4a6f95b67627b95f2ec
Author: reddiprasad72 <106003945+reddiprasad72@users.noreply.github.com>
Date:   Thu Dec 1 17:55:59 2022 +0530

    Initial commit

-------------------------
Go to -->Git hub-->practise repo-->settings-->collaborators-->Manage access-->Add people-->enter ur collaborator name-->add

$ git tag -->it shows all tags
$ git tag -a v1.5 -m "this new commit"
$ git tag --> v1.5

$  git show v1.5
tag v1.5
Tagger: prasad <reddiprasd72@gmail.com>
Date:   Thu Dec 1 21:33:46 2022 +0530

version with new feature

commit ceea80c9557952048bedb9dbf43a25e04af7046c (HEAD -> main, tag: v1.5, origin/main, origin/HEAD)
Author: prasad <reddiprasd72@gmail.com>
Date:   Thu Dec 1 20:58:26 2022 +0530

    add new line in file1

diff --git a/file1 b/file1
index e69de29..12b1255 100644
--- a/file1
+++ b/file1
@@ -0,0 +1,2 @@
+this is my new commit
+
$  git push origin v1.5
tag pushed into github account.

Go to -->github-->select repo-->main drop down-->tags--> here u can see ur tags.
if u want to create tag in github
select repo-->main drop down-->tags-->Draft a new release-->choose tag-->create new tag-->v3-->enter.

$vi file1
this is added second line
$ git add .
$ git commit -m "add new line in file1"
$git log
$git log --oneline
009b3aa (HEAD -> main, origin/main, origin/HEAD) add new lines are added
ceea80c (tag: v1.5) add new line in file1
90b378e add new file
a57e404 Initial commit

$git reset --hard ceea80c
--> here reset commit to previous commit.
$ git log --oneline
ceea80c (HEAD -> main, tag: v1.5) add new line in file1
90b378e add new file
a57e404 Initial commit

go to github-->practise-->file1-->click on pen symbole-->write "this is third"-->Commit changes-->add third line-->commit.

$ git pull -->all changes are merged in ur local repo
$ git log --oneline
$ git diff 611752c 009b3aa --> it shows diff b/w 2 comits
diff --git a/file1 b/file1
index 1826945..bdf855e 100644
--- a/file1
+++ b/file1
@@ -1,3 +1,2 @@
 this is my new commit
 this is my second line
-this is my third line

## Git Branching #
go to-->github-->practise repo-->branchs-->master-->create branch from main-->main branch create.
$ git pull
$ git branch -a
* main
  remotes/origin/Dev
  remotes/origin/HEAD -> origin/main
  remotes/origin/main
  remotes/origin/master
$ git checkout dev
Switched to a new branch 'dev'
branch 'dev' set up to track 'origin/dev'.
$ touch file{2..7}
$ ls 
README.md  file  file1  file2  file3  file4  file5  file6  file7
$ git add .
$ git commit -m "add 2-7 files"
$ git push origin dev
all files are pushed into dev branch only.

Now i want merge this data into master branch
$ git checkout master
$ git merge dev
$ git push --> all files are pushed into master
$ git checkout -b test
-->switch and create test branch

## GIt Authentcation ##
go to credentials manager in ur laptop and remove git credentials
## SSH Authentcation #
$ ssh-keygen
$cd .ssh
$ ls
id_rsa  id_rsa.pub  known_hosts  known_hosts.old
$ cat id_rsa.pub
copy this key

Go to github-->account setting-->SSH and GPG keys-->new sshkey-->Title(mylaptop)-->Key-->copy ur key here-->add ssh key-->enter ur github password.

$ ssh -T git@github.com
The authenticity of host 'github.com (20.207.73.82)' can't be established
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Hi reddiprasad72! You've successfully authenticated, but GitHub does not provide shell access.
$ cd $ rm -rf Practise/
$ git clone git@github.com:reddiprasad72/Practise.git(ssh url)
$ cd practise
$ git branches -a
$ git checkout dev
===========================================================================================================================================================================
