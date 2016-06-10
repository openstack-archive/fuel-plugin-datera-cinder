Test Plan for Datara-cinder-1.0.0 Fuel Plugin
=============================================

.. contents::
    :depth: 2

Revision history
================

+---------------+---------------------+--------------------------------------------------------------------------+----------------------------------------------+
| **Version**   | **Revision date**   | **Editor**                                                               | **Comment**                                  |
+---------------+---------------------+--------------------------------------------------------------------------+----------------------------------------------+
| 0.1           | 23.01.2015          | Irina Povolotskaya                                                       | Created the template structure.              |
|               |                     |                                                                          |                                              |
|               |                     | (`*ipovolotskaya@mirantis.com* <mailto:ipovolotskaya@mirantis.com>`__)   |                                              |
+---------------+---------------------+--------------------------------------------------------------------------+----------------------------------------------+
| 1.0           | 28.03.2016          | Funs Kessen <`*ftk@datera.io* <mailto:ttk@datera.io>`__>                 | Fuel Plugin Datera Cinder 1.0.0 Test plan.   |
+---------------+---------------------+--------------------------------------------------------------------------+----------------------------------------------+

Datera-Cinder Plugin
====================

The Datera plugin provides a GUI configuration option for Fuel 7.0 and
8.0 to enable configuration of the *cinder.conf* for use with Datera's
Elastic Data Fabric cluster with nodes that receive the Cinder role. The
plugin also provides an updated version of the Datera Cinder driver to
support the v2 API interface, as the v1 API is deprecated.

Developer’s specification
-------------------------

The plugin is designed to integrate the use of Datera EDF by Mirantis
Openstack 7.0 and Mirantis Openstack 8.0 by leveraging Fuel 7.0 and Fuel
8.0.

For more details view the specs/fuel-plugin-datera-cinder.rst

Limitations
-----------

Mirantis Fuel 7.0 does not support cinder with multiple backends.

**Prerequisites**

A configured and running Datera EDF cluster or training VM, attached to
the appropriate networks.

Test strategy
=============

The Datera Fuel plugin should add the correct components to
*cinder.conf* resulting in a functional *cinder.conf.* This means that
all the required options should be exposed in the respective Fuel UI
level for Datera and be transferred into the *cinder.conf*. The Datera
Cinder driver that supports the v2 API should also be deployed.

All tests will be done for both Fuel 7.0 and 8.0.

Acceptance criteria
-------------------

The final result should be a functioning Mirantis Fuel 7.0 and Mirantis
Fuel 8.0 Openstack deployment with Datera EDF enabled and the ability to
consume storage from Datera EDF.

Test environment, infrastructure and tools
------------------------------------------

The test environments were run on KVM where 7 VMs were used with 5
network interfaces per VM attached to 5 separate virtual networks.

The Storage network is placed on one of the NICs in a separate VLAN, 102
with it's own subnet, 192.168.42.0/24.

Test Environment Fuel 7.0
~~~~~~~~~~~~~~~~~~~~~~~~~

+----------+-------------------------+------------+-----------+------------------+-----------------+
| **VM**   | **Description**         | **vCPU**   | **RAM**   | **HD**           | **OS**          |
+----------+-------------------------+------------+-----------+------------------+-----------------+
| 1        | Fuel 7.0 Master         | 2          | 4 GB      | 75 GB            | CentOS 6.5      |
+----------+-------------------------+------------+-----------+------------------+-----------------+
| 3        | Openstack Controllers   | 2          | 4 GB      | 3x50 GB          | Ubuntu          |
+----------+-------------------------+------------+-----------+------------------+-----------------+
| 2        | Openstack Compute       | 2          | 4 GB      | 3x50 GB          | Ubuntu          |
+----------+-------------------------+------------+-----------+------------------+-----------------+
| 1        | Datera EDF Sim.         | 2          | 4 GB      | 64 GB + 100 GB   | DaterOS 1.0.1   |
+----------+-------------------------+------------+-----------+------------------+-----------------+

Test Environment Fuel 8.0
~~~~~~~~~~~~~~~~~~~~~~~~~

+----------+------------------------+------------+-----------+------------------+-----------------+
| **VM**   | **Description**        | **vCPU**   | **RAM**   | **HD**           | **OS**          |
+----------+------------------------+------------+-----------+------------------+-----------------+
| 1        | Fuel 8.0 Master        | 2          | 4 GB      | 75 GB            | CentOS 7.1      |
+----------+------------------------+------------+-----------+------------------+-----------------+
| 3        | Openstack Controller   | 2          | 4 GB      | 3x50 GB          | Ubuntu          |
+----------+------------------------+------------+-----------+------------------+-----------------+
| 2        | Openstack Compute      | 2          | 4 GB      | 3x50 GB          | Ubuntu          |
+----------+------------------------+------------+-----------+------------------+-----------------+
| 1        | Datera EDF Sim.        | 2          | 4 GB      | 64 GB + 100 GB   | DaterOS 1.0.1   |
+----------+------------------------+------------+-----------+------------------+-----------------+

Product compatibility matrix
----------------------------

+-------------------------------------+----------------+---------------------+
| Fuel Plugin Datera Cinder version   | Fuel Version   | Openstack Version   |
+-------------------------------------+----------------+---------------------+
| 1.0.0                               | 7.0            | Kilo                |
+-------------------------------------+----------------+---------------------+
| 1.0.0                               | 8.0            | Liberty             |
+-------------------------------------+----------------+---------------------+

System testing
==============

**1. Install plugin and deploy environment**
--------------------------------------------

+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Test Case ID      | install\_plugin\_deploy\_env                                                                                                                                  |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Steps             | 1. Upload the plugin to the master node.                                                                                                                      |
|                   |                                                                                                                                                               |
|                   | 2. Install the plugin.                                                                                                                                        |
|                   |                                                                                                                                                               |
|                   | 3. Create an environment with the plugin enabled.                                                                                                             |
|                   |                                                                                                                                                               |
|                   | 4. Add 3 nodes with the Controller and Cinder role, 2 node with Compute.                                                                                      |
|                   |                                                                                                                                                               |
|                   | 5. Deploy the cluster.                                                                                                                                        |
|                   |                                                                                                                                                               |
|                   | 6. Run OSTF and network verification.                                                                                                                         |
|                   |                                                                                                                                                               |
|                   | 7. Verify Datera API for creation and deletion of Volumes.                                                                                                    |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Expected Result   | *Plugin is installed successfully, cluster is created, network verification and OSTF are passed, and all plugin services are enabled and work as expected.*   |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------+

**2. Modifying env with an enabled plugin (removing/adding controller nodes)**
------------------------------------------------------------------------------

+-------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Test Case ID      | modify\_env\_with\_plugin\_remove\_add\_controller                                                                                                                                                                           |
+-------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Steps             | 1.  Upload the plugin to the master node.                                                                                                                                                                                    |
|                   |                                                                                                                                                                                                                              |
|                   | 2.  Install the plugin.                                                                                                                                                                                                      |
|                   |                                                                                                                                                                                                                              |
|                   | 3.  Ensure that the plugin is installed successfully using the CLI.                                                                                                                                                          |
|                   |                                                                                                                                                                                                                              |
|                   | 4.  Create an environment with the plugin enabled.                                                                                                                                                                           |
|                   |                                                                                                                                                                                                                              |
|                   | 5.  Add 3 nodes with the Controller and Cinder role, 2 node with Compute.                                                                                                                                                    |
|                   |                                                                                                                                                                                                                              |
|                   | 6.  Deploy the cluster.                                                                                                                                                                                                      |
|                   |                                                                                                                                                                                                                              |
|                   | 7.  Run OSTF and network verification.                                                                                                                                                                                       |
|                   |                                                                                                                                                                                                                              |
|                   | 8.  Verify Datera API for creation and deletion of Volumes.                                                                                                                                                                  |
|                   |                                                                                                                                                                                                                              |
|                   | 9.  Remove 1 node with the Controller and Cinder roles.                                                                                                                                                                      |
|                   |                                                                                                                                                                                                                              |
|                   |     /\*Remove a node, where the plugin’s services available, to ensure that according to ha mode all the plugins resources will be replaced and available on another live node and continue to work as expected \*/          |
|                   |                                                                                                                                                                                                                              |
|                   | 10. Deploy changes to Fuel.                                                                                                                                                                                                  |
|                   |                                                                                                                                                                                                                              |
|                   | 11. Run OSTF and network verification.                                                                                                                                                                                       |
|                   |                                                                                                                                                                                                                              |
|                   | 12. Verify Datera API for creation and deletion of Volumes.                                                                                                                                                                  |
|                   |                                                                                                                                                                                                                              |
|                   | 13. Add 1 new node with the Controller and Cinder roles (\*remark).                                                                                                                                                          |
|                   |                                                                                                                                                                                                                              |
|                   | 14. Deploy changes to Fuel.                                                                                                                                                                                                  |
|                   |                                                                                                                                                                                                                              |
|                   | 15. Run OSTF and network verification.                                                                                                                                                                                       |
|                   |                                                                                                                                                                                                                              |
|                   | 16. Verify Datera API for creation and deletion of Volumes.                                                                                                                                                                  |
+-------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Expected Result   | *Plugin is installed successfully, cluster is created, network verification and OSTF are passed, all plugin services are enabled after migration in ha mode and worked as expected after modification of the environment.*   |
+-------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Remark            | Make sure when doing this manually the network settings are in line with the rest of the cluster, as Fuel does not take of this for you!.                                                                                    |
+-------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

3. Modifying env with an enabled plugin (removing/adding compute node)
----------------------------------------------------------------------

+-------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Test Case ID      | modify\_env\_with\_plugin\_remove\_add\_compute                                                                                                                                                                              |
+-------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Steps             | 1.  Upload the plugin to the master node.                                                                                                                                                                                    |
|                   |                                                                                                                                                                                                                              |
|                   | 2.  Install the plugin.                                                                                                                                                                                                      |
|                   |                                                                                                                                                                                                                              |
|                   | 3.  Ensure that the plugin is installed successfully using the CLI.                                                                                                                                                          |
|                   |                                                                                                                                                                                                                              |
|                   | 4.  Create an environment with the plugin enabled.                                                                                                                                                                           |
|                   |                                                                                                                                                                                                                              |
|                   | 5.  Add 3 nodes with the Controller and Cinder role and 2 nodes with Compute role.                                                                                                                                           |
|                   |                                                                                                                                                                                                                              |
|                   | 6.  Deploy the cluster.                                                                                                                                                                                                      |
|                   |                                                                                                                                                                                                                              |
|                   | 7.  Run OSTF and network verification.                                                                                                                                                                                       |
|                   |                                                                                                                                                                                                                              |
|                   | 8.  Verify Datera API for creation and deletion of Volumes.                                                                                                                                                                  |
|                   |                                                                                                                                                                                                                              |
|                   | 9.  Remove 1 Compute node.                                                                                                                                                                                                   |
|                   |                                                                                                                                                                                                                              |
|                   | 10. Deploy the cluster.                                                                                                                                                                                                      |
|                   |                                                                                                                                                                                                                              |
|                   | 11. Run OSTF and network verification.                                                                                                                                                                                       |
|                   |                                                                                                                                                                                                                              |
|                   | 12. Verify Datera API for creation and deletion of Volumes.                                                                                                                                                                  |
|                   |                                                                                                                                                                                                                              |
|                   | 13. Add 1 Compute node.                                                                                                                                                                                                      |
|                   |                                                                                                                                                                                                                              |
|                   | 14. Deploy the cluster.                                                                                                                                                                                                      |
|                   |                                                                                                                                                                                                                              |
|                   | 15. Run OSTF and network verification.                                                                                                                                                                                       |
|                   |                                                                                                                                                                                                                              |
|                   | 16. Verify Datera API for creation and deletion of Volumes.                                                                                                                                                                  |
+-------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Expected Result   | *Plugin is installed successfully, cluster is created, network verification and OSTF are passed, all plugin services are enabled after migration in ha mode and worked as expected after modification of the environment.*   |
+-------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

**4. Uninstall of the plugin with a deployed environment**
----------------------------------------------------------

+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Test Case ID      | uninstall\_plugin\_with\_deployed\_env                                                                                                                                                                               |
+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Steps             | 1.  Upload the plugin to the master node.                                                                                                                                                                            |
|                   |                                                                                                                                                                                                                      |
|                   | 2.  Install the plugin.                                                                                                                                                                                              |
|                   |                                                                                                                                                                                                                      |
|                   | 3.  Ensure that the plugin is installed successfully using the CLI.                                                                                                                                                  |
|                   |                                                                                                                                                                                                                      |
|                   | 4.  Create an environment with the plugin enabled.                                                                                                                                                                   |
|                   |                                                                                                                                                                                                                      |
|                   | 5.  Add 3 nodes with the Controller and Cinder role and 2 nodes with Compute role.                                                                                                                                   |
|                   |                                                                                                                                                                                                                      |
|                   | 6.  Deploy the cluster.                                                                                                                                                                                              |
|                   |                                                                                                                                                                                                                      |
|                   | 7.  Run OSTF and network verification.                                                                                                                                                                               |
|                   |                                                                                                                                                                                                                      |
|                   | 8.  Try to delete the plugin and ensure that the following alert is show on the CLI "400 Client Error: Bad Request (Can't delete plugin which is enabled for some environment.)"                                     |
|                   |                                                                                                                                                                                                                      |
|                   | 9.  Remove environment                                                                                                                                                                                               |
|                   |                                                                                                                                                                                                                      |
|                   | 10. Remove plugin                                                                                                                                                                                                    |
|                   |                                                                                                                                                                                                                      |
|                   | 11. Check that it was successfully removed                                                                                                                                                                           |
+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Expected Result   | Plugin was installed successfully. Alert is present when attempting to delete the plugin which is attached to an enabled environment. When the environment was removed the plugin was removed successfully too.      |
+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

**5. Uninstall of the plugin**
------------------------------

+-------------------+----------------------------------------------------------------------+
| Test Case ID      | uninstall\_plugin                                                    |
+-------------------+----------------------------------------------------------------------+
| Steps             | 1. Upload the plugin to the master node.                             |
|                   |                                                                      |
|                   | 2. Install the plugin.                                               |
|                   |                                                                      |
|                   | 3. Ensure that the plugin is installed successfully using the CLI.   |
|                   |                                                                      |
|                   | 4. Remove the plugin                                                 |
|                   |                                                                      |
|                   | 5. Check that it was successfully removed                            |
+-------------------+----------------------------------------------------------------------+
| Expected Result   | *Plugin was installed and then removed successfully.*                |
+-------------------+----------------------------------------------------------------------+
