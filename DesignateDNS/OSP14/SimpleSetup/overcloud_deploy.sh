#!/bin/bash

openstack overcloud deploy \
--timeout 100 \
--templates /usr/share/openstack-tripleo-heat-templates \
--stack overcloud \
--libvirt-type kvm \
--ntp-server clock1.rdu2.redhat.com \
-e /home/stack/virt/config_lvm.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/enable-designate.yaml \
-e /home/stack/virt/network/network-environment.yaml \
-e /home/stack/virt/inject-trust-anchor.yaml \
-e /home/stack/virt/hostnames.yml \
-e /home/stack/virt/nodes_data.yaml \
-e ~/containers-prepare-parameter.yaml \
-e /home/stack/virt/extra_templates.yaml \
-e /home/stack/virt/ips-from-pool.yaml \
-e /home/stack/virt/designate-config.yaml \
--log-file overcloud_deployment_16.log

