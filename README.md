
<div align='center'>
  <samp><h1>My Awesome(WM) Dotfiles</h1></samp>
  
  <p>
    <a href="https://github.com/N3k0Ch4n/Another_dotfiles/stargazers"><img src="https://img.shields.io/github/stars/N3k0Ch4n/Another_dotfiles?colorA=151515&colorB=8C977D&style=for-the-badge"></a>
  </p>
</div>


## 👀 <samp>DETAILS:</samp> 
<img alt="rice" align="right" width="400px" src="https://github.com/N3k0Ch4n/Another_dotfiles/blob/main/20-05-22_15:11:37.png"/>

- **OS**   -   Arch Linux
- **WM**   -   Awesome
- **Term**  -   URxvt
- **Comp**  -   Picom
- **Resolution**  -  1920x1080

<br><br><br>

## 🚀 <samp>DEPENDENCIES:</samp>

- Awesome-git
- inotify-utils
- brightnessctl
- pulseaudio
- pactl
- network-manager (I use this for the wifi)
- urxvt (change default terminal in "awesome/conf/init.lua")

## 🔧 <samp>Installation:</samp>

Firstly, clone the repository.

```sh
$ git clone https://github.com/N3k0Ch4n/Another_dotfiles.git
```

Then, Copy and paste "Awesome" folder into ".config" folder.

```sh
$ cd Another_dotfiles/conf
$ cp -r awesome/ $HOME/.config/
```

Lastly, change the following variables suitable to your liking

- Terminal (.config/awesome/conf/init.lua)
- Wall (.config/awesome/themes/theme.lua)
- Font (.config/awesome/themes/theme.lua)

<samp>Changing the wallpaper:</samp>

Search "theme.wallpaper" inside wall's file mentioned above

```lua
theme.wallpaper = "your/wallpaper/location/Ur pfp.png"
```
