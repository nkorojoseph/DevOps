#!/bin/bash

# VM name (change as desired)
echo How many VMs do you want to create. Example: 4
read -p "VM_COUNT: " VM_COUNT

# Guest OS type (adjust for specific image and version)
echo Enter OS type. If you don\'t know the os type, go back and type \'VBoxManage list ostypes\'
read -p "Guest os: " GUEST_OS

# Memory allocated to VM (in MB)
echo Enter VM Memory size. Example 2048
read -p "VM Memory: " VM_MEMORY

# Size of virtual hard disk (in MB)
echo Enter Virtaul hard disk size. Example 40960
read -p "VM DISK_SIZE: " DISK_SIZE

# Path to your iso file
echo Enter the full path to your iso file. Example C:\\Users\\nkoro\\Downloads\\ubuntu-22.04.3-desktop-amd64.iso
read -p "ISO PATH: " ISO_PATH

# VM name (change as desired)
echo Enter name of your virtual machine. Example: app_server
read -p "CLUSTER NAME: " CLUSTER_NAME

i=1
while [ $i -lt $((VM_COUNT+1)) ]; do

    VM_NAME="$CLUSTER_NAME$i"

    # Create the virtual machine
    VBoxManage createvm --name "$VM_NAME" --ostype "$GUEST_OS" --register

    # Set base memory size
    VBoxManage modifyvm "$VM_NAME" --memory "$VM_MEMORY" --graphicscontroller vmsvga --vram 16 --cpus 4

    # Create a virtual hard disk
    VBoxManage createmedium disk --filename "$VM_NAME.vdi" --variant Standard --format=VDI  --size "$DISK_SIZE"

    # Attach the hard disk to the VM
    VBoxManage storagectl "$VM_NAME" --name "IDE Controller" --add ide

    VBoxManage storageattach "$VM_NAME" --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium "$VM_NAME.vdi"
    # Attach the ISO file as the CD/DVD device
    VBoxManage storageattach "$VM_NAME" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "$ISO_PATH"

    # (Optional) Enable USB controllers (uncomment if desired)
    # VBoxManage modifyvm "$VM_NAME" --usb on

    echo "Virtual Machine '$VM_NAME' created successfully!"

    i=$((i+1))
done


