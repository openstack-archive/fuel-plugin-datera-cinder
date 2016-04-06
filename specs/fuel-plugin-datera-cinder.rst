
 This work is licensed under the Apache License, Version 2.0.

 http://www.apache.org/licenses/LICENSE-2.0

==================================================
Fuel plugin for Datera as a Cinder backend
==================================================

The Datera plugin for Fuel extends Mirantis OpenStack functionality 
by adding support for Datera EDF in Cinder using the iSCSI protocol.

Problem description
===================

Currently, Fuel has no support for Datera EDF as block storage for
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

The Datera EDF provides high performance block storage for OpenStack 
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

The plugin generates the approriate cinder.conf to enable the Datera EDF
within OpenStack. The Datera v2 API driver, which is required as v1 is
deprecated, is bundled with the Fuel plugin.

There are two tasks the plugin performs on nodes with the Cinder role:
* Install the v2 API driver.
* Update cinder.conf to reflect the correct settings enabling the driver.

Assignee(s)
-----------

| Funs <funs@barred.org>

Work Items
----------

* Implement Fuel GUI plugin.
* Implement Puppet manifests for configuration.
* Implement Puppet manifests for driver update.
* Testing.
* Write documentation.

Dependencies
============

* Fuel 7.0 and 8.0.

Testing
=======

* Prepare a test plan.
* Test the plugin by deploying environments.

Documentation Impact
====================

* Deployment Guide:
    - Installing the Datera Fuel plugin.
    - Setting up the Datera Fuel plugin.
    - Deploy a Mirantis Openstack enviroment backed by Datera.
    - Verify the install.
* Test Plan.
* Test Report.
* User Guide:
    - Features provided by plugin 
    - How to confgure.
