#!/bin/bash
if [ -z "$1" ]
then
    echo "Missing argument"
else
    echo "Creating new Project $1"
    
    # Git Repo Set Up
    PROJECTS_PATH="/home/juan/dev/python_projects"
    cd $PROJECTS_PATH && gh repo create "$1" --private -y    
    PROJECT_PATH="$PROJECTS_PATH/$1"    
    cd $PROJECT_PATH && echo "# $1 Project" > README.md

    # Conda Env
    conda create --name "$1" -y
    conda activate "$1"
    cp "$PROJECTS_PATH/cli/requirements.txt" "$PROJECTS_PATH/$1/"
    conda install -f "$PROJECTS_PATH/utils/requirements.txt"
    python -m ipykernel install --user --name=$1
    echo "Conda Enviroment $1 created"
        
    cd $PROJECT_PATH && git add .
    cd $PROJECT_PATH && git commit -am 'INITIAL commit'
    cd $PROJECT_PATH && git push -u origin master

    cd $PROJECT_PATH

fi