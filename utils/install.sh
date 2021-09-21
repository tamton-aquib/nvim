R="\033[31m"
G="\033[32m"
E="\033[0m"

if [[ -d "/home/taj/.config/nvim/" ]]; then
    echo -e "${R}Get a backup of ur current nvim config bruh...${E}"
    exit 1
fi

if [[ -d ~/.local/share/nvim/site/pack/packer ]]; then
	echo -e "Clearning previous packer installs"
	rm -rf ~/.local/share/nvim/site/pack
fi

sleep 1

echo -e "\n${G}Cloning the repo...${E}\n"
git clone https://github.com/tamton-aquib/nvim.git ~/.config/nvim 2>/dev/null
echo -e "\n${G}Cloned Successfully!${E}\n"
sleep 1

nvim +PackerSync
