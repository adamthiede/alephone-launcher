# AlephOne-Launcher

## A graphical Launcher for AlephOne's Marathon engine for Linux.

![Marathon Launcher](launcher-screenshot.png "Marathon Launcher")

The launcher is a program written in Vala. It will download and unzip the marathon game files to your `~/.local/share/marathon/` folder and give you buttons for each game. It comes with a .desktop file so you never have to open the command line after you install it.

To compile, you need the vala compiler installed, and GTK dev libraries for either gtk3 or gtk4, depending on which version you're building.

If you have any suggestions please let me know!

Eventual goals:

- kill the .sh file; move functionality into the launcher itself
- gtk4 port
- flatpak
- better Makefile
