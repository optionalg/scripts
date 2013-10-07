#!/usr/bin/perl
# snapshotsenum.pl
# Enumerates vSphere snapshots and prompts the user to delete them.

# This script requires the vSphere SDK for Perl.
# http://www.vmware.com/support/developer/viperltoolkit/

# A few TODO items:
#  . Currently, the script will wait until the snapshot is removed before
#    continuing or producing output, whereas the vSphere Client has no such
#    restriction. There's probably a better way to implement this.
#  . List the names of the snapshots that are present for each VM so the
#    admin can make an informed decision on if they can be deleted.

#use warnings;
use strict;
use VMware::VIRuntime;

# Disable certificate validation otherwise we'll fail if using self-signed certs
$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;

# Prompt for vCenter or ESXi server and set environment variable.
print "Enter hostname of vCenter or ESXi server: ";
my $server = <>;
chomp $server;
$ENV{VI_SERVER} = $server;

Opts::parse();
Opts::validate();
Util::connect();

my $snapshots_exist = 0;

print "\nFinding snapshots...\n";
my $vm_in_inv = Vim::find_entity_views(view_type => 'VirtualMachine');
foreach(@$vm_in_inv) {
    my $snapshots = $_->snapshot;
    if(defined $snapshots) {
        $snapshots_exist++;
        print "Snapshots exist for virtual machine " . $_->name . "\n";
    }
}
if($snapshots_exist) {
    print "\n\nWould you like to remove all snapshots? [yes/NO]: ";
    my $remove_snapshots = <>;
    chomp $remove_snapshots;
    if($remove_snapshots =~ /[yes|y|Y]/) {
        foreach(@$vm_in_inv) {
            my $snapshots = $_->snapshot;
            if(defined $snapshots) {
                eval {
                    print "\nRemoving snapshots for " . $_->name . " ... ";
                    $_->RemoveAllSnapshots();
                    $@ ? print "Failed.\n" : print "Done.\n";
                }
            }
        }
        print "\n";
    }
    else {
        print "\nNot removing snapshots.\n\n";
    }
}
else {
    print "\nNo snapshots were found.\n\n";
}

Util::disconnect();

