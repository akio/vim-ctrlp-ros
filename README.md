vim-ctrlp-ros
================================
[ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) Extension for ROS.

Basic Usage
--------------------------------

- Run `:CtrlPRosEd` to list ROS packages.
  If you select a package then it opens a new CtrlP window
  with setting the package directory as CtrlP's working directory.

- Run `:CtrlPRosLs` to list ROS packages.
  If you select a package, it opens the package directory.

- Run `:CtrlPRosCd` to list ROS packages.
  If you select a package, it invoke `cd <package directory>`.

- Run `:CtrlPRosMsg` to list ROS message files(`.msg`).
  If you select a message, it opens the message file.

- Run `:CtrlPRosSrv` to list ROS service files(`.srv`).
  If you select a message, it opens the service file.


Installation
--------------------------------
With [vim-plug](//github.com/junegunn/vim-plug), put following line to yor config:

  Plug 'akio/vim-ctrlp-ros'

Or you might be able to use other plugin managers.

License
---------------------------------
Please see `LICENSE.txt`.
