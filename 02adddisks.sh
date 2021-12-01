#each worker gets 3 disks
DISKSIZE=500G

rm -rf /disk1/*
rm -rf /disk2/*
rm -rf /disk3/*

for i in {1..5}
do
#echo "qemu-img create -f raw /disk1/disk${i}.img ${DISKSIZE}"
qemu-img create -f raw /disk1/disk${i}.img ${DISKSIZE}

echo "virsh attach-disk ocp4-worker-${i} /disk1/disk${i}.img  vdb --config"
virsh attach-disk ocp4-worker-${i} /disk1/disk${i}.img vdb --config
done

for i in {1..5}
do
#echo "qemu-img create -f raw /disk2/disk${i}.img ${DISKSIZE}"
qemu-img create -f raw /disk2/disk${i}.img ${DISKSIZE}

echo "virsh attach-disk ocp4-worker-${i} /disk2/disk${i}.img  vdc --config"
virsh attach-disk ocp4-worker-${i} /disk2/disk${i}.img vdc --config
done

for i in {1..5}
do
#echo "qemu-img create -f raw /disk3/disk${i}.img ${DISKSIZE}"
qemu-img create -f raw /disk3/disk${i}.img ${DISKSIZE}

echo "virsh attach-disk ocp4-worker-${i} /disk3/disk${i}.img  vdd --config"
virsh attach-disk ocp4-worker-${i} /disk3/disk${i}.img vdd --config
done

for i in {1..5}
do
echo "refreshing worker: ocp4-worker-${i}"
virsh destroy ocp4-worker-${i} 
sleep 30
virsh start ocp4-worker-${i}
done

