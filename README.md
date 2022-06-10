<p align='center'><img width="200px" src="https://github.com/N3k0Ch4n/Another_dotfiles/blob/main/conf/awesome/themes/pfp.jpg"></p>

<h1 align='center'>
  .Rice..
</h1>

<img align='left' alt="GitHub Repo stars" src="https://img.shields.io/github/stars/N3k0Ch4n/Another_dotfiles?color=%23ffefd0&label=Stars&style=for-the-badge&labelColor=ffefd0">
<img align='right' alt="GitHub last commit (branch)" src="https://img.shields.io/github/last-commit/N3k0Ch4n/Another_dotfiles/main?color=%2388aeda&label=Update%3F&style=for-the-badge&labelColor=88aeda">

<br>

<br>

<br>

My simple backup config for "Japan Vibe" rice theme
> I'm using 1920x1080 screen resolution. Hope things goes perfectly fine for others..

### My setup 🧰:

- **WM**   - AwesomeWM
- **Term**  -  URxvt
- **Comp**  -  Picom

Nothing special

### How do I get this ❓

Well.. You just need to follow (or not) the following instructions given below

Note that I haven't test these scripts yet hehe

**1. Install all the dependencies**

<details close><summary>Pottential dependencies</summary>
  
  - [awesome-git](https://aur.archlinux.org/packages/awesome-git)
  - [mpd-mpris](https://github.com/natsukagami/mpd-mpris)
  - jq
  - inotify-tools
  - playerctl
  - brightnessctl
  - pulseaudio
  - network-manager
  - rxvt-unicode
  - mpd
  - ncmpcpp
  - [Material Design Icons](https://materialdesignicons.com/)

And some others I dont remember
</details>

```sh
$ sudo pacman -S jq inotify-tools playerctl brightnessctl pulseaudio network-manager rxvt-unicode mpd ncmpcpp 
```

**2. Clone the repo**

```sh
$ git clone https://github.com/N3k0Ch4n/Another_dotfiles.git
$ cd Another_dotfiles/conf/
$ git submodule init
$ git submodule update
```

**3. Copy the config inside your config folder, in this case "$HOME/.config/"**

```sh
$ cp -rf cava awesome mpd ncmpcpp picom $HOME/.config/
$ cp -rf .Xresources .bashrc .vimrc .zshrc $HOME/
$ cd ..; cp -rf misc/fonts/* $HOME/.local/share/fonts/
$ fc-cache -v
```

**4. Restart your system & Log in with awesomeWM**

**5. You're done!**

<br>

**Here's how it actually looks like:**

<img src="https://github.com/N3k0Ch4n/Another_dotfiles/blob/main/github/scr.png">

<br>

### For the keybind, uhm..

| Keybinds    | Uses     |
| ----------- | -------- |
| Mod + Enter | Terminal |
| Mod + Space | Layout   |
| Mod + r     | Rofi      |
| alt + c     | Sidebar  |
| alt + x     | Powermenu|

Pretty Simple, huh

Just do not look at the keybind's awesome config. It's Messy..

### Million of Thanks to 💕

- [Saimoom/Harry](https://github.com/saimoomedits/dotfiles)
- [Elenapan](https://github.com/elenapan/dotfiles)
- [Ner0z](https://github.com/ner0z/dotfiles)

<br>

**And lastly.. To You Guys!**

**Hope y'all have fun ricing and I wish you 'Good Luck'!**
