# sudo apt install azure-cli -y

echo 'az login -u *** -p ***'

group=****

pre=dev-0-vm-k8s

machines="$pre-lb-0 $pre-master-0"
machines="$machines $pre-worker-0 $pre-worker-1 $pre-worker-2"

template_dir=/home/kaumi/azure_chains/template

template_file=$template_dir/template.json

parameters_original=$template_dir/parameters_original.json
parameters_file=$template_dir/parameters.json

ips=('4' '5' '6' '7' '8' '9' '10' '11' '12') ; index=0

for machine in $machines
do
    echo
    echo "MACHINE : $machine to CREATE "
    echo
    
    # make copy from backup

    cp $parameters_original $parameters_file
    
    # find and replace session
    # source : https://stackoverflow.com/questions/525592/find-and-replace-inside-a-text-file-from-a-bash-command
    
    sed -i -e "s/dev-0-vm-k8s-NetworkInterface/$machine-NetworkInterface/g" $parameters_file
    sed -i -e         "s/dev-0-vm-k8s-TestName/$machine/g"                  $parameters_file
    sed -i -e              "s/xxxxxxxx/${ips[ $index ]}/g"                  $parameters_file
    
    if [[ "$machine" == "dev-0-vm-k8s-lb-0" ]] ; then
    
        sed -i -e 's/Standard_B4ms/Standard_B2s/g' $parameters_file
    fi
    
    # for more check
    cp $parameters_file $template_dir/logs/$machine-parameters.json

    az deployment group create -g $group \
       \
       --template-file   $template_file \
       --parameters   @$parameters_file \
       \
       --only-show-errors
    
    index=$((index + 1))
done
