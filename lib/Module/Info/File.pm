package Module::Info::File;

# $Id: File.pm 1433 2004-09-19 17:00:09Z jonasbn $

use strict;
use Module::Info;
use File::Spec;
use File::Basename qw(fileparse);
use vars qw(@ISA $VERSION);

$VERSION = '0.07';
@ISA = qw(Module::Info);

sub new_from_file {
    my ($proto, $file) = @_;

    return unless -r $file;

	open(FIN, "<$file") or warn "Unable to open file: $file - $!";

	my (@packages, $package, $version, $name, $dir);
	while (<FIN>) {
		#my ($filename, $suffix, $v);
		
		if (($package) = $_ =~ m/^package ([A-Za-z0-9_:]+);/) {
			if ($package) {
				$name = $package;
			} else {
				($name) = $file =~ m/(\w+\.pm)$/;
			}
		
			#if ($file =~ m/\.pl$/) {
			#	($filename,$v,$suffix) = fileparse($file,"\.pl");
			#} elsif ($file =~ m/\.pm$/) {
			#	($filename,$v,$suffix) = fileparse($file,"\.pm");
			#}

			$dir = File::Spec->rel2abs($file);
			$dir =~ s[/(\w+\.p(m|l))$][];

		}
		if ((my ($v) = $_ =~ m/VERSION = '*([0-9_.]+)'*;/)) {
			$version = $v || 'N/A';
		}

		push @packages, __PACKAGE__->new_from_data(
			name    => $name,
			dir     => $dir,
			file    => $file,
			version => ($version eq 'N/A')?undef:$version,
		) if ($name and $dir and $file and $version);

		$package = '';
		$version = '';
	}
	close(FIN);

	if (wantarray) {
		return @packages;
	} else {
		return pop @packages;
	}
}

sub new_from_data {
	my ($class, %params) = @_;

	my $self = bless {}, $class || ref $class;

	foreach (keys %params) {
		$self->{$_} = $params{$_} || undef;
	}

	return $self;
}

sub version {
	my ($self, $version) = @_;
	
	if ($version) {
		$self->{version} = $version;
		return 1;
	}
	
	if ($self->{version}) {
		return $self->{version};
	} else {
		return $self->SUPER::version();
	}
}

1;

__END__

=head1 NAME

Module::Info::File - retrieves module information from a file or script

=head1 SYNOPSIS

	use Module::Info::File;
	
	my $module = Module::Info::File->new_from_file('path/to/Some/Module.pm');
	
	$mod->name();
	
	$mod->version();
	
	$mod->file();
	
	$mod->inc_dir();
	
	use Module::Info::File;
	
	my @modules = Module::Info::File->new_from_file('path/to/Some/Module.pm');

	foreach my $mod (@modules) {
		print $mod->name() . "\n";
	}

=head1 DESCRIPTION

Module::Info (SEE REFERENCES), are lacking functionality of being able
to extract certain data when parsing a module directly from a file. I
have therefor created Module::Info::File, which inherits from
Module::Info and replaces the B<new_from_file> method so the lacking
data can be accessed (dir and name attributes). Apart from that you can
use all the neat accessors from Module::Info.

In the bin folder in this distribution is a small script called
version.pl, which was the beginning of everything.

=head2 new_from_file

Given a file, it will interpret this as the module you want information
about. You can also hand it a perl script.

After construction has been completed three attributes have been set in
the object:

=over 4

=item *

name

=item *

dir

=item *

file

=back

So by using the inherited methods from B<Module::Info> you can access
the attributes.

There is an example in the bin/ folder called version.pl, this script
was the starting point for this module.

=over 4

=item *

name, returns the package name of the file.

=item *

version, returns the version number of the module/file in question
($VERSION).

=item *

inc_dir, returns the dir attribute

=item *

file, returns the file attribute

=back

Please refer to the documentation on B<Module::Info> for more details.

In list context the module returns and array of Module::Info::File objects, with
which you can use the above accessors. The information in the objects might not
be complete though (SEE: CAVEATS).

In the t/ directory of this distribution there is a test (Info.t), it
includes some tests. These tests will test your installation of
Module::Info (required by Module::Info::File), if the tests fail,
Module::Info::File will be obsolete and can be discontinued.

=head1 SEE ALSO

=over 4

=item * 

Module::Info, by Mattia Barbon

=item *

bin/version.pl

=back

=head1 CAVEATS

The module can somewhat handle several package definitions in one file, but 
the information is not complete yet, such as version information etc.

The method currently only support the following version number lines:

	$VERSION = '0.01';
	
	$VERSION = 0.01;

=head1 ACKNOWLEDGEMENTS

=over 4

=item *

Lars Thegler (LTHEGLER), for not letting me go easily, a patch and suggesting 
the list context variation.

=item *

Thomas Eibner (THOMAS), for reviewing the POD

=item *

Mattia Barbon (MBARBON), for writing Module::Info

=item *

bigj at Perlmonks who mentioned Module::Info

=back

=head1 AUTHOR

jonasbn E<lt>jonasbn@cpan.orgE<gt>

=head1 COPYRIGHT

Module::Info::File and related modules are free software and is
released under the Artistic License. See
E<lt>http://www.perl.com/language/misc/Artistic.htmlE<gt> for details.

Module::Info::File is (C) 2003-2004 Jonas B. Nielsen (jonasbn)
E<lt>jonasbn@cpan.orgE<gt>

=cut
