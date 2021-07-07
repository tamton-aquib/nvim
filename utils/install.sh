
if [ -d "/home/taj/.config/nvim/" ]; then
    echo -e "Get a backup of ur current nvim config bruh..."
    exit 1
else
	echo "No problemo"
fi

if [ -d ~/.local/share/nvim/site/pack/packer ]; then
  echo -e "Clearning previous packer installs"
  rm -rf ~/.local/share/nvim/site/pack
fi

echo -e "\n=> Installing packer..\n"

git clone https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  
echo -e "=> Packer installed!"

echo -e "\nCloning the repo...\n"
git clone https://github.com/tamton-aquib/nvim.git ~/.config/nvim 2>/dev/null
echo -e "\nDone Cloning\n"

nvim +PackerSync

