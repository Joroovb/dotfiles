#!/bin/bash



### NOTES

    # TRIM
    if [ "$DEVICE_TRIM" == "true" ]; then
        if [ "$FILE_SYSTEM_TYPE" == "f2fs" ]; then
            sed -i 's/relatime/noatime,nodiscard/' /mnt/etc/fstab
        else
            sed -i 's/relatime/noatime/' /mnt/etc/fstab
        fi
        arch-chroot /mnt systemctl enable fstrim.timer
    fi


### END OF NOTES
comment() {
    echo ">> $(tput setaf 2) $@$(tput sgr0)" >&2
}

# Prepare disk for Installation
lsblk
comment "Where do you want to install Arch?"
read DISK
#fdisk /dev/$DISK

# Final check before writing to disk
echo "We will install on $(tput bold; tput setaf 1)$DISK$(tput sgr0)! This is the last moment to press Ctrl+C."
echo -n "Enter to continue..."
read

comment "Create partitions for EFI and system"
# o y: Create a new empty GUID partition table (GPT) and confirm
# n 1 '' $EFI_PARTITION_SIZE ef00: create new partition with id 1, at the beginning, size $EFI_PARTITION_SIZE, and type ef00 (EFI System)
# n 2 '' '' 8300: create new partition with id2, after 1, size rest of the disk, and type 8300 (Linux filesystem)
# w y: Write table to disk and exit
if ! echo 'o
y
n
1

+550M
ef00
n
2

+8G
8200
n
3


8300
w
y' | gdisk "$DEVICE"
then
    fail "Cannot setup device partitions"
    exit 1
fi

# Mount the root partition
mount /dev/root_partition /mnt


# Install base system
pacstrap /mnt base base-devel linux linux-headers linux-firmware

# Generate fstab
comment "Generate /etc/fstab"
genfstab -U /mnt >> /mnt/etc/fstab
