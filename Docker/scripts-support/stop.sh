# sudo apt install azure-cli -y

echo 'az login -u *** -p ***'

group=****

pre=dev-0-vm-k8s

machines="$pre-lb-0 $pre-master-0"
machines="$machines $pre-worker-0 $pre-worker-1 $pre-worker-2"

for machine in $machines
do
    echo
    echo "MACHINE : $machine to STOP "
    echo

    az vm stop -n $machine -g $group --only-show-errors
done
