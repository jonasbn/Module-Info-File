#!/usr/bin/perl -w

# $Id: File.t 1428 2004-09-18 17:50:25Z jonasbn $

use strict;
use Test::More tests => 4;
use Module::Info::File;

#test 1
my $path = 't/MultiPackage.pm';
my @mods = Module::Info::File->new_from_file($path);

is(scalar @mods, 3, 'Testing the count of values returned on list context');

#test 2-4
foreach my $m (@mods) {
	if ($m->name eq "MultiPackage") {
		is($m->version, '0.03', "Testing version for MultiPackage");
	} elsif ($m->name eq "SubPackageOne") {
		is($m->version, '0.02', "Testing version for SubPackageOne");
	} elsif ($m->name eq "SubPackageTwo") {
		is($m->version, '0.01', "Testing version for SubPackageTwo");
	} else {
		die ("Something is wrong, please check testfile: MultiPackage.pm");
	}
}
