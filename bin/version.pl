#!/usr/bin/perl -w

# $Id: version.pl,v 1.3 2004/01/10 20:04:15 jonasbn Exp $

use strict;
use Module::Info::File;
use Data::Dumper;
use vars qw($VERSION);

$VERSION = '0.02';

my $debug = 0;
my $modulepath;

if ($ARGV[0]) {
	$modulepath = $ARGV[0];
} else {
	usage();
}

my $m;
if ($modulepath =~ m/::/) {
	$m = Module::Info::File->new_from_module($modulepath);
} elsif (-f $modulepath) {
	$m = Module::Info::File->new_from_file($modulepath);
} else {
	$m = Module::Info::File->new_from_module($modulepath);
}

print STDERR Dumper $m if $debug;

if (ref $m) {

	my $version = $m->version || 'N/A';

	print $m->name." located in ".$m->inc_dir." is version: ".$version."\n";
} else {
	print STDERR "Unable to locate module $ARGV[0]\n";
}
exit(0);

sub usage {
	print "Usage: version.pl [<modulename>] [<modulepath>]\n";
	exit(0);
}

__END__

=head1 NAME

version.pl - extracts module data from installed and uninstalled modules

=head1 SYNOPSIS

% version.pl DBI

% version.pl XML::Simple

% version.pl ~jonasbn/Develop/Games/Bingo/lib/Games/Bingo.pm

% version.pl version.pl

=cut

=head1 DESCRIPTION

The script takes either a module name (SEE SYNOPSIS) or a path to a
Perl module or script file.

The script looks for a B<package> definition and a version file.

The script is quite simple, the Module::Info::File and Mattia Barbon's
Module::Info holds all the interesting stuff.

In the beginning I was using Module::Info, but due to a lacking
functionality in this module I created Module::Info::File, which
inherits from Module::Info and replaces the B<new_from_file> method so
the lacking data can be accessed. Apart from that you can use all the
neat accessors from Module::Info. 

=cut

=head1 SEE ALSO

=over 4

=item Module::Info

=item Module::Info::File

=back

=cut

=head1 AUTHOR

jonasbn E<lt>jonasbn@cpan.orgE<gt>

=cut

=head1 COPYRIGHT

version.pl is free software and is released under
the Artistic License. See
E<lt>http://www.perl.com/language/misc/Artistic.htmlE<gt> for details.

version.pl is (C) 2003 Jonas B. Nielsen (jonasbn)
E<lt>jonasbn@cpan.orgE<gt>

=cut