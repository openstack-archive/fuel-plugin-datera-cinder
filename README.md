# fuel-plugin-datera-cinder

## Plugin description

Datera plugin for Fuel extends Mirantis OpenStack functionality by
adding support for Datera Elastic Data Fabric.

The Datera EDF is an fast, policy based, management lights out, 
iSCSI block storage device that can be used as a Cinder backend.

## Requirements

```
Requirement                                          | Version/Comment
---------------------------------------------------- | ---------------
Mirantis OpenStack compatibility                     | >= 7.0         
Access to Datera via ccinder-volume node             |                
iSCSI initiator on all compute/cinder-volume nodes   |                
```

## Limitations

Mirantis Openstack 7.0 does not support multiple backends.

## Datera configuration

Before deployment the following needs to be verified:
1. Your Datera Cluster is reachable by all compute nodes, as well as the Cinder Control/Manager node.  
2. Create an Openstack account on the Datera cluster that can create volumes. (san_login/password).
3. Use the Management VIP address for the Datera cluster. (as the san_ip)`

## Datera Cinder plugin installation

Grab the RPM, upload it to the Fuel master server and run:
```
fuel plugins --install <rpm>
```

Building the plugin from scratch:
```
yum install python-pip createrepo dpkg-devel dpkg-dev rpm rpm-build
```
or
```
pip install fuel-plugin-builder
```

```
git clone https://github.com/snuf/fuel-plugin-datera-cinder
fpb --build fuel-plugin-datera-cinder
scp <rpm> <fuel master node>
fuel plugins --install <rpm>
```

## Datera plugin configuration

For Fuel 7.0 the plugin is under the settings tab. In Fuel 8.0 this has however moved to the Settings->Storage tab.

Enabling the driver is done by ticking the box at the top of the configuration fields for the driver. The previously mentioned san_login, san_password and san_ip are used in their respective fields. Take not of the replica count field, which dictates the amount of copies that will be held in the EDF for all Mirantis Fuel Openstack created volumes
