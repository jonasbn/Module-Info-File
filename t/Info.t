#!/usr/bin/perl -w

# $Id: Info.t,v 1.3 2003/12/20 09:24:19 jonasbn Exp $

use strict;
use Data::Dumper;
use Test::More tests => 6;
use File::Basename;
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

if ($mod->name) {
	print STDERR qq[\nIf test 3 failed, Module::Info::File is probably obsolete and can
be discontinued, please inform the author at jonasbn\@cpan.org and include the information
 below\n];
	$verbose = 1;
}
print STDERR "Name = ".$mod->name."\n" if $verbose;

#test 4
like($mod->version, qr/\d+\.\d+/, 'Testing the version');
print STDERR "Version = ".$mod->version."\n" if $verbose;

#test 5
my ($name,$v,$suffix) = fileparse($path,"\.pm");
fileparse_set_fstype($^O);

like($mod->file, qr/$name$suffix/, 'Testing the file');
print STDERR "File = ".$mod->file."\n" if $verbose;

#test 6
is($mod->inc_dir, '', 'Testing the dir');

if ($mod->inc_dir) {
	print STDERR qq[\nIf test 6 failed, Module::Info::File is probably obsolete and can
be discontinued, please inform the author at jonasbn\@cpan.org and include the information
 below\n];
	$verbose = 1;
}
print STDERR "Dir = ".$mod->inc_dir."\n" if $verbose;

print STDERR Dumper $mod if $verbose;

exit(0);
