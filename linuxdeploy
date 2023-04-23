#!/bin/sh

setup(){
	ip a | grep -i broad | awk -F": " '{ print "Your network interface is: "$2" please verify that you have internet access before continuing." }'
	echo "Conducting network check:"
	ping -c1 archlinux.org |grep packet | awk -F", " '{ print "You have "$3" to archlinux.org" }'
	read -p "If you're sure that you have internet connection, press any key and hit enter, otherwise, type \"exit\" as shown (\"exit\") " sureness
	if [ "$sureness" = "exit" ];
	then
		exit
	else
		echo "Continuing"
	fi
	timedatectl set-ntp true
}



device_select(){
	echo -en "Available Devices:\n"
	lsblk | grep disk | awk '{ print "/dev/"$1,$4 }'
	read -p "Please select device you are installing Linux on (implied /dev/): " disk
	disk="/dev/$disk"
	echo "$disk"
}





parttype(){
	read -p "Will this be a gpt or a dos disk? " partable
	if [ "$partable" = "gpt" ];
	then
		echo "Partition type selected: gpt ($partable)"
	elif [ "$partable" = "dos" ];
	then
		echo "Partition type selected: dos ($partable)"
	else
		echo "Incorrect partition type selected, try again!"
		parttype
	fi
}

gpt_setup(){
	(
	echo g # Create a new empty dos partition table
	echo n # Add a new partition (Note, not required to selected primary here)
	echo 1 # Partition number
	echo   # First sector (Accept default)
	echo "+200M" # Last sector
	echo t #Open the partition type menu
	echo 1 #set Partition to EFI type
	echo n # Add a new partition (Root)
	echo 2 # Partition number
	echo   # First sector (Default)
	echo "+35G" # Create 35GB partition for root
	echo n # Add a new partition (Home)
	echo 3 # Partition number
	echo   # First sector (Default)
	echo   # Last sector (Default if you want to use the rest of the disk)
	echo w #write
	)  | fdisk $disk #to be implemented when a VM is set up.
	fdisk -l $disk
	disk1=${disk}1 #boot partition
	disk2=${disk}2 #root partition
	disk3=${disk}3 #home partition
	mkfs.fat -F32 $disk1
	mkfs.ext4 $disk2
	mkfs.ext4 $disk3
	mkdir /mnt/boot/EFI
	mkdir /mnt/home
	mount "$disk1" /mnt/boot/EFI
	mount "$disk2" /mnt/
	mount "$disk3" /mnt/home
}

dos_setup(){
	(
	echo o # Create a new empty dos partition table
	echo n # Add a new partition
	echo p # primary
	echo 1 # Partition number
	echo   # First sector (Accept default)
	echo "+200M" # Last sector
	echo n # Add a new partition (Root)
	echo p # primary
	echo 2 # Partition number
	echo   # First sector (Default)
	echo "+15G" # Create 35GB partition for root
	echo n # Add a new partition (Home)
	echo p # primary
	echo 3 # Partition number
	echo   # First sector (Default)
	echo   # Last sector (Default if you want to use the rest of the disk)
	echo w #write
	)  | fdisk $disk #to be implemented when a VM is set up.
	fdisk -l $disk
	disk1=${disk}1 #boot partition
	disk2=${disk}2 #root partition
	disk2=${disk}3 #home partition
	mkfs.ext4 "$disk2"
	mkfs.ext4 "$disk3"
	mkdir /mnt/boot
	mkdir /mnt/home
	mount "$disk1" /mnt/boot
	mount "$disk2" /mnt/
	mount "$disk3" /mnt/home
}


fdisk_options(){
	if [ "$partable" = "gpt" ];
	then
		gpt_setup
	elif [ "$partable" = "dos" ];
	then
		dos_setup
	else
		echo "Failed checks! Exiting!"
		exit
	fi

}


device_partitioning(){
	parttype
	fdisk_options
}

installation(){
	read -p "Would you like to install linux-zen as your kernel (default linux kernel will also be installed as backup)? 'Yes/No/quit' " zenstallation
	if [ "$zenstallation" = "Yes" ]; #todo: add conditionals for cpu and gpu
	then
		echo "Executing pacstrap..."
		pacstrap /mnt base linux linux-firmware networkmanager linux-zen linux-zen-headers neovim vim grub efibootmgr
	elif [ "$zenstallation" = "No" ];
	then
		echo "Executing pacstrap..."
		pacstrap /mnt base linux linux-headers linux-firmware networkmanager neovim vim grub efibootmgr
	elif [ "$zenstallation" = "quit" ];
	then
		exit
	else
		echo "Please selected either \"Yes\", \"No\", or \"quit\""
		installation
	fi
	echo "Generating /etc/fstab..."
	genfstab -U /mnt >> /mnt/etc/fstab
	echo "Chrooting into install..."
	arch-chroot /mnt
	echo "Setting the time zone..."
	ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
	echo "Generating /etc/adjtime..."
	hwclock --systohc
	echo "Setting locale..."
	sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
	locale-gen
	echo "LANG=en_US.UTF-8" > /etc/locale.conf
	read -p "What Would you like to set your hostname as?" hostname
	echo "$hostname" > /etc/hostname
	echo -en "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$hostname.localdomain $hostname" > /etc/hosts
#	echo "While not usually necessary, remaking cpio..."
#	mkinitcpio -P
	echo "Setting root password..."
	passwd
	echo "Setting up grub..."
	if [ "$partable" = "gpt" ];
	then
		grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
	elif [ "$partable" = "dos" ];
	then
		grub-install --target=i386-pc "$disk"
	else
		echo "You somehow managed to get this far with an invalid entry... congrats. Exiting..."
		exit
	fi
	echo "Downloading Luke's Auto-Rice Bootstrapping Scripts, after reboot you can run with \"sh larbs.sh\""
	curl -LO larbs.xyz/larbs.sh

}



main(){
setup
device_select
device_partitioning
installation
}

main
