<p align='center'><img width="200px" src="https://github.com/N3k0Ch4n/Another_dotfiles/blob/main/conf/awesome/themes/pfp.jpg"></p>

<h1 align='center'>
  .Rice..
</h1>

<img align='left' alt="GitHub Repo stars" src="https://img.shields.io/github/stars/N3k0Ch4n/Another_dotfiles?color=%23ffefd0&label=Stars&style=for-the-badge&labelColor=ffefd0">
<img align='right' alt="GitHub last commit (branch)" src="https://img.shields.io/github/last-commit/N3k0Ch4n/Another_dotfiles/main?color=%2388aeda&label=Last Update%3F&style=for-the-badge&labelColor=88aeda">

<br>

<br>

<br>

My personal & simple backup config rice
> I'm using 1920x1080 screen resolution. Hope things goes perfectly fine for others..

### My setup 🧰:

- **WM**   - AwesomeWM
- **Term**  -  URxvt
- **Comp**  -  Picom

Nothing special

<br>

---

<br>

### How do I get this ❓

<br>

Well.. You just need to follow (or not) the following instructions given below

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

<br>

And some others I dont remember 💀
  
I Promise I'll list all of them when I get the time, okay?
  
</details>

```sh
sudo pacman -S jq inotify-tools playerctl brightnessctl pulseaudio networkmanager rxvt-unicode mpd ncmpcpp 
```

**2. Clone the repo**

```sh
git clone https://github.com/N3k0Ch4n/Another_dotfiles.git
cd Another_dotfiles/conf/
git submodule init
git submodule update
```

**3. Copy the config inside your config folder, in this case "$HOME/.config/"**

```sh
cp -rf cava awesome mpd ncmpcpp picom $HOME/.config/
cp -rf .Xresources .bashrc .vimrc .zshrc $HOME/
cd ..; cp -rf misc/fonts/* $HOME/.local/share/fonts/
fc-cache -v
systemctl enable mpd.service; systemctl start mpd.service
```

**4. Restart your system & Log in with awesomeWM**

Ah yes, you need to change openweathermap id and your-place id in 'conf/awesome/signals/weather'

**5. You're done!**

<br>

---

<br>

**Here's how it actually looks like:**

<img src="https://i.redd.it/0wlag5bp0q491.png">

<br>

<details close>
  <summary>Some more preview</summary>
  
  <h3>Sidebar</h3>
  <img src="https://github.com/N3k0Ch4n/Another_dotfiles/blob/main/.github/sidebar.gif">
  
  <br>
  
  <h3>Volume/Brightness Popup</h3>
  <img src="https://github.com/N3k0Ch4n/Another_dotfiles/blob/main/.github/pop.gif">
  
  <br>
</details>

<br>

---

<br>

### For the keybind, uhm..

| Keybinds    | Uses     |
| ----------- | -------- |
| Mod + Enter | Terminal |
| Mod + Space | Layout   |
| Mod + r     | Rofi      |
| alt + c     | Sidebar  |
| alt + x     | Powermenu|
| Mod + Ctrl + n | Un-minimize |

Pretty Simple, huh

Just do not look at the keybind's awesome config. It's Messy..

<br>

---

<br>

### Improvement in the future

- [ ] Dashboard ( working on it )
- [ ] Notifications enhancement since I'm using the default one ( Sorry )
- [ ] Code-Cleaning

<br>

---

<br>

### Million of Thanks to 💕

- [Saimoom/Harry](https://github.com/saimoomedits/dotfiles)
- [Elenapan](https://github.com/elenapan/dotfiles)
- [Ner0z](https://github.com/ner0z/dotfiles)
- [unix-parrot](https://github.com/unix-parrot)

<br>

**And lastly.. To You Guys!**

**Hope y'all have fun ricing and I wish you luck!**
