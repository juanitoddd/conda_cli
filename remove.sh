#!/bin/bash
if [ -z "$1" ]
then
    echo "Missing argument"
else
    PROJECTS_PATH="/home/juan/dev/python_projects"
    PROJECT_PATH="$PROJECTS_PATH/$1"
    echo "Removing Project $1"
    eval "$(conda shell.bash hook)"
    conda activate base
    conda env remove --name "$1"
    jupyter kernelspec uninstall "$1"         
    gh delete "juanitoddd/$1"
    sudo rm -r $PROJECT_PATH
    cd $PROJECT_PATH
fi