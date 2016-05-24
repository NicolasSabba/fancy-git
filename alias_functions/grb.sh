#!/bin/bash
#
# Author:   Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:     05.24.2016
#
# BRANCH RENAMING
#
# Rename branch locally

new_branch_name=$1

git branch -m $new_branch_name
