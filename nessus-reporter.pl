#!/usr/bin/perl -w
# Filename:       nessus-reporter.pl
# Description:    Accepts a .nessus v2 file as input and returns per-host
#                 vulnerability counts, categorized by crit/high/med/low.
# Author:         Roger Ignazio <rignazio at gmail dot com>
#
use strict;
use XML::Simple;
use Getopt::Long;
use Switch;
#use Data::Dumper;


our $use_fqdn = our $output_csv = our $file = '';
GetOptions('fqdn' => \$use_fqdn, 'csv' => \$output_csv, 'file=s' => \$file, '<>' => \&usage);

if($file) {
  &main();
}
else {
  &usage();
}


sub main {
  my $low_total = my $med_total = my $high_total = my $crit_total = 0;

  my $in = XMLin($file);
  #print Dumper($in);

  if($output_csv) {
    print "Hostname,Crit,High,Med,Low\n";
  }
  else {
    printf("%-64s %-5s %-5s %-5s %-5s\n", "Hostname", "Crit", "High", "Med", "Low");
  }

  for my $host (keys %{$in->{Report}->{ReportHost}}) {
    my $low = my $med = my $high = my $crit = 0;

    for my $i (@{$in->{Report}->{ReportHost}->{$host}->{ReportItem}}) {
      switch($i->{severity}) {
        case '1' { $low++; }
        case '2' { $med++; }
        case '3' { $high++; }
        case '4' { $crit++; }
      }
    }

    if(!$use_fqdn and $host !~ /^\d/) {
      my @hostparts = split(/\./, $host);
      $host = $hostparts[0];
    }

    if($output_csv) {
      print "$host,$crit,$high,$med,$low\n";
    }
    else {
      printf("%-64s %-5s %-5s %-5s %-5s\n", $host, $crit, $high, $med, $low);
    }

    $low_total  += $low;
    $med_total  += $med;
    $high_total += $high;
    $crit_total += $crit;
  }

  if($output_csv) {
    print "\nTotals,$crit_total,$high_total,$med_total,$low_total\n";
  }
  else {
    printf("\n%-64s %-5s %-5s %-5s %-5s\n", "Totals:", $crit_total, $high_total, $med_total, $low_total);
  }
}


sub usage {
  print "  Usage: ./nessus-reporter.pl [--fqdn] [--csv] --file /path/to/report.nessus\n";
  exit;
}
