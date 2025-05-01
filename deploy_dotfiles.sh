#!/bin/bash
set -e

echo "📂 Asegurando que los archivos tengan el punto (.) al inicio y copiándolos correctamente..."

# Crear directorios si no existen
mkdir -p ~/dotfiles/aliases ~/dotfiles/bash ~/dotfiles/git ~/dotfiles/irb ~/dotfiles/rspec ~/dotfiles/tm ~/dotfiles/vim ~/dotfiles/zsh

# Copiar los archivos correctamente con el punto al inicio
cp -v ~/.aliases ~/dotfiles/aliases/.aliases || echo "No existe .aliases"
cp -v ~/.bashrc ~/dotfiles/bash/.bashrc || echo "No existe .bashrc"
cp -v ~/.gitconfig ~/dotfiles/git/.gitconfig || echo "No existe .gitconfig"
cp -v ~/.irbrc ~/dotfiles/irb/.irbrc || echo "No existe .irbrc"
cp -v ~/.rspec ~/dotfiles/rspec/.rspec || echo "No existe .rspec"
cp -v ~/.tm_properties ~/dotfiles/tm/.tm_properties || echo "No existe .tm_properties"
cp -v ~/.vimrc ~/dotfiles/vim/.vimrc || echo "No existe .vimrc"
cp -v ~/.zshrc ~/dotfiles/zsh/.zshrc || echo "No existe .zshrc"

echo "✅ Archivos movidos correctamente a dotfiles/"

echo "🗑️ Borrando symlinks viejos si existen..."
rm -v ~/.aliases ~/.bashrc ~/.gitconfig ~/.irbrc ~/.rspec ~/.tm_properties ~/.vimrc ~/.zshrc 2>/dev/null || true

echo "🔗 Aplicando stow para crear symlinks nuevos..."
cd ~/dotfiles
stow aliases bash git irb rspec tm vim zsh

echo "🎉 ¡Todo listo! Los archivos están organizados y los symlinks actualizados."
