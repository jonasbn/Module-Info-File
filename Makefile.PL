#Makefile.PL for Module::Info::File

# $Id: Makefile.PL 1256 2004-02-28 14:10:51Z jonasbn $

use strict;
use ExtUtils::MakeMaker qw(WriteMakefile);

# The names of the executables
my @programs_to_install = qw(version.pl);

WriteMakefile(
	'AUTHOR'		=> 'Jonas B. Nielsen (jonasbn) <jonasbn@cpan.org>',
    'NAME'			=> 'Module::Info::File',
    'VERSION_FROM'  => 'lib/Module/Info/File.pm', # finds $VERSION
    'EXE_FILES'     => [ map "bin/$_", @programs_to_install ],
	'PREREQ_PM'     => {
		'Module::Info'   => '0.20',
		'File::Basename' => 0,
		'File::Spec'     => 0,
		'Test::Harness'  => 0,
		'Test::More'     => 0,
		'Data::Dumper'   => 0,
	},
);
