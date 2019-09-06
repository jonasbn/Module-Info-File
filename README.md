[![CPAN version](https://badge.fury.io/pl/Module-Info-File.svg)](http://badge.fury.io/pl/Module-Info-File)
[![Build Status](https://travis-ci.org/jonasbn/Module-Info-File.svg?branch=master)](https://travis-ci.org/jonasbn/Module-Info-File)
[![Coverage Status](https://coveralls.io/repos/jonasbn/Module-Info-File/badge.png)](https://coveralls.io/r/jonasbn/Module-Info-File)

# NAME

Module::Info::File - retrieve module information from a file

# VERSION

This POD describes version 1.00 of Module::Info::File

# SYNOPSIS

        use Module::Info::File;

        my $module = Module::Info::File->new_from_file('path/to/Some/Module.pm');

        $module->name();

        $module->version();

        $module->file();

        $module->inc_dir();

# DESCRIPTION

**Module::Info** (SEE REFERENCES), are lacking functionality of being able
to extract certain data when parsing a module directly from a file. I
have therefor created Module::Info::File, which inherits from
Module::Info and replaces the **new\_from\_file** method so the lacking
data can be accessed (dir and name attributes). Apart from that you can
use all the neat accessors from **Module::Info**.

Given the following structure in a file:

    package Foo;
    1;
    package Bar;
    1;

**Module::Info::File** returns: Foo

Given the following structure in a file:

    package Foo;
    $VERSION = '0.01';
    1;

# SUBROUTINES/METHODS

## new\_from\_file

Given a file, it will interpret this as the module you want information
about. You can also hand it a perl script.

After construction has been completed three attributes have been set in
the object:

- name
- dir
- file

So by using the inherited methods from **Module::Info** you can access
the attributes.

In the `script` folder in this distribution is a small script called
`version.pl`, which was the beginning of this module.

- name, returns the package name of the file.
- version, returns the version number of the module/file in question
($VERSION).
- inc\_dir, returns the dir attribute
- file, returns the file attribute

## new\_from\_data

A helper method to streamline the result set

In general please refer to the documentation on **Module::Info** for more
details.

In list context the module returns and array of Module::Info::File objects, with
which you can use the above accessors. The information in the objects might not
be complete though (SEE: CAVEATS).

In the t/ directory of this distribution there is a test (Info.t), it
includes some tests. These tests will test your installation of
Module::Info (required by Module::Info::File), if the tests fail,
Module::Info::File will be obsolete and can be discontinued.

# SEE ALSO

- [Module::Info](https://metacpan.org/pod/Module::Info), by Mattia Barbon
- `script/version.pl`

# BUGS AND LIMITATIONS

The module can somewhat handle several package definitions in one file, but
the information is not complete yet, such as version information etc.

The method currently only support the following version number lines:

        $VERSION = '0.01';

        $VERSION = 0.01;

# INCOMPATIBILITIES

Eric D. Paterson scanned his complete CPAN installation and got and came across
a few problems:

- [DBD::Oracle](https://metacpan.org/pod/DBD::Oracle), the package was defined in a closure, this is handled from
Module::Info::File 0.09.
- [Archive::Zip::Tree](https://metacpan.org/pod/Archive::Zip::Tree), which is installed, however deprecated and does NOT
contain a package defition.
- [CGI::Apache](https://metacpan.org/pod/CGI::Apache), where the installed version was located in CGI/apache.pm
so the casing was not uniform with the package definition, I have asked Eric
for further information on this issue, regarding his version and installation.

# DIAGNOSTICS

- `Unable to open file: <filename> - <operating system error>`

    If the constructor **new\_from\_file** is given a filename parameter, which does
    not meet the following prerequisites:

    - it must be a file and it must exist
    - the file must be readable by the user

# CONFIGURATION AND ENVIRONMENT

There is a such no configuration necessary and Module::Info::File is expected
to work on the same environments as perl itself.

# DEPENDENCIES

This module is a sub-class of [Module::Info](https://metacpan.org/pod/Module::Info), so the following direct
dependencies have to be met:

- [Module::Info](https://metacpan.org/pod/Module::Info) 0.20
- [File::Spec](https://metacpan.org/pod/File::Spec), to work on non-unix operating systems
- Perl 5.6.0 and above

    Compability for older perls is no longer required, if somebody would
    require this I would be willing to invest the time and effort.

# ACKNOWLEDGEMENTS

In no particular order

- Mohammad S Anwar, for PRs #6
- Dai Okabayashi (bayashi), for PRs #2 and #3
- Jeffrey Ryan Thalhammer, for [Perl::Critic](https://metacpan.org/pod/Perl::Critic)
- chromatic, for [Test::Kwalitee](https://metacpan.org/pod/Test::Kwalitee)
- Eric D. Peterson, for reporting bugs resulting in an improvement
- Lars Thegler. tagg (LTHEGLER), for not letting me go easily, a patch and
suggesting the list context variation.
- Thomas Eibner (THOMAS), for reviewing the POD
- Mattia Barbon (MBARBON), for writing Module::Info
- bigj at Perlmonks who mentioned Module::Info
- All the CPAN testers, who help you to have your stuff tested on platforms not
necessarily available to a module author.

# AUTHOR

jonasbn <jonasbn@cpan.org>

# LICENSE AND COPYRIGHT

Module::Info::File and related modules are free software and is
released under the Artistic License 2.0.

Module::Info::File is (C) 2003-2017 Jonas B. Nielsen (jonasbn)
<jonasbn@cpan.org>
