#!/bin/bash
git init $BRICKDIR
if [ ! -d $BRICKDIR/.dvc ]
then
  (cd $BRICKDIR; dvc init)
fi
sleep infinity
