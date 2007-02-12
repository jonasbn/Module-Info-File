# Build.PL for Module::Info::File

# $Id: Build.PL,v 1.15 2006/12/07 09:23:35 jbn Exp $

use strict;
use Module::Build;

my $build = Module::Build->new(
	dist_author       => 'Jonas B. Nielsen, <jonasbn@cpan.org>',
	dist_name         => 'Module-Info-File',
	dist_version_from => 'lib/Module/Info/File.pm',
    distribution_type => 'module',
	license           => 'perl',
    recursive_test_files => 1,
	requires => {
		'Module::Info'   => '0.20',
		'File::Spec'     => 0,
		'Test::Harness'  => 0, #core
		'Test::More'     => 0, #core
		'Data::Dumper'   => 0, #core
		'UNIVERSAL'      => 0, #core
		'Carp'           => 0, #core
	},
    no_index => {
        directory => [ 'drafts', 't' ],
    },
	create_makefile_pl => 'traditional',
);
$build->create_build_script();

1;
