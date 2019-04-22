openstack overcloud deploy \
--timeout 180 \
--templates /usr/share/openstack-tripleo-heat-templates \
--stack overcloud \
--libvirt-type kvm \
--ntp-server clock.redhat.com \
-e /home/stack/docker-images.yaml \
-e /home/stack/templates/ironic-inspector.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /home/stack/templates/network-environment.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/ceph-ansible/ceph-ansible.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/ironic.yaml \
-e /home/stack/templates/ironic.yaml \
-e /home/stack/templates/ceph.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ml2-ansible.yaml \
#-e /home/stack/templates/neutron-ml2-ansible.yaml \
--log-file overcloud_deployment.log \
-vv
