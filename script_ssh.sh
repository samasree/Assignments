#!/bin/bash
x=$(whoami);        #Master's username
if [ $x == root ];   #if Master's username is root
then
    if [ ! -f /$x/.ssh/id_rsa.pub ];
    then
        ssh-keygen;
    fi
    for i in $@
    do
       ssh-copy-id -i /$x/.ssh/id_rsa.pub $x@$i;
    done
else                 #if master's username is otherthan root 
    if [ ! -f /home/$x/.ssh/id_rsa.pub ];
    then
        ssh-keygen;
    fi
    for i in $@
    do
       ssh-copy-id -i /home/$x/.ssh/id_rsa.pub $x@$i;
    done

fi                   #assume both master and client have same usernames
echo "Enter the command";
read command;
for i in $@
do 
    sudo ssh -l $x $i $command; 
done

    
