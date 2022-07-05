
<h1 align='center'>
  .Rice..
</h1>

<img align='left' alt="GitHub Repo stars" src="https://img.shields.io/github/stars/N3k0Ch4n/dotRice?color=%23ffefd0&label=Stars&style=for-the-badge&labelColor=ffefd0">
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

<details close>

<summary><b>1. Install the Dependencies</b></summary>
  
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
  - redshift
  - bluez
  - bluez-utils

<br>

**Required Fonts**

- [Material Design Icons](https://materialdesignicons.com/)
- Icomoon
- Iosevka
- AzukifontBI

<br>

And some others I dont remember 💀
  
I Promise I'll list all of them when I get the time, okay?

<br>

For Arch linux (since I use them)

```sh
sudo pacman -S jq inotify-tools playerctl brightnessctl pulseaudio networkmanager rxvt-unicode mpd ncmpcpp \
alsa-utils alsa-plugins alsa-firmware mpc xclip base-devel pamixer redshift
```

</details>

<br>

<details close>

<summary><b>2. Clone the repo</b></summary>

```sh
git clone https://github.com/N3k0Ch4n/dotRice.git
cd dotRice/conf/
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

</details>

<br>

**4. Restart your system & Log in with awesomeWM**

Ah yes, you need to change openweathermap id and your-place id in 'conf/awesome/signals/weather'

<br>

**5. You're done!**

<br>

---

<br>

**Here's how it actually looks like:**

<h3 align='center'>Desktop</h3>

<img src="https://i.imgur.com/HI16CyG.png">

<br>

<h3 align='center'>Dashboard</h3>

<img src="https://i.imgur.com/vBuacbX.png">

<br>

<h3 align='center'>Logout Screen</h3>

<img src="https://i.imgur.com/CgBfzcD.png">

<br>

---

<br>

### For the keybind, uhm..

| Keybinds    | Uses     |
| ----------- | -------- |
| Mod + Enter | Terminal |
| Mod + Space | Layout   |
| Mod + r     | Rofi      |
| alt + z     | Dashboard|
| alt + c     | Sidebar  |
| alt + x     | Powermenu|
| Mod + Ctrl + n | Un-minimize |

Pretty Simple, huh

Just do not look at the keybind's awesome config. It's Messy..

<br>

---

<br>

### Improvement in the future

- [x] Dashboard 
- [x] Notifications enhancement
- [ ] Lock Screen 
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
