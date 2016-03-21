
 This work is licensed under the Apache License, Version 2.0.

 http://www.apache.org/licenses/LICENSE-2.0

==================================================
Fuel plugin for Datera as a Cinder backend
==================================================

The Datera plugin for Fuel extends Mirantis OpenStack functionality by adding
support for Datera EBS in Cinder using the iSCSI protocol.

Problem description
===================

Currently, Fuel has no support for Datera EBS as block storage for
OpenStack environments. The Datera plugin aims to provide support for it.

Proposed change
===============

Implement a Fuel plugin that will configure the Datera driver for
Cinder on all Controller nodes. 

Alternatives
------------

None

Data model impact
-----------------

None

REST API impact
---------------

None

Upgrade impact
--------------

None

Security impact
---------------

None

Notifications impact
--------------------

None

Other end user impact
---------------------

None

Performance Impact
------------------

The Datera EBS provides high performance block storage for OpenStack 
environments, and therefore enabling the Datera driver in OpenStack
will greatly improve the peformance of OpenStack.

Other deployer impact
---------------------

The deployer should make sure the IP of the management VIP is correct, prior
to deploying the Fuel plugin to the controllers. If this is not done the VIP
needs to altered and the cinder service will have to be restarted.

Developer impact
----------------

None

Implementation
==============

The plugin generates the approriate cinder.conf stanzas to enable the Datera
within OpenStack. There are NO other packages required, the Datera driver
which is included in the OpenStack distribution is all that is necessary.

Plugin has two tasks. Each task per role. They are run in the following order:

* The first task installs and configures cinder-volume on Primary Controller.
* The second task installs and configures cinder-volume on Controller nodes.

Cinder-volume service is installed on all Controller nodes and is managed by
Pacemaker. It runs in active/passive mode where only one instance is active.
All instances of cinder-volume have the same “host” parameter in cinder.conf
file. This is required to achieve ability to manage all volumes in the
environment by any cinder-volume instance.

Assignee(s)
-----------

| Funs <funs@barred.org>

Work Items
----------

* Implement the Fuel plugin.
* Implement the Puppet manifests.
* Testing.
* Write the documentation.

Dependencies
============

* Fuel 7.0 and higher.

Testing
=======

* Prepare a test plan.
* Test the plugin by deploying environments with all Fuel deployment modes.

Documentation Impact
====================

* Deployment Guide (how to install the storage backends, how to prepare an
  environment for installation, how to install the plugin, how to deploy an
  OpenStack environment with the plugin).
* User Guide (which features the plugin provides, how to use them in the
  deployed OpenStack environment).
* Test Plan.
* Test Report.

