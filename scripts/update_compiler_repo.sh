#!/bin/bash

# Check if the user has access to the compiler repository
git ls-remote git@github.com:FPSG-UIUC/hfa-compiler.git > /dev/null 2>&1
if [ $? -eq 0 ]
then

    # If the compiler already exits, pull it from Github
    if [ -d "src/hfa-compiler" ] && [ -e "src/hfa-compiler/.git" ]
    then
        cd src/hfa-compiler
        git pull
        cd ../..

    # If some other directory is there, remove it first before cloning the compiler
    elif [ -d "src/hfa-compiler" ]
    then
        cd src
        rmdir hfa-compiler
        git clone git@github.com:FPSG-UIUC/hfa-compiler.git
        cd ..

    # Otherwise clone the compiler
    else
        cd src
        git clone git@github.com:FPSG-UIUC/hfa-compiler.git
        cd ..
    fi

# Otherwise just create an empty directory if one is not there already
else
    if [ ! -d "src/hfa-compiler" ]
    then
        mkdir src/hfa-compiler
    fi
fi
