#!/bin/bash
if [ -z "$1" ]
then
    echo "Missing argument"
else
    echo "== Creating new Project $1"\n\n
    # Git Repo Set Up
    PROJECTS_PATH="/home/juan/dev/python_projects"
    cd $PROJECTS_PATH && gh repo create "$1" --private -y    
    PROJECT_PATH="$PROJECTS_PATH/$1"    
    cd $PROJECT_PATH && echo "# $1 Project" > README.md
    echo "== Git Repo $1"\n\n

    # Conda Env
    conda create --name "$1" -y
    eval "$(conda shell.bash hook)"   
    conda activate "$1"
    
    cp "$PROJECTS_PATH/cli/requirements.txt" "$PROJECTS_PATH/$1/"
    cp "$PROJECTS_PATH/cli/.gitignore" "$PROJECTS_PATH/$1/"
    
    conda install -y --file "$PROJECTS_PATH/$1/requirements.txt" -c conda-forge
    python -m ipykernel install --user --name=$1
    echo "== Conda Enviroment $1 created"\n\n
    conda info    

    cd $PROJECT_PATH && git add .
    cd $PROJECT_PATH && git commit -am 'INITIAL commit'
    cd $PROJECT_PATH && git push -u origin master

    cd $PROJECT_PATH

fi