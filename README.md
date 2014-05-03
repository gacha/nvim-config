About
------------
This is a fork from https://github.com/nviennot/vim-config with some changes to suit my needs.

Watch his awesome article about vim + tmux and pry http://velvetpulse.com/2012/11/19/improve-your-ruby-workflow-by-integrating-vim-tmux-pry/ that convinced me to try vim as primary ruby editor.

Installation
------------

To ensure that all plugins work you need to have vim with:
  +ruby +python +X11

To install, run

    $ git clone git://github.com/gacha/vim-config.git ~/.vim
    $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Then open vim and install plugins

    $ vim
    :PluginInstall 

To update plugins run

    $ vim
    :PluginUpdate 
