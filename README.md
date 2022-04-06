# termux-gui
Like Desktop Experience Using Texrmux And Any VNC Viewer.
### Installation

After installing both applications above, open `Termux` and follow the steps below -

- Update termux packages and install `git`
```
pkg upgrade && pkg install git
```

- Clone this repository
```
git clone --depth=1 https://github.com/sb-codz/termux-gui.git
```

> **Warning** ##Use it at your own risk##: I'm assuming that you're doing this on a fresh termux install. If not, I'll suggest you to do so. However the `setup.sh` script backup every file it replace, It's still recommended that you manually backup your files in order to avoid conflicts. <br />

- Change to cloned directory and run `setup.sh` with *--install* option
```
cd termux-gui
chmod +x setup.sh
./setup.sh --install
```