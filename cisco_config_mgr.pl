#!/usr/bin/perl -w
# cisco_config_mgr.pl
# Uploads/downloads config files to/from Cisco network devices using SNMP
# and the Cisco::CopyConfig CPAN module.

use strict;
use Net::SNMP;
use Cisco::CopyConfig;
use Getopt::Std;

my %opts;
getopts('m:h:c:s:f:', \%opts);
if(defined $opts{m} and $opts{h} and $opts{c} and $opts{s} and $opts{f}) {
    my $mode      = $opts{m};
    my $host      = $opts{h};
    my $community = $opts{c};
    my $server    = $opts{s};
    my $filename  = $opts{f};

    my $config = Cisco::CopyConfig ->new(
                    Host => $host,
                    Comm => $community
    );

    if($mode eq "down") {
        if($config->copy($server, $filename)) {
            print "OK.\n";
        }
        else {
            $config->error();
        }
    }
    elsif($mode eq "up") {
        if($config->merge($server, $filename)) {
            print "OK.\n";
        }
        else {
            $config->error();
        }
    }
    else {
        print "Error: invalid mode.\n";
        &usage();
    }

    print "\n";
}

else {
    print "Error: missing one or more arguments.\n";
    &usage();
}

sub usage {
  print "
Usage: cisco_config_mgr.pl <args>
    -m up/down          File transfer mode (upload/download) to/from TFTP server
    -h host             Hostname or IP address for network device
    -c community        SNMP write community
    -s server           TFTP server
    -f filename         Filename on the TFTP server

";
  exit;
}
