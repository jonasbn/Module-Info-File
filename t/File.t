#!/usr/bin/perl -w

# $Id: File.t,v 1.3 2003/11/03 20:38:33 jonasbn Exp $

use strict;
use Data::Dumper;
use Test::More tests => 7;
use File::Basename;
use lib qw(lib);

my $verbose = 0;

#test 1
use_ok('Module::Info::File');

my $path = 'lib/Module/Info/File.pm';
my $mod = Module::Info::File->new_from_file($path);

#test 2
isa_ok($mod, 'Module::Info::File');

#test 3
isa_ok($mod, 'Module::Info');

#test 4
is($mod->name, 'Module::Info::File', 'Testing the name');
print STDERR "Name = ".$mod->name."\n" if $verbose;

#test 5
like($mod->version, qr/\d+\.\d+/, 'Testing the version'); 
print STDERR "Version = ".$mod->version."\n" if $verbose;

#test 6
my ($name,$v,$suffix) = fileparse($path,"\.pm");
fileparse_set_fstype($^O);

like($mod->file, qr/$name$suffix/, 'Testing the file');
print STDERR "File = ".$mod->file."\n" if $verbose;

#test 7
like($mod->inc_dir, qr/\w+/, 'Testing the dir');
print STDERR "Dir = ".$mod->inc_dir."\n" if $verbose;

print STDERR Dumper $mod if $verbose;

exit(0);