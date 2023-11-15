#!/bin/bash
#a simple shell script example
#a function
funciton sayhello()                
{
    echo "Enter Your name:"
    read name
    echo "Hello $name"
}
echo "programme starts here..."
sayhello
echo "programme ends."
