#!/bin/bash

# backup old confs (if they exist)
loc=~/old-emacs-settings/
echo Moving old settings to $loc
mkdir -p $loc
if [ -f ~/.emacs ]; then
    mv ~/.emacs $loc
fi
if [ -d ~/.emacs.d ]; then
    mv ~/.emacs.d $loc
fi

# create links to new settings
loc="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo creating links to new settings at ${loc}
ln -s ${loc} ~/.emacs.d

# create folders if not there
mkdir -p ~/.emacs.d/elpa
