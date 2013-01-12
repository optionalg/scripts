#!/usr/bin/perl
# cointoss.pl, for when you just can't find a quarter.

$count = $ARGV[0];
$heads = $tails = 0;

if($count > 0) {
	for($i = 0; $i < $count; $i++) {
		int(rand(2)) eq 0 ? $heads++ : $tails++;
	}
	print "Heads: $heads\tTails: $tails\n";
}
else {
	print "Usage: cointoss.pl <count>\n";
}
