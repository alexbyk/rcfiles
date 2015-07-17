#!/bin/sh
echo "perl stuff"
cpanm Perl::Tidy Perl::Critic Dist::Zilla

echo "install npm modules"
npm -g install js-beautify babel eslint babel-eslint eslint-plugin-react react-tools

echo "creating symbolic links in home directory"
ln -s clang-format ~/.clang-format
ln -s perlcriticrc ~/.perlcriticrc
ln -s perltidyrc ~/.perltidyrc
ln -s vimrc ~/.vimrc
ln -s eslintrc ~/.eslintrc

