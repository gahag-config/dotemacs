@echo off

mklink %appdata%\\.emacs.d\\.mc-lists.el %~dp0\\mc-lists.el
mklink %appdata%\\.emacs                 %~dp0\\Instances\\%*
