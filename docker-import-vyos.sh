#!/bin/bash
mkdir ~/vyos && cd ~/vyos
wget https://s3-us.vyos.io/rolling/current/vyos-1.4-rolling-202209260217-amd64.iso
mkdir ~/vyos/rootfs
sudo chmod 777 vyos-1.4-rolling-202209260217-amd64.iso
sudo mount -o loop vyos-1.4-rolling-202209260217-amd64.iso rootfs
sudo apt-get install -y squashfs-tools
mkdir ~/vyos/unsquashfs
sudo unsquashfs -f -d unsquashfs/ rootfs/live/filesystem.squashfs
# sudo tar -C unsquashfs -c . | sudo docker import - vyos:1.4-rolling-202209260217
if sudo tar -zcvf test.tar.gz unsquashfs | grep error
then
	exit 1
else
	:
fi
sudo docker import test.tar.gz vyos:1.4-rolling-202209260217
sudo umount rootfs
cd ..
sudo rm -rf vyos
sudo docker run -d --rm --name vyos --privileged -v /lib/modules:/lib/modules vyos:1.4-rolling-202209260217 /sbin/init
sudo docker exec -ti vyos su - vyos
