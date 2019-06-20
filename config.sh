#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.06.2018
#
# Configuration file.

# ASCII
local separator
local branch_icon
local is_git_repo
local has_untracked_files
local has_changed_files
local has_added_files

separator=""
branch_icon=""
is_git_repo=""
has_git_stash=" "
has_untracked_files=" "
has_changed_files="  "
has_added_files="  "
has_unpushed_commits="  "

# Git info
local branch_name
local branch_status
local staged_files
local git_stash
local git_untracked_files
local git_changed_files
local git_has_unpushed_commits
local git_number_unpushed_commits

branch_name=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
branch_status=$(git status -s 2> /dev/null)
staged_files=$(git diff --name-only --cached 2> /dev/null)
git_stash=$(git stash list 2> /dev/null)
git_untracked_files=$(git ls-files --others --exclude-standard 2> /dev/null)
git_changed_files=$(git ls-files -m 2> /dev/null)
git_has_unpushed_commits=$(git log origin/$branch_name..HEAD 2> /dev/null)
git_number_unpushed_commits=$(git log --pretty=oneline origin/$branch_name..HEAD 2> /dev/null | wc -l)
git_number_untracked_files=$(git ls-files --others --exclude-standard 2> /dev/null | wc -w)
git_number_changed_files=$(git ls-files -m 2> /dev/null | wc -l)

# Colors
local none
local bold
local bold_none
local bg_none
local bg_light_gray
local bg_dark_gray
local bg_dark_gray_01
local bg_dark_gray_02
local bg_dark_gray_03
local bg_light_yellow
local bg_white
local bg_blue
local bg_yellow
local bg_light_magenta
local dark_gray
local blue
local black
local white
local yellow
local light_gray
local light_yellow
local light_magenta
local light_green
local light_red
local cyan

none="\\[\\e[39m\\]"
bold="\\[\\e[1m\\]"
bold_none="\\[\\e[0m\\]"
bg_none="\\[\\e[49m\\]"
bg_light_gray="\\[\\e[47m\\]"
bg_dark_gray="\\[\\e[100m\\]"
bg_dark_gray_01="\\[\\e[48;5;234m\\]"
bg_dark_gray_02="\\[\\e[48;5;236m\\]"
bg_dark_gray_03="\\[\\e[48;5;239m\\]"
dark_gray_01="\\[\\e[38;5;234m\\]"
dark_gray_02="\\[\\e[30;5;236m\\]"
dark_gray_03="\\[\\e[30;5;239m\\]"
bg_light_yellow="\\[\\e[103m\\]"
bg_yellow="\\[\\e[43m\\]"
bg_light_green="\\[\\e[102m\\]"
bg_white="\\[\\e[107m\\]"
bg_blue="\\[\\e[44m\\]"
bg_light_magenta="\\[\\e[105m\\]"
dark_gray="\\[\\e[90m\\]"
light_gray="\\[\\e[37m\\]"
blue="\\[\\e[34m\\]"
black="\\[\\e[30m\\]"
white="\\[\\e[97m\\]"
yellow="\\[\\e[33m\\]"
red="\\[\\e[31m\\]"
light_yellow="\\[\\e[93m\\]"
light_magenta="\\[\\e[95m\\]"
light_green="\\[\\e[92m\\]"
light_red="\\[\\e[91m\\]"
cyan="\\[\\e[36m\\]"

# Separator styles
local s_darkgray_bglightmagenta
local s_darkgray_bgblue
local s_lightmagenta_bgblue
local s_darkgray_bgdarkgray01
local s_lightmagenta_bgnone
local s_blue_bglightyellow
local s_darkgray01_bglightyellow
local s_blue_bglightgreen
local s_darkgray01_bglightgreen
local s_blue_bgwhite
local s_darkgray01_bgwhite
local s_lightgray_bgwhite
local s_white_bglightgray
local s_dark_gray_bgnone
local s_lightyellow
local s_yellow
local s_green
local s_white
local s_blue
local s_darkgray01
local s_darkgray01_bgdarkgray
local s_darkgray_bglightgreen
local s_darkgray_bglightyellow
local s_darkgray
local s_lightgray_bgyellow

s_lightmagenta_bgblue="${light_magenta}${bg_blue}${separator}${bg_none}${none}"
s_lightmagenta_bgdarkgray="${light_magenta}${bg_dark_gray}${separator}${bg_none}${none}"
s_lightmagenta_bgnone="${light_magenta}${bg_none}${separator}${bg_none}${none}"
s_blue_bglightyellow="${blue}${bg_light_yellow}${separator}${bg_none}${none}${bg_none}"
s_blue_bglightgreen="${blue}${bg_light_green}${separator}${bg_none}${none}${bg_none}"
s_blue_bgwhite="${blue}${bg_white}${separator}${bg_none}${none}${bg_none}"
s_lightyellow="${light_yellow}${separator}${none}"
s_yellow="${yellow}${separator}${none}"
s_green="${light_green}${separator}${none}"
s_white="${white}${separator}${none}"
s_blue="${blue}${separator}${none}"
# s_blue_bgdarkgray="${blue}${bg_dark_gray}${separator}${none}"
s_lightgray="${light_gray}${separator}${none}"
s_darkgray="${dark_gray}${separator}${none}"
s_dark_gray_bgnone="${dark_gray}${separator}${none}${bg_none}"
s_darkgray_bglightmagenta="${dark_gray}${bg_light_magenta}${separator}${bg_none}${none}"
s_darkgray_bgblue="${dark_gray}${bg_blue}${separator}${bg_blue}${none}"
s_darkgray_bgdarkgray01="${dark_gray}${bg_dark_gray_01}${separator}${bg_none}${none}"
s_darkgray_bglightyellow="${dark_gray}${bg_light_yellow}${separator}${bg_none}${none}${bg_none}"
s_darkgray_bglightgreen="${dark_gray}${bg_light_green}${separator}${bg_none}${none}${bg_none}"
s_darkgray_bgwhite="${dark_gray}${bg_white}${separator}${bg_none}${none}${bg_none}"
s_darkgray01_bglightyellow="${dark_gray_01}${bg_light_yellow}${separator}${bg_none}${none}${bg_none}"
s_darkgray01_bglightgreen="${dark_gray_01}${bg_light_green}${separator}${bg_none}${none}${bg_none}"
s_darkgray01_bgwhite="${dark_gray_01}${bg_white}${separator}${bg_none}${none}${bg_none}"
s_lightgray_bgwhite="${light_gray}${bg_white}${separator}${bg_none}${none}${bg_none}"
s_lightgray_bglightyellow="${light_gray}${bg_light_yellow}${separator}${bg_none}${none}${bg_none}"
s_lightgray_bglightgreen="${light_gray}${bg_light_green}${separator}${bg_none}${none}${bg_none}"
s_white_bglightgray="${white}${bg_light_gray}${separator}${bg_none}${none}${bg_none}"
s_darkgray01="${dark_gray_01}${separator}${none}"
s_darkgray01_bgdarkgray="${dark_gray_01}${bg_dark_gray}${separator}${bg_none}${none}"