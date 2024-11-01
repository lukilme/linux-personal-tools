#!/bin/bash
get_free_memory() {
    free -k | grep Mem | awk '{print $4}'
}
echo '============== Sync Database ============'
echo ''
sudo pacman -Syy
echo ''
echo '======== Removing unused packages ======='
echo ''
sudo pacman -Rns $(pacman -Qtdq)

echo "Clearing cache of old Pacman packages..."
sudo paccache -r

echo "Removing all Pacman cache..."
sudo pacman -Scc --noconfirm
if command -v yay &> /dev/null
then
    echo "Clearing yay's cache..."
    yay -Scc --noconfirm
fi
echo "Clearing temporary files..."
sudo rm -rf /var/tmp/*
sudo rm -rf /tmp/*

echo "Clearing thumbnail cache..."
rm -rf ~/.cache/thumbnails/*

echo "Clearing Firefox cache..."
rm -rf ~/.mozilla/firefox/*.default-release/cache2/*

initial_free_memory=$(get_free_memory)

echo "Clearing cached memory..."
sudo sync && sudo sysctl -w vm.drop_caches=3

final_free_memory=$(get_free_memory)

freed_memory=$((final_free_memory - initial_free_memory))
echo "Freed memory: $freed_memory KB"

echo "Cleaning completed!"
