# Personal dotfiles

My personal dotfiles. I will try to keep them somewhat up to date.

I'm using stow, so you can install them with

```
$ echo */ | xargs stow
```

(execute stow for all directories in the working directory that are not hidden)

My current setup mostly uses:

 * `i3wm` as *Window Manager*
 * `polybar` as `i3bar` replacement
 * `rofi` as `dmenu` replacement
 * `fish` as shell [^1]
 * `Urxvt` as terminal emulator
 * `dunst` to display notifications
 * `emacs` as text editor
 
[^1]: I usually start bash and let my `.bashrc` decide on which shell
    to use
