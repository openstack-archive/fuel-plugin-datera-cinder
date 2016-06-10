de to the Datera Cinder Plugin version 1.0.0 for Fuel
********************************************************

This document provides instructions for installing, configuring and using
the Datera Cinder plugin for Fuel.

Key terms, acronyms and abbreviations
=====================================

Cluster Management VIP:
    Management Virtual IP (MVIP) is the IP address (or hostname) of
    the management interface to the Datera Elastic Data Fabric.

Admin login:
    The Cluster Admin or Openstack login on a Datera EDF.

Datera Replication Factor:
    The number of replicas of a volume will be made in the Datera EDF.

Datera Cinder
=============

The Datera Cinder Fuel plugin automates the addition of the required
lines to the cinder.conf file to leverage the Datera EDF. It also
installs the correct cinder driver. The Datera EDF API has moved to v2 
and prior to Mitaka only v1 is supported by the bundled Datera cinder
driver, v2 is not backwards compatible.
The Datera Fuel plugin also extends the UI and enables a user to provide
the necessary details to configure cinder correctly,

License
-------

=======================   ==================
Component                  License type
=======================   ==================
Datera Cinder Driver      Apache 2.0

=======================   ==================

Requirements
------------

======================= ==================
Requirement             Version/Comment   
======================= ==================
Fuel                    7.0               
----------------------- ------------------
Fuel                    8.0               
======================= ================== 

Prerequisites
--------------

* The Datera EDF should be conffigured and reachable for the compute and 
  controller+cinder nodes.
  
* The EDF has to be configured and reachable prior to starting Cinder with
  the Datera EDF configuration in place.

============================================

Limitations
-----------

* Fuel 7.0 does not support multiple storage backends in Cinder,
  therefore the Datera Cinder Fuel plugin when applied to 7.0 does not 
  support multiple backends.

* The Datera Cinder Fuel Plugin does support creating a multi-backend
  configuration by selecting the checkbox in Fuel 8.0.

Installation Guide
==================


Datera Cinder plugin installation
----------------------------------

#. Download the plugin from
   `Fuel Plugins Catalog <https://www.mirantis.com/products/openstack-drivers-and-plugins/fuel-plugins/>`_.

#. Copy the plugin to Fuel Master node. If no Fuel master node is present
   please follow the instructions of the Mirantis Fuel documentation:

   ::

      scp fuel-plugin-datera-cinder-1.0-1.0.0.noarch.rpm \
          root@:<the_Fuel_Master_node>:

#. Log into the Fuel Master node and install the plugin:

   ::

        fuel plugins --install fuel-plugin-datera-cinder-1.0-1.0.0.noarch.rpm

Datera Cinder plugin configuration
-----------------------------------

The configuration for both Fuel 7.0 and 8.0, differences will be marked.

#. After the plugin is installed, create a new OpenStack environment following:
    `The openstack creation guide for Mirantis Fuel 7.0 <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#create-a-new-openstack-environment>`_. or 
    `The quickstart guide for Mirantis Fuel 8.0 <https://docs.mirantis.com/openstack/fuel/fuel-8.0/quickstart-guide.html>`_.

#. Configure your environment following:
    `The Mirantis Fuel 7.0 Configuration Documentation <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#configure-your-environment>`_. or 
    `The Mirantis Fuel 8.0 Planning Documentation <https://docs.mirantis.com/openstack/fuel/fuel-8.0/mos-planning-guide.html>`_.
    ** Make sure to also add the Cinder role for the controllers, if the Cinder role is not selected the Datera EDF plugin will NOT configure Cinder **

#. In Fuel 7.0: Open the *Settings tab* of the Fuel web UI, scroll down, 
   select 'Fuel plugin to enable Datera driver in Cinder.' on the left.

      .. image:: figures/cinder-datera-plugin-1.0.0-7.0.png
         :width: 100%

#. In Fuel 8.0: Open the *Settings tab* of the Fuel web UI, scroll down
   select 'storage' on the left and select the Datera Fuel plugin.

      .. image:: figures/cinder-datera-plugin-1.0.0-8.0.png
         :width: 100%

#. 'Multibackend enabled':
    By default the Datera plugin will not use Multibackend as a configuration option. This means that the configuration options will be set in the 'default' context of the cinder.conf file. In Fuel 8.0 the 'Multibackend enabled' checkbox can be set to support  multiple backends in cinder, which will put the configuration options in it's own Datera context.

#. 'Cluster Management VIP (san_ip)': 
    The IP or DNS name of the management VIP for the Datera EDF.

#. 'Login for Admin account (san_login)':
    The username of the account that has the correct rights to provision storage, this can be the Openstack user, the admin user or a specific tenant user.

#. 'Password for Admin account (san_password)':
    The password for the previously mentioned account.

#. 'Data replication factor': 
    This setting dictates how many copies of an app-instance will be distributed over the Datera EDF using its smart placement policies.

#. When configuration is complete the network check can be run and the 
    environment can be deployed.

User Guide
==========

Once Openstack is deployed by Fuel the Datera plugin provides no further 
configuration or maintenance options.
The logs for the Datera EDF driver will output all the logging in the 
cinder-volume log.

Known issues
============

Due to Fuels lack of support for multiple cinder backends in Fuel 7.0, only a 
single storage vendor backend may be automatically configured within Fuel
If multiple vendors are required the cinder.conf needs to be edited manually for
Fuel 7.0.

Appendix
========
