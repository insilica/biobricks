#!/usr/bin/bash
echo BRICKTOOLS check
echo CHECKING https://github.com/$GITHUB_REPOSITORY

git clone https://github.com/$GITHUB_REPOSITORY $GITHUB_REPOSITORY
cd $GITHUB_REPOSITORY
Rscript -e 'bricktools::check(".")'
echo SUCCESS!