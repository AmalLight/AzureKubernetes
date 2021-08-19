# sudo apt install azure-cli -y

echo 'az login -u *** -p ***'

group=****

pre=dev-0-vm-k8s

machines="$pre-lb-0 $pre-master-0"
machines="$machines $pre-worker-0 $pre-worker-1 $pre-worker-2"

start=1 ; end=2 ; # start-end indexes for take disk's substring

for machine in $machines
do
    echo
    echo "MACHINE : $machine to DELETE Vm "
    echo
    
    az vm delete -y -n $machine -g $group --only-show-errors
    
    echo
    echo "MACHINE : $machine-NetworkInterface to DELETE Network "
    echo

    az network nic delete -n $machine-NetworkInterface -g $group --only-show-errors
done

disks=`az disk list | grep ' "'$pre`

index=0

for disk in $disks
do
    index=$((index + 1))
    
    if (( index % 2 > 0 )); then continue ; fi

    disk=${disk:$start:-$end}
    
    echo
    echo "MACHINE : $disk to DELETE Disk "
    echo
    
    az disk delete -y -n $disk -g $group --only-show-errors
done
