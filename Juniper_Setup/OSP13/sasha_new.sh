    echo "fixing remote registry on /etc/sysconfing/docker"
    sudo sed -i 's/INSECURE_REGISTRY="--insecure-registry 192.168.24.1:8787 --insecure-registry 192.168.24.3:8787"/INSECURE_REGISTRY="--insecure-registry 192.168.24.1:8787 --insecure-registry 192.168.24.3:8787 --insecure-registry docker-registry.engineering.redhat.com"/' /etc/sysconfig/docker
    sudo service docker restart


    sudo iptables -I FORWARD -j ACCEPT

    #Get the list of included yamls - overcloud_deploy.sh should be on the system
    for i in `grep "^-e \|^-r " /home/stack/overcloud_deploy.sh|awk '{print $2}'`; do if [ -f "$i" ]; then LIST="${LIST} -e $i"; fi; done

    #Preparing the list container images to download to the local registry and to use with OC deployment
    #Note: if need to use a specific puddle, make sure to get the tag for that puddle and add to the below command an argument '--tag <tag id>'
    openstack overcloud container image prepare --namespace registry-proxy.engineering.redhat.com/rh-osbs --prefix rhosp13-openstack- --set ceph_namespace=registry.access.redhat.com/rhceph --set ceph_image=rhceph-3-rhel7 --set ceph_tag=latest --push-destination 192.168.24.1:8787 --output-images-file /home/stack/container_images.yaml --output-env-file /home/stack/docker-images.yaml --tag 20200213.1

    # Upload the images to the local registry
    #Using sudo to w/a bz#1646787
    sudo openstack overcloud container image upload --verbose --config-file /home/stack/container_images.yaml

