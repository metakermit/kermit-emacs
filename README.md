kermit-emacs
============

My Emacs configuration.

Install Emacs
-------------

If you don't have it installed, you can get the current Emacs in Ubuntu by running:

    sudo add-apt-repository ppa:ubuntu-elisp/ppa
    sudo apt-get update
    sudo apt-get install emacs-snapshot

In OS X you can use [Homebrew](https://brew.sh/) with [Cask](https://caskroom.github.io/):

    brew cask install emacs

Deploy the settings
-------------------

Position yourself to where you keep your code, e.g.

    cd ~/code/

Clone the git repo

    git clone https://github.com/metakermit/kermit-emacs.git

Run the deployment script.

*Warning:* running this script will move your existing settings files
to `~/old-emacs-settings`

    ./deploy-links.sh

Congratulations! You can now open Emacs and enjoy it.
