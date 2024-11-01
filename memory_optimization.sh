#!/bin/bash

SSD_DISKS=$(lsblk -d -o name,rota | grep -E '0$' | awk '{print $1}')
for disk in $SSD_DISKS; do
  echo "Otimizando /dev/$disk no fstab..."
  echo "UUID=$(blkid -s UUID -o value /dev/$disk) /mnt ext4 defaults,noatime,discard 0 1" | sudo tee -a /etc/fstab
done

echo "Optimized file system!"