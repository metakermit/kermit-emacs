#!/bin/bash

# backup old confs (if they exist)
loc=~/old-emacs-settings/
echo Moving old settings to $loc
mkdir -p $loc
mv ~/.emacs $loc
mv ~/.emacs.d $loc

# create links to new settings
loc="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo creating links to new settings at ${loc}
ln -s ${loc}/.emacs ~/.emacs
ln -s ${loc}/.emacs.d ~/.emacs.d


