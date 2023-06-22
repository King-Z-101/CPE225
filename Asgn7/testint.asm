# Kevin Yuan
# Zaid Serrano

.text
.global main

main:
jal initialization 
li a0, '*'
asteriskLoop:
jal printChar
b asteriskLoop