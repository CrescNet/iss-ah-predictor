#!perl -T
use 5.006;
use strict;
use warnings;
use Test::PerlTidy qw(run_tests);

run_tests(exclude => [ 'local' ]);
