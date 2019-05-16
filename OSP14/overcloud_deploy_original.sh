#!/bin/bash

openstack overcloud deploy \
--timeout 180 \
--templates /usr/share/openstack-tripleo-heat-templates \
--stack overcloud \
--libvirt-type kvm \
--ntp-server clock.redhat.com \
-e /home/stack/templates/ironic-inspector.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /home/stack/templates/network-environment.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/ceph-ansible/ceph-ansible.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/ironic.yaml \
-e /home/stack/templates/ironic.yaml \
-e /home/stack/templates/ceph.yaml \
-e /home/stack/templates/nodes_data.yaml \
-e /home/stack/containers-prepare-parameter.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ml2-ansible.yaml \
--log-file overcloud_deployment.log \
-v
