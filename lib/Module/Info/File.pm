package Module::Info::File;

# $Id: File.pm,v 1.3 2003/09/28 09:19:47 jonasbn Exp $

use strict;
use Module::Info;
use vars qw(@ISA $VERSION);

$VERSION = '0.01';
@ISA = qw(Module::Info);

sub new_from_file {
    my($proto, $file) = @_;

    return unless -r $file;

    my $self = bless {}, ref $proto || $proto;

	open(FIN, "<", $file);
    my $name = '';
    while (<FIN>) {
        last if (($name) = $_ =~ m/^package (.*);/);
	}
	close(FIN);
	
	$self->{name} = $name;
	$self->{file} = File::Spec->rel2abs($file);
	
	my $dir = $self->{file};
	$name =~ s[::][/]g;
	$dir =~ s[/$name.p(m|l)][];
	$self->{dir} = $dir;

    return $self;
}

1;

__END__

=head1 NAME

Module::Info::File

=cut

=head1 SYNOPSIS

my $module = Module::Info::File->new_from_file('path/to/Some/Module.pm');

$mod->name();

$mod->version();

$mod->file();

$mod->inc_dir();

=cut

=head1 DESCRIPTION

=head2 new_from_file

Given a file, it will interpret this as the module you want information
about.  You can also hand it a perl script.

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

=cut

=head1 SEE ALSO

=over 4

=item * 

Module::Info, by Mattia Barbon

=item *

bin/version.pl

=back

=cut

=head1 CAVEATS

The module cannot handle several package definitions in one file and
only uses the first one it encounters.

=head1 AUTHOR

jonasbn E<lt>jonasbn@cpan.orgE<gt>

=cut

=head1 COPYRIGHT

Module::Info::File and related modules are free software and is
released under the Artistic License. See
E<lt>http://www.perl.com/language/misc/Artistic.htmlE<gt> for details.

Module::Info::File is (C) 2003 Jonas B. Nielsen (jonasbn)
E<lt>jonasbn@cpan.orgE<gt>

=cut
