#!/usr/bin/perl -w

# $Id: version.pl 1433 2004-09-19 17:00:09Z jonasbn $

use strict;
use File::Find;
use Module::Info::File;
use Data::Dumper;
use vars qw($VERSION);

$VERSION = '0.04';

my $debug = 0;
my $modulepath;

if ($ARGV[0]) {
	$modulepath = $ARGV[0];
} else {
	usage();
}

my @ms;
if ($modulepath =~ m/::/) {
	@ms = Module::Info::File->new_from_module($modulepath);
	foreach my $m (@ms) {
		long($m);
	}
} elsif (-f $modulepath) {
	@ms = Module::Info::File->new_from_file($modulepath);
	foreach my $m (@ms) {
		long($m);
	}
} elsif (-d $modulepath) {
	find(\&simple, $modulepath);
} else {
	@ms = Module::Info::File->new_from_module($modulepath);
	foreach my $m (@ms) {
		long($m);
	}
}

exit(0);

sub simple {
	if ($File::Find::name =~ m/\.pm$/) {

		my @ms = Module::Info::File->new_from_file($_);
		foreach my $m (@ms) {
			print $m->name if $m->name;
			print ";";
			print $m->version if $m->version;
			print "\n";
		}
	}
}

sub long {
	my $m = shift;
	
	print STDERR Dumper $m if $debug;

	if (ref $m) {

		my $version = $m->version || 'N/A';

		print $m->name." located in ".$m->inc_dir." is version: ".$version."\n";
	} else {
		print STDERR "Unable to locate module $ARGV[0]\n";
	}
}

sub usage {
	print "Usage: version.pl [<modulename>] [<modulepath>]\n";
	print "% perldoc version.pl for more information\n";
	exit(1);
}

__END__

=head1 NAME

version.pl - extracts module data from installed and uninstalled modules

=head1 SYNOPSIS

	% version.pl DBI
	
	% version.pl XML::Simple
	
	% version.pl ~jonasbn/Develop/Games/Bingo/lib/Games/Bingo.pm
	
	% version.pl version.pl
	
	% version.pl /System/Library/Perl/5.8.1

=head1 README

This script extracts module data from installed and uninstalled
modules and script, targetting especially the version information.

=head1 DESCRIPTION

The script takes either a module name (SEE SYNOPSIS), a path to a
Perl module, script file or a directory.

The script looks for a B<package> definition and a version variable.

The script is quite simple, the Module::Info::File and Mattia Barbon's
Module::Info holds all the interesting stuff.

In the beginning I was using Module::Info, but due to a lacking
functionality in this module I created Module::Info::File, which
inherits from Module::Info and replaces the B<new_from_file> method so
the lacking data can be accessed. Apart from that you can use all the
neat accessors from Module::Info. 

The script gives to kinds of input depending on how it was called:

For single modules, module og script files:

E<lt>modulenameE<gt> located in E<lt>directory locationE<gt> is
version: E<lt>versions numberE<gt>

Example:

Test::More located in /System/Library/Perl/5.8.1 is version: 0.47

Or when called with a directory as argument (one line per located module):

E<lt>module nameE<gt> E<lt>tabE<gt> E<lt>version numberE<gt>

Example:

DBI;1.38
Irssi;0.9
Mysql;1.2401
Bundle::DBI;11.03
Bundle::DBD::mysql;2.9002

=head1 SCRIPT CATEGORIES

Search

UNIX : System_administration

=head1 PREREQUISITES

=over 4

=item L<Module::Info::File 0.07>

=item L<Module::Info 0.20>

=item L<File::Basename>

=item L<File::Find>

=item L<File::Spec>

=item L<Data::Dumper>

=back

=head1 OSNAMES

any

=head1 SEE ALSO

=over 4

=item L<Module::Info>

=item L<Module::Info::File>

=back

=head1 AUTHOR

jonasbn E<lt>jonasbn@cpan.orgE<gt>

=head1 COPYRIGHT

version.pl is free software and is released under
the Artistic License. See
E<lt>http://www.perl.com/language/misc/Artistic.htmlE<gt> for details.

version.pl is (C) 2003-2004 Jonas B. Nielsen (jonasbn)
E<lt>jonasbn@cpan.orgE<gt>

=cut