use ExtUtils::MakeMaker;

# $Id: Makefile.PL,v 1.2 2003/09/28 09:19:47 jonasbn Exp $

WriteMakefile(
    'NAME'	        => 'Module::Info::File',
    'VERSION_FROM'  => 'lib/Module/Info/File.pm', # finds $VERSION
	'PREREQ_PM' => {
		'Module::Info'  => '0.20',
		'Test::Harness' => 0,
		'Test::More'    => 0,
		'Data::Dumper'  => 0,
	}
);