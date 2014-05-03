About
------------
Vim config for ruby on rails developer.

Installation
------------

To ensure that all plugins work you need to have vim with:
  +ruby +python +X11

Also some external tools:

  * rubocop - for code quality
  * zeal - for code documentation
  * ctags
  * ripper-tags - for propper ctags generation
  * powerline-fonts - for better airline

To install, run

    $ git clone git://github.com/gacha/vim-config.git ~/.vim
    $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    $ mkdir ~/.vim/undo ~/.vim/swap
    $ ln -s ~/.vim/vimrc ~/.vimrc

Then open vim and install plugins

    $ vim
    :PluginInstall 

To update plugins run

    $ vim
    :PluginUpdate 
