#!/usr/bin/perl -w

# $Id: Info.t,v 1.1 2003/09/28 09:01:55 jonasbn Exp $

use strict;
use Data::Dumper;
use Test::More tests => 6;
use lib qw(lib);

my $verbose = 0;

#test 1
use_ok('Module::Info');

my $path = 'lib/Module/Info/File.pm';
my $mod = Module::Info->new_from_file($path);

#test 2
isa_ok($mod, 'Module::Info');

#test 3
is($mod->name, '', 'Testing the name');
print STDERR "Name = ".$mod->name."\n" if $verbose;

#test 4
like($mod->version, qr/\d+\.\d+/, 'Testing the version'); 
print STDERR "Version = ".$mod->version."\n" if $verbose;

#test 5
like($mod->file, qr/$path/, 'Testing the file');
print STDERR "File = ".$mod->file."\n" if $verbose;

#test 6
is($mod->inc_dir, '', 'Testing the dir');
print STDERR "Dir = ".$mod->inc_dir."\n" if $verbose;

print STDERR Dumper $mod if $verbose;

exit(0);