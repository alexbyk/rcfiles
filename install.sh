#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

echo "##############"
echo "perl stuff"
echo "##############"
cpanm Perl::Tidy Perl::Critic Dist::Zilla

echo "##############"
echo "install npm modules"
echo "##############"
#npm -g install gulp js-beautify babel eslint babel-eslint eslint-plugin-react typescript tslint typescript-formatter npm-check-updates typings

echo "##############"
echo "creating symbolic links in home directory"
echo "##############"
ln -s $SCRIPT_DIR/clang-format   ~/.clang-format
ln -s $SCRIPT_DIR/perlcriticrc   ~/.perlcriticrc
ln -s $SCRIPT_DIR/perltidyrc     ~/.perltidyrc
ln -s $SCRIPT_DIR/eslintrc       ~/.eslintrc
ln -s $SCRIPT_DIR/editorconfig  ~/.editorconfig
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s $SCRIPT_DIR/init.vim $XDG_CONFIG_HOME/nvim/init.vim

echo "##############"
echo "!!!Run 'sudo apt-get install clang-format-3.8 manually'"
echo "!!!Run 'sudo apt-get install xclip'"
echo "##############"
