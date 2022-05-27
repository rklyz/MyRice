
<div align='center'>
  <samp><h1>My Awesome(WM) Dotfiles</h1></samp>
  
  <p>
    <a href="https://github.com/N3k0Ch4n/Another_dotfiles/stargazers"><img src="https://img.shields.io/github/stars/N3k0Ch4n/Another_dotfiles?colorA=151515&colorB=8C977D&style=for-the-badge"></a>
  </p>
</div>

## <samp>Quick Look:</samp>
* Bar
<br>
<img alt="bar" align="left" src="https://github.com/N3k0Ch4n/Another_dotfiles/blob/main/bar.gif"/>
* Popup
<img alt="Popup" align="left" src="https://github.com/N3k0Ch4n/Another_dotfiles/blob/main/bar.gif"/>
## 👀 <samp>DETAILS:</samp> 
<img alt="rice" align="right" width="400px" src="https://i.redd.it/grap6cd8de191.png"/>

- **OS**   -   Arch Linux
- **WM**   -   Awesome
- **Term**  -   URxvt
- **Comp**  -   Picom
- **Resolution**  -  1920x1080

## 🚀 <samp>DEPENDENCIES:</samp>

- Awesome-git
- inotify-tools
- playerctl
- brightnessctl
- pulseaudio
- pactl
- network-manager (I use this for the wifi)
- urxvt (change default terminal in "awesome/conf/init.lua")
- Roboto-Mono font

## 🔧 <samp>Installation:</samp>

**This may and may not work for some of ya'll. So, make sure to backup your config before proceeding.**

Firstly, clone the repository.

```sh
$ git clone https://github.com/N3k0Ch4n/Another_dotfiles.git
```

Then, Copy and paste "Awesome" folder into ".config" folder.

```sh
$ cd Another_dotfiles/conf
$ cp -r * $HOME/.config/
```

Lastly, change the following variables suitable to your liking

- Terminal (.config/awesome/conf/init.lua)
- Wall (.config/awesome/themes/theme.lua)
- Font (.config/awesome/themes/theme.lua)
- Autostart (.config/awesome/conf/init.lua)

<samp>Changing the wallpaper:</samp>

Search "theme.wallpaper" inside wall's file mentioned above

```lua
theme.wallpaper = "your/wallpaper/location/Ur_wall.png"
```
## 🕷️ <samp>Known Bug:</samp>

- Volume's Error at startup (just ignore it would ya? ;) )

## <samp>TODO:</samp>

- Improved notification's appearance
- Fix the bug ofc

## 💕 <samp>Credits:</samp>

- [saimoomedits](https://github.com/saimoomedits/dotfiles) for the 'easy-to-understand' dotfiles
- [javacafe](https://github.com/JavaCafe01/dotfiles) for some stolen scripts ;)
- [justleoo](https://github.com/justleoo/dotfiles) & [kizu](https://github.com/janleigh/dotfiles) for the Readme
