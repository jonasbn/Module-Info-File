use ExtUtils::MakeMaker;

# $Id: Makefile.PL,v 1.4 2004/01/10 20:04:15 jonasbn Exp $

WriteMakefile(
    'NAME'	        => 'Module::Info::File',
    'VERSION_FROM'  => 'lib/Module/Info/File.pm', # finds $VERSION
	'PREREQ_PM' => {
		'Module::Info'   => '0.20',
		'File::Basename' => 0,
		'File::Spec'     => 0,
		'Test::Harness'  => 0,
		'Test::More'     => 0,
		'Data::Dumper'   => 0,
	}
);