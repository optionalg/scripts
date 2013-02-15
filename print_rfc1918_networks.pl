#!/usr/bin/perl
# print_rfc1918_networks.pl
# Accepts input as a Cisco routing table (eg. show ip bgp) and prints
# the RFC1918 networks to stdout. Example input syntax:
#
#    Network          Next Hop            Metric LocPrf Weight Path
# *> 10.180.6.0/24    66.195.34.17                           0 4323 4323 ?
#

if($#ARGV lt 0) {
  print "Usage: print_rfc1918_networks.pl <input_filename>\n";
  exit;
}

open BGPTABLE, "<", $ARGV[0] or die $!;
while(<BGPTABLE>) {
  if(m/^\*>\s.*/) {
    my @line = split /\s/, $_;
    if($line[1] =~ m/^10|^172\.[16..31]|^192\.168/) {
      print "$line[1]\n";
    }
  }
}
print "\n";
