#!/bin/zsh
# Taken from : https://github.com/croaky/dotfiles/blob/master/install.sh

# Install oh-my-zsh, if needed
if [ -d ~/.oh-my-zsh ]
then
  echo "\033[0;34mOh My Zsh already installed.\033[0m"
else
  wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
fi

# Install oh-my-zsh files (.oh-my-zsh should be a symlink)
if [ -d ~/.oh-my-zsh ]
then
  echo "\033[0;34mInstalling oh-my-zsh files.\033[0m"
  cp -f oh-my-zsh/themes/gravis.zsh-theme $HOME/.oh-my-zsh/themes
  cp -rf oh-my-zsh/custom/* $HOME/.oh-my-zsh/custom/
  echo "\n\033[0;32mDone installing files.\033[0m"
fi

cutstring="DO NOT EDIT BELOW THIS LINE"

for name in *; do
target="$HOME/.$name"
  if [ -e "$target" ]; then
if [ ! -L "$target" ]; then
cutline=`grep -n -m1 "$cutstring" "$target" | sed "s/:.*//"`
      if [ -n "$cutline" ]; then
cutline=$((cutline-1))
        echo "Updating $target"
        head -n $cutline "$target" > update_tmp
        startline=`sed '1!G;h;$!d' "$name" | grep -n -m1 "$cutstring" | sed "s/:.*//"`
        if [ -n "$startline" ]; then
tail -n $startline "$name" >> update_tmp
        else
cat "$name" >> update_tmp
        fi
mv update_tmp "$target"
      else
echo "WARNING: $target exists but is not a symlink."
      fi
fi
else
if [ "$name" != 'install.sh' ]; then
echo "Creating $target"
      if [ -n "$(grep "$cutstring" "$name")" ]; then
cp "$PWD/$name" "$target"
      else
ln -s "$PWD/$name" "$target"
      fi
fi
fi
done

# Install vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
