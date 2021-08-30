#!/bin/bash
if [ -z "$1" ]
then
    echo "Missing argument"
else
    echo "Removing Project $1"
    eval "$(conda shell.bash hook)"
    conda activate base
    conda env remove --name "$1"
    jupyter kernelspec uninstall "$1"         
    gh delete "juanitoddd/$1"
    
    cd $PROJECT_PATH
fi