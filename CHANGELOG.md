postgresql Cookbook CHANGELOG
=============================
This file is used to list changes made in each version of the postgresql cookbook.

v3.4.18
------
- Revert changes from #201 with the intention of revisiting these changes as part of the next major version release.
- Specify version constraint on openssl cookbook due to an upstream release mishap

v3.4.16
------
- Changed hard coded value to attribute #219
- Correction for directory creation under debian, etc. #222
- Fedora 20 yum support #223
- Define version-sensitive attributes in a recipe #201

v3.4.14
------
- Support apt repository for Ubuntu Utopic 14.10
- Do not try and set password on standby hosts

v3.4.12
------
- Create configuration templates at the appropriate time
- If template is updated restart service changed to default of :delayed
- Fix SSL for PostgreSQL versions < 9.2

v3.4.10
-------
- correct conditional error created in 3.4.8.

v3.4.8
------
- Correct scenario where work_mem could be set to 0 if con is greater than mem Issue #185
- Add Centos7 suites to kitchen configuration

v3.4.6
------
- Don't include the pgdg recipes on the wrong machine types
- Add missing dir /etc/sysconfig/pgsl for centos7
- CentOS 7 package support

v3.4.4
------
- fix packages on SLES11SP2 and higher
- Add flag to control database user password behavior
- add amazon platform rpm info
- Fix issues with the server_redhat recipe on Fedora 16 and later
- attribute typo correction
- correctly check and set max_connections to an integer

v3.4.2
------
- Changed the Gem::Installer::ExtensionBuildError to a Mixlib::ShellOut::ShellCommandFailed

v3.4.1
------
- Added support for Ubuntu 14.04 and Postgresql 9.3

v3.4.0
------
Updated CONTRIBUTING document.
Refreshed test kitchen configuration.
Merged Pull Requests: 122, 116, 104, 102, 99, 96, 93, 90.



