<h1 align='center'>
  
  <br>
  
  My Rice..
</h1>

<img align='right' alt="GitHub Repo stars" src="https://img.shields.io/github/stars/rklyz/MyRice?color=%23E6B88A&logo=starship&style=for-the-badge">

<br>

<br>

<br>

<img align='right' width='500px' src="https://i.imgur.com/1umFDPM.png">

An awesome(wm) **rice** that I made to get comfy experience for my daily usage.<br>

So.. go ahead on what you're trying to do.

I wouldn't mind.

### My setup 🧰:

- **OS** - EndeavourOS
- **WM** - AwesomeWM
- **Term** - Wezterm
- **Comp** - Picom

Nothing special

> I'm using 1920x1080 screen resolution. Hope things goes perfectly fine for others..

<br>

---

<br>

### How do I get this ❓

<br>

Well.. You just need to follow (or not) the following instructions given below

<details close>

<summary><b>1. Install the Dependencies</b></summary>
  
  - [awesome-git](https://aur.archlinux.org/packages/awesome-git)
  - [picom (ibhagwan fork)](https://github.com/ibhagwan/picom)
  - jq
  - inotify-tools
  - playerctl
  - brightnessctl
  - pulseaudio / pipewire-pulse
  - network-manager
  - mpd
  - mpDris2
  - ncmpcpp
  - xclip
  - maim
  - pamixer
  - rofi
  - wezterm
  - neovim
  - feh
  - zsh

<br>

**Required Fonts**

- [Material Design Icons](https://materialdesignicons.com/)
- Roboto

```sh
# Arch Linux
yay -S awesome-git mpd ncmpcpp jq inotify-tools playerctl brightnessctl \
pulseaudio networkmanager mpdris2 xclip maim pamixer rofi wezterm \
thunar neovim feh zsh base-devel
```

</details>

<br>

<details close>

<summary><b>2. Clone the repo</b></summary>

```sh
git clone https://github.com/rklyz/MyRice.git
cd MyRice/conf/
git submodule init
git submodule update
```

</details>

<br>

<details close>

<summary><b>3. Copy the config file</b></summary>

```sh
cp -rf cava awesome mpd ncmpcpp picom wezterm mpDris2 $HOME/.config/
cp -rf .Xresources .bashrc .vimrc .zshrc $HOME/
mkdir $HOME/.local/share/fonts
cd ..; cp -rf misc/fonts/* $HOME/.local/share/fonts/
fc-cache -v
systemctl enable --user mpd.service; systemctl start --user mpd.service
systemctl enable --user mpDris2.service; systemctl start --user mpDris2.service
```

Change to your wall location at awesome.theme.theme

Choose your /home disk in awesome.signals.disk. ex. /dev/sda2

Put your city name inside awesome.signals.weather

</details>

<br>

**4. Restart your system & Log in with awesomeWM**

<br>

**5. You're done!**

<br>

---

<br>

### Did you say keybind?

| Keybinds       | Uses        |
| -------------- | ----------- |
| Mod + Enter    | Terminal    |
| Mod + Space    | Layout      |
| Mod + r        | Rofi        |
| alt + c        | Sidebar     |
| alt + x        | Lockscreen  |
| Mod + Ctrl + n | Un-minimize |

<br>

---

<br>

### Colorscheme

The colorscheme that used in this rice is custom. (still doesn't have name yet)

### Light

<img width='300px' src='https://i.imgur.com/sXDJ3dw.png'>

### Dark

<img width='300px' src='https://i.imgur.com/SkdhTVQ.png'>

---

<br>

### Improvement in the future

- [x] Notifications enhancement
- [ ] Fixing bug
- [x] Code-Cleaning

<br>

---

<br>

### Million of Thanks to 💕

- [Ner0z](https://github.com/ner0z/dotfiles)
- [Drahenprofi](https://github.com/drahenprofi/dotfiles)
- [Elenapan](https://github.com/elenapan/dotfiles)
- [Saimoom/Harry](https://github.com/saimoomedits/dotfiles)
- [Rxyhn](https://github.com/rxyhn/dotfiles)

### Contributors :wrench:

- [Rony](https://github.com/ronylee11)
- [unix-parrot](https://github.com/unix-parrot)

<br>

**<samp>Last but not least.. You guys!<samp/>**
