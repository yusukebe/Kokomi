#!/usr/bin/perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Kokomi;

my $kokomi = Kokomi->new;
$kokomi->generate;
