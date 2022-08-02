
<h1 align='center'>
  
  <br>
  
  My Rice..
</h1>

<!--<img align='left' alt="GitHub Repo stars" src="https://img.shields.io/github/stars/rklyz/MyRice?color=%23ffefd0&label=Stars&style=for-the-badge&labelColor=ffefd0">
<img align='right' alt="GitHub last commit (branch)" src="https://img.shields.io/github/last-commit/rklyz/MyRice/main?color=%2388aeda&label=Last Update%3F&style=for-the-badge&labelColor=88aeda">
-->

<br>

<br>

<br>

An awesome(wm) **rice** that I made to get comfy experience for my daily usage.<br>

So.. go ahead on what you're trying to do.

I wouldn't mind.

### My setup 🧰:

- **OS** - Endeavor OS
- **WM**   - AwesomeWM
- **Term**  -  Wezterm
- **Comp**  -  Picom

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
  - [mpd-mpris](https://github.com/natsukagami/mpd-mpris)
  - [picom (pijulius fork)](https://github.com/pijulius/picom)
  - jq
  - inotify-tools
  - playerctl
  - brightnessctl
  - pulseaudio
  - network-manager
  - rxvt-unicode
  - mpd
  - ncmpcpp
  - redshift
  - bluez
  - bluez-utils
  - wezterm

<br>

**Required Fonts**

- [Material Design Icons](https://materialdesignicons.com/)
- Roboto
- Iosevka

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
cp -rf cava awesome mpd ncmpcpp picom $HOME/.config/
cp -rf .Xresources .bashrc .vimrc .zshrc $HOME/
cd ..; cp -rf misc/fonts/* $HOME/.local/share/fonts/
fc-cache -v
systemctl enable mpd.service; systemctl start mpd.service
```

You might wanna put your city name inside awesome.signals.weather

</details>

<br>

**4. Restart your system & Log in with awesomeWM**

<br>

**5. You're done!**

<br>

---

<br>

### How it looks like..

<h3 align='center'>Desktop</h3>

<img src="https://i.imgur.com/lPs1Y6s.png">

<br>

---

<br>

### Did you say keybind?

| Keybinds    | Uses     |
| ----------- | -------- |
| Mod + Enter | Terminal |
| Mod + Space | Layout   |
| Mod + r     | Rofi      |
| alt + c     | Sidebar  |
| Mod + Ctrl + n | Un-minimize |

<br>

---

<br>

### Improvement in the future

- [ ] Notifications enhancement
- [ ] Lock Screen 
- [x] Code-Cleaning

<br>

---

<br>

### Million of Thanks to 💕

- [Saimoom/Harry](https://github.com/saimoomedits/dotfiles)
- [Elenapan](https://github.com/elenapan/dotfiles)
- [Drahenprofi](https://github.com/drahenprofi/dotfiles)
- [Rxyhn](https://github.com/rxyhn/dotfiles)
- [Ner0z](https://github.com/ner0z/dotfiles)
- [unix-parrot](https://github.com/unix-parrot)

<br>

**And lastly.. To You Guys!**
