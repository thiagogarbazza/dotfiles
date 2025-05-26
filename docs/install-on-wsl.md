# WSL

```shell
wsl --shutdown

wsl --list

wsl --unregister Ubuntu

wsl --install

wsl --update
wsl --version

```

```shell
echo "Executando comando para instalar"

# Replace the nameserver
cat /etc/resolv.conf
sudo rm /etc/resolv.conf
sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'

curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/install.sh | bash

cd /mnt/d/workspace/projects/dotfiles && bash install.sh
```


https://github.com/kdeldycke/dotfiles/blob/main/readme.md
https://github.com/joshukraine/dotfiles/blob/master/zsh/.zshrc

https://github.com/StefanScherer/dotfiles/blob/main/setup-mac
https://github.com/yuk7/dotfiles/blob/main/_ssh/install.sh
