# Protect Branch #
goto github-->select branch-->settings-->branches-->Branch protection rules-->add branch protrction rules-->Branch name pattern-->master-->Require a pull request before merging-->Require approvals-->2-->save.


## Project ##
## Reporistory Setup in Real world ##
1. create Private Repository
2. Create 3 branches Dev,UAT,Prod
3. Add teams members as collaborators 
4. Enable SSH based authentacation
5. Protect Prod and UAT branches
6. 1 approval need to check-in code in UAT and 2 approvals needed to check-in code on to prod 
7. Build and Deploy should be successful before check-in the code onto UAT as well as onto Prod.

1. Create 3 branches
and devlopers genarate ssh keys and share with me
then i can add ssh keys into my github account.

1. Go to-->github-->New-->Repository name-->New_Project_Practise-->tik on private-->tik on Add a README file-->Create Repository.
2. click on main drop down-->create Dev and UAT branches.
and 
-- change default branch
click on branches-->Default branch-->click on --><--  -->selcect on dev-->update.
-- Delete main branch
go to branchs-->main branch-->click on delete symbol.

3. Protect my UAT and Prod branches.
Settings-->branches-->Add branch protection rules-->Branch name pattern-->Dev-->Require a pull request before merging-->Require approvals (1)-->create.

Settings-->branches-->Add branch protection rules-->Branch name pattern-->UAT-->Require a pull request before merging-->Require approvals (1)-->create.

4. Add colalabators
repo settings-->collaborators-->add people-->himaraje@github.com-->add.
approval request send to himaraj and he wiil approve.

repo settings-->collaborators-->add people-->pradeep@github.com-->add.
approval request send to pradeep and he wiil approve.

5. Enable SSH Key Authentcation 
gitbash or putty
$ ssh-keygen
$ eval "$(ssh-agent -s)" -->start the ssh-agent in the background
$ ssh-add ~/.ssh/id_ed25519 --> Add your SSH private key to the ssh-agent
$cd .ssh
$ ls
id_rsa  id_rsa.pub  known_hosts  known_hosts.old
$ cat id_rsa.pub
copy this key

Go to github-->account setting-->SSH and GPG keys-->new sshkey-->Title(mylaptop)-->Key-->copy ur key here-->add ssh key-->enter ur github password.

## Project Modules #
Developer1: Home page
Developer2: Services
Developer3: Cars,drivers and garage
Developer4: Location and Contact us.

Develper1:
go to github-->clone the repo with ssh url.
$ git clone git@github.com:reddiprasad72/New_Project_Practise.git
$ cd New_Project_Practise/
$ ls
README.md
$ git log
commit efec835c7b9f51e306dde125c683e0a9d33f95fe (HEAD -> Dev, origin/UAT, origin/Prod, origin/HEAD, origin/Dev)
Author: reddiprasad72 <106003945+reddiprasad72@users.noreply.github.com>
Date:   Fri Dec 2 14:03:04 2022 +0530

    Initial commit
$ git status
On branch Dev
Your branch is up to date with 'origin/Dev'.

nothing to commit, working tree clean

