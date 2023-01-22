# AlephOne-Launcher

## A graphical Launcher for AlephOne's Marathon engine for Linux.

![Marathon Launcher](launcher-screenshot.png "Marathon Launcher")

The launcher is a program written in Vala. It will download and unzip the marathon game files to your `~/.local/share/AlephOne/` folder and give you buttons for each game. It comes with a .desktop file so you never have to open the command line after you install it.

## Known Issues

These just effect the launcher, not the game as a whole.

- The launcher locks up when downloading files. That's not something I've figured a way around yet.
- The buttons don't update when the download is complete.
- The way I'm handling icon display is bad (icons will frequently be broken) but doesn't effect functionality.

## Installing

### Flatpak Installation

I've pre-built this as a flatpak and host it on my website. Runtimes from [Flathub](https://flatpak.org/setup/) are required. If you have flatpak set up you likely have these installed already.

```
sudo flatpak remote-add --if-not-exists alephonelauncher https://elagost.com/flatpak/repo_launcher.flatpakrepo
sudo flatpak install com.elagost.alephone-launcher -y
```
The Flatpak build includes the game engine, so you don't have to install or build it separately.

### Building from source:

Build Dependencies:

- gtk4 or gtk3 dev libraries
- vala compiler (`valac`)
- make

Runtime dependencies:

- gtk4 or gtk3
- unzip
- wget
- The launcher doesn't include the game engine by default. You'll need to build the [alephone engine](https://github.com/Aleph-One-Marathon/alephone) from source too.

### Building the flatpak from source:

Install flatpak and flatpak-builder from your distro's repositories. You will need the [Flathub](https://flatpak.org/setup/) remote configured.

If flathub is configured at a user (not system) level, instead of `flatpak install` run `flatpak install --user` in the commands below. Check this with `flatpak remotes`.

```
flatpak install flathub org.gnome.Sdk//43 org.gnome.Platform//43 -y
flatpak-builder --force-clean --repo=./.flatpakrepo .builddir ./flatpak.yml
flatpak build-bundle .flatpakrepo launcher.flatpak com.elagost.alephone-launcher
flatpak install ./launcher.flatpak
flatpak run com.elagost.alephone-launcher
```

## Questions, comments, etc?

If you have any suggestions please submit a ticket [here](https://todo.sr.ht/~elagost/flatpaks).

Goals:

- [x] kill the .sh file; move functionality into the launcher itself
- [x] gtk4 port
- [x] flatpak
- [ ] native downloads instead of shelling out to `wget`
- [ ] better icon display mechanism
- [ ] fix broken button label setting
- [ ] validate downloads
- [ ] improve Makefile

