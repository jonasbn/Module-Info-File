#!/usr/bin/perl -w

use strict;
use Data::Dumper;
use Test::More tests => 6;
use File::Basename;
use lib qw(lib);

use Env qw($TEST_VERBOSE);

#test 1
use_ok('Module::Info');

my $path = 'lib/Module/Info/File.pm';
my $mod = Module::Info->new_from_file($path);

#test 2
isa_ok($mod, 'Module::Info');

#test 3
is($mod->name, '', 'Testing the name');

if ($mod->name) {
	diag qq[\nIf test 3 failed, Module::Info::File is probably obsolete and can
be discontinued, please inform the author at jonasbn\@cpan.org and include the information
 below\n];
	$TEST_VERBOSE = 1;
}
diag "Name = ".$mod->name."\n" if $TEST_VERBOSE;

#test 4
like($mod->version, qr/\d+\.\d+/, 'Testing the version');
diag "Version = ".$mod->version."\n" if $TEST_VERBOSE;

#test 5
my ($name,$v,$suffix) = fileparse($path,"\.pm");
fileparse_set_fstype($^O);

like($mod->file, qr/$name$suffix/, 'Testing the file');
diag "File = ".$mod->file."\n" if $TEST_VERBOSE;

#test 6
is($mod->inc_dir, '', 'Testing the dir');

if ($mod->inc_dir) {
	diag qq[\nIf test 6 failed, Module::Info::File is probably obsolete and can
be discontinued, please inform the author at jonasbn\@cpan.org and include the information
 below\n];
	$TEST_VERBOSE = 1;
}
diag "Dir = ".$mod->inc_dir."\n" if $TEST_VERBOSE;

diag Dumper $mod if $TEST_VERBOSE;

exit(0);
