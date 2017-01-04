#!/usr/bin/perl -w

use strict;
use Data::Dumper;
use Test::More tests => 13;
use File::Basename;
use lib qw(lib);

use Env qw($TEST_VERBOSE);

#test 1
BEGIN { use_ok('Module::Info::File'); }

my $path = 'lib/Module/Info/File.pm';
my $mod = Module::Info::File->new_from_file($path);

#test 2
isa_ok($mod, 'Module::Info::File');

#test 3
isa_ok($mod, 'Module::Info');

#test 4
can_ok($mod, qw(new_from_module new_from_loaded));

#test 4
is($mod->name, 'Module::Info::File', 'Testing the name');
diag "Name = ".$mod->name."\n" if $TEST_VERBOSE;

#test 5
like($mod->version, qr/^\d+\.\d+$/, 'Testing the version'); 
diag "Version = ".$mod->version."\n" if $TEST_VERBOSE;

#test 6
my ($name,$v,$suffix) = fileparse($path,"\.pm");
fileparse_set_fstype($^O);

like($mod->file, qr/$name$suffix/, 'Testing the file');
diag "File = ".$mod->file."\n" if $TEST_VERBOSE;

#test 7
like($mod->inc_dir, qr/\w+/, 'Testing the dir');
diag "Dir = ".$mod->inc_dir."\n" if $TEST_VERBOSE;

diag Dumper $mod if $TEST_VERBOSE;

#test 8
$path = 'lib/Module/Info/File.pm';
my @mods = Module::Info::File->new_from_file($path);

is(scalar @mods, 1, 'Testing the count of values returned on list context');

#test 9-12
{
	foreach my $m (@mods) {
		like($m->name, qr/\w+/, 'Testing the name');
		like($m->version, qr/\d+\.\d+/, 'Testing the version');
		like($m->inc_dir, qr/\w+/, 'Testing the dir');
		my ($name,$v,$suffix) = fileparse($path,"\.pm");
		fileparse_set_fstype($^O);
		like($m->file, qr/$name$suffix/, 'Testing the file');
	}
}

diag Dumper \@mods if $TEST_VERBOSE;

exit(0);
