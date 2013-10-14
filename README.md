# Scripts
These are various scripts I've written.

####git-hooks/
Scripts to be used as hooks for the Git version control system.

####init/
Scripts to control utilities starting/stopping, written with chkconfig in mind.

####mirror-scripts/
Scripts to mirror popular projects on a private mirror on your LAN. See mirror-scripts/README for more info.

####vmware/
Various VMware management scripts written using the vSphere SDK for Perl.

####cisco\_config\_mgr.pl
Uploads/downloads config files to/from Cisco network devices using SNMP and the Cisco::CopyConfig CPAN module. 

####csv\_to\_wikitable.pl
Converts CSV and other delimited spreadsheets to wiki syntax.

####mysql\_backup.sh
Runs mysqldump against a list of databases and gzip's the result

####nessus-reporter.pl
Accepts a .nessus v2 file as input and returns per-host vulnerability counts, categorized by crit/high/med/low.

####print\_rfc1918\_networks.pl
Takes a Cisco routing table (such as `sh ip bgp`) and prints only the RFC 1918 networks.
