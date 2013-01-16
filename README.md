kermit-emacs
============

My Emacs24 configuration.

Install Emacs24
---------------

If you don't have it installed, you can get Emacs24 in Ubuntu

    sudo add-apt-repository ppa:cassou/emacs
    sudo apt-get update
    sudo apt-get install emacs-snapshot-gtk emacs-snapshot-el

Deploy my settings
------------------

Position yourself to where you keep your code, e.g.

    cd ~/code/

Clone the git repo

    git clone https://github.com/kermit666/kermit-emacs.git

Run the deployment script.

*Warning:* running this script will move your existing settings files to `~/old-emacs-settings`

    ./deploy-links.sh

Congratulations! You can now open emacs and enjoy it.
