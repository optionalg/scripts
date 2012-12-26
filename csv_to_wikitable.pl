#!/usr/bin/perl
# csv_to_wikitable.pl
# Takes CSV and other delimited files as input, and writes a Mediawiki table to
# STDOUT. Usage: csv_to_wikitable.pl <input_filename>

# Options
$delimiter = ',';               # The field delimiter, such as , ^ or :
$headings = 1;                  # First line of file contains column headings
$class = "wikitable sortable";  # See http://en.wikipedia.org/wiki/Help:Table

# Main
if($#ARGV lt 0) {
	print "Usage: csv_to_wikitable <input_filename>\n";
	exit;
}
$input_file = $ARGV[0];
open INPUT_FILE, "<", $input_file or die "$!";

$line_count = 0;
print "{| class=\"$class\"\n"; 
while (<INPUT_FILE>) {
	if($column_headings && $line_count eq 0) {
		s/^(.*)$/! $1/;
		s/(\w*)$delimiter/$1 !! /g;
		$line_count++;
	}
	else {
		s/^(.*)$/| $1/;
		s/(\w*)$delimiter/$1 || /g;
	}
	s/\n/\n|-\n/;
	print $_;
}
print "|}\n";

