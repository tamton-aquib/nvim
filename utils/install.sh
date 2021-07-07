

G="\033[32m"
R="\033[31m"
E="\033[0m"

if [ -d "/home/taj/.config/nvim/" ]; then
    echo -e "${R}Get a backup of ur current nvim config bruh...${E}"
    exit 1
fi

if [ -d ~/.local/share/nvim/site/pack/packer ]; then
	echo -e "Clearning previous packer installs"
	rm -rf ~/.local/share/nvim/site/pack
fi

sleep 1

echo -e "\n=> Installing packer..\n"

git clone https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim 2>/dev/null
  
echo -e "${G}=> Packer installed!${E}"

sleep 1

echo -e "\nCloning the repo...\n"
git clone https://github.com/tamton-aquib/nvim.git ~/.config/nvim 2>/dev/null
echo -e "\n${G}Cloned Successfully!${E}\n"
sleep 1

nvim +PackerSync

