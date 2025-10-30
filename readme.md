# Dotfiles


This repo contains my eww config widgets files.

## Contenido

Elkowars Wacky Widgets is a standalone widget system made in Rust that allows you to implement your own, custom widgets in any window manager.

Documentation and instructions on how to install can be found here.

Dharmx also wrote a nice, beginner friendly introductory guide for eww here.


Eww - Widgets for everyone!

Eww (ElKowar's Wacky Widgets, pronounced with sufficient amounts of disgust) is a widget system made in Rust, which lets you create your own widgets similarly to how you can in AwesomeWM. The key difference: It is independent of your window manager!

Configured in yuck and themed using CSS, it is easy to customize and provides all the flexibility you need!
How to install Eww
Prerequisites

    rustc
    cargo

Rather than with your system package manager, I strongly recommend installing it using rustup.

Additionally, eww requires some dynamic libraries to be available on your system. The exact names of the packages that provide these may differ depending on your distribution. The following list of package names should work for arch linux:
Packages

(Note that you will most likely need the -devel variants of your distro's packages to be able to compile eww.)
Building

Once you have the prerequisites ready, you're ready to install and build eww.

First clone the repo:

git clone https://github.com/elkowar/eww

cd eww

Then build:

cargo build --release --no-default-features --features x11

NOTE: When you're on Wayland, build with:

cargo build --release --no-default-features --features=wayland

Running eww

Once you've built it you can now run it by entering:

cd target/release

Then make the Eww binary executable:

chmod +x ./eww

Then to run it, enter:

./eww daemon
./eww open <window_name>

## Uso

Para usar estos archivos, puedes copiarlos a tu carpeta `~/.config` correspondiente. Es recomendable hacer una copia de seguridad de tus configuraciones actuales antes de reemplazarlas.

```bash
# Ejemplo de copia
cp -r eww ~/.config/
# etc.
```

## Notas

* Estas configuraciones son personales y adaptadas a mi sistema. Algunas rutas o programas pueden necesitar ajustes para funcionar en otros entornos.
* No contiene datos personales ni claves privadas.
