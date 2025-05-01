# Dotfiles

My personal dotfiles for configuring development tools and environments. These dotfiles are managed using [GNU Stow](https://www.gnu.org/software/stow/) to easily create and manage symlinks.

## 📂 Structure

<pre>
  dotfiles/
  ├── aliases/
  │   └── .aliases
  ├── bash/
  │   └── .bashrc
  ├── git/
  │   └── gitconfig
  ├── irb/
  │   └── .irbrc
  ├── rspec/
  │   └── .rspec
  ├── tm/
  │   └── .tm_properties
  ├── vim/
  │   └── .vimrc
  └── zsh/
      └── .zshrc
</pre>

## ⚙️ Installation

Install GNU Stow (if not installed):

sudo apt install stow

Clone the repository into your home directory:

git clone https://github.com/your-username/dotfiles.git ~/dotfiles
cd ~/dotfiles

Stow the modules you want to use (creates symlinks):

stow aliases bash git irb rspec tm vim zsh

For Sublime Text settings (targeting its User folder):

stow -t ~/.config/sublime-text-3/Packages/User sublime

## 🛠️ Usage

To apply changes to all configurations:

cd ~/dotfiles
stow *

To remove symlinks for a module:

cd ~/dotfiles
stow -D zsh

## ✨ Notes

- Symlinks will be created in your home directory (`~`) or Sublime’s config folder.
- Feel free to edit these dotfiles and re-run `stow` to update symlinks.
