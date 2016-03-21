fuel-plugin-datera-cinder
============

Plugin description
--------------

Datera plugin for Fuel extends Mirantis OpenStack functionality by
adding support for Datera EBS.

The Datera cluster is an iSCSI block storage device used as a
Cinder backend.

Requirements
------------

| Requirement                                          | Version/Comment |
|------------------------------------------------------|-----------------|
| Mirantis OpenStack compatibility                     | >= 7.1          |
| Access to Datera via ccinder-volume node             |                 |
| iSCSI initiator on all compute/cinder-volume nodes   |                 |

Limitations
-----------

Datera configuration
---------------------

Before deployment the following needs to be verified:
1. Your Datera Cluster is reachable by all compute nodes, as well as the
    Cinder Control/Manager node.
2. Create an Openstack account on the Datera cluster that can create
    volumes. 
    (san_login/password).
3. Use the Management VIP address for the Datera cluster.
    (as the san_ip)`

Datera Cinder plugin installation
---------------------------

All of the code required for using Datera in an OpenStack deployment is
included in the upstream OpenStack distribution.

Datera plugin configuration
----------------------------
