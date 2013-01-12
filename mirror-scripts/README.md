mirror-scripts
--------------
Roger Ignazio, rignazio at gmail dot com

Overview
--------
These are scripts I use to mirror specific projects and releases to a private
(not publicly accessible) mirror on a LAN to save on disk space. For example,
internally we use CentOS 5 and 6 and have no need to mirror prior releases.

As distributed, these scripts are NOT SUITABLE FOR BECOMING A PUBLIC MIRROR.
They should be modified to meet the specifications of the project you're
mirroring if you intend to:
1. fully mirror a project or repository
2. become a public mirror

See the MIRRORING section below.


Configuration
-------------
Each script has variables specific to that mirror script. For example:

*   MIRROR    Should be set to the server you're going to rsync against
*   BASEDIR   Is the local directory on your server where data should be stored.
*   RELEASES  If applicable, specify the major release(s) to mirror
*   LOCKFILE  Location accessible by the user running the mirror script to store
              a temp file. This ensures only one instance of the script is
              running at a time. You could also modify the script to use 'flock'
              see `flock (1)` for more information.
            
Once the mirror scripts are to your liking and your initial syncs are complete,
you can automate the process with 'cron'. An example crontab is below:

    # mirror-scripts example crontab
    # m h dom mon dow   command
    0 1 * * *   sleep $(expr $RANDOM \% 900); /root/mirror-scripts/centos.sh
    0 2 * * *   sleep $(expr $RANDOM \% 900); /root/mirror-scripts/epel.sh
    0 3 * * *   sleep $(expr $RANDOM \% 900); /root/mirror-scripts/cpan.sh
    0 4 * * *   sleep $(expr $RANDOM \% 900); /root/mirror-scripts/repoforge.sh
    0 5 * * *   sleep $(expr $RANDOM \% 900); /root/mirror-scripts/puppetlabs.sh

It's a good idea to use 'sleep $(expr $RANDOM \% 900)' to offset the start time
of the rsync job. This will cause the script to start at the designated time,
plus a random time in seconds, but no later than 15 minutes after it is
scheduled to run in cron. Modify this to suit your needs.


Mirroring
---------
Becoming a public mirror is something you should consider if you have available
disk space and bandwidth. Typically, each project has specific instructions
they like new mirrors and mirror admins to follow. More information on becoming
a public mirror is available at the links below:

*   [http://www.centos.org/modules/tinycontent/index.php?id=22](http://www.centos.org/modules/tinycontent/index.php?id=22)
*   [http://www.cpan.org/misc/how-to-mirror.html](http://www.cpan.org/misc/how-to-mirror.html)
*   [http://fedoraproject.org/wiki/Infrastructure/Mirroring](http://fedoraproject.org/wiki/Infrastructure/Mirroring)
