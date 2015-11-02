About
------------
Neovim config for ruby on rails developer.

Installation
------------

To ensure that all plugins work you need to have neovim with python support.
Check with `pip install neovim ` and `pip3 install neovim`.

Other dependencies:

  - rubocop
  - ripper-tags
  - ag

To install, run

    $ git clone git://github.com/gacha/nvim-config.git ~/.config/nvim
    $ mkdir ~/.config/nvim/bundle && mkdir ~/.config/nvim/swap && mkdir ~/.config/nvim/undo
    $ git clone https://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim

Then open neovim and install plugins

    $ nvim
    :NeoBundleInstall

To update plugins run

    $ vim
    :NeoBundleUpdate
