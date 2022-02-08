#!/usr/bin/perl
use strict;
use warnings;

foreach my $line ( <STDIN> ) {
  $line =~ s/ / \| /g;
  chomp $line;
  print "| $line |\n";
}