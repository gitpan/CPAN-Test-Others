package CPAN::Test::Others;
use strict;
use warnings;

our $VERSION = '0.01';

=head1 NAME

CPAN::Test::Others - Include tests for other modules on CPAN

=head1 SYNOPSIS

You don't have any use for this module, just run its tests and report them to CPAN Testers

=head1 DESCRIPTION


Sometimes I have an urge to write tests for other modules.
Getting these tests included in the real distributin is not always 
easy, other module authors are busy too. They might have a real life.

So this module does not have its own code, it only has prerequisites
and tests for those other modules.

=head1 TODO

Add a way to (optionally) send the report to author of the module under test.

Split the module to the part that is needed for such tests and the part where
my tests are, so others will be able to use it as well.

=head1 AUTHOR

Gabor Szabo <gabor@pti.co.il>

=head1 COPYRIGHT

Copyright 2006 by Gabor Szabo <gabor@pti.co.il>.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html





1;

