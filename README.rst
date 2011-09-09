Install
=======

In command line::

    $ cd dotfiles
    $ ./install.sh
    $ cp src/Shougo-vimproc-ver.5.3-0-g73fa395.zip ~
    $ cd
    $ unzip Shougo-vimproc-ver.5.3-0-g73fa395.zip
    $ cd Shougo-Vimproc
    $ make -f make_mac.mak
    $ cp autoload/proc.so ~/.vim/autoload/

In vim command line::

    :BundleInstall
