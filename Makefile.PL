use ExtUtils::MakeMaker;

# $Id: Makefile.PL,v 1.3 2003/11/03 20:38:33 jonasbn Exp $

WriteMakefile(
    'NAME'	        => 'Module::Info::File',
    'VERSION_FROM'  => 'lib/Module/Info/File.pm', # finds $VERSION
	'PREREQ_PM' => {
		'Module::Info'   => '0.20',
		'File::Basename' => 0,
		'Test::Harness'  => 0,
		'Test::More'     => 0,
		'Data::Dumper'   => 0,
	}
);