use 5.006;
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Iss::Ah::Predictor',
    VERSION_FROM => 'lib/xDT/Parser.pm',
    ABSTRACT     => 'ISS AH Predictor',
    AUTHOR       => 'Christoph Beger <christoph.beger@medizin.uni-leipzig.de>',
    LICENSE      => 'MIT',
    META_MERGE   => {
        dynamic_config => 0,
        'meta-spec'    => { version   => 2 },
        no_index       => { directory => [ qw(t) ], },
        prereqs        => { runtime   => { requires => { perl => '5.006' } } },
        resources      => {
            bugtracker => { web => 'https://github.com/CrescNet/iss-ah-predictor/issues' },
            license    => [ 'https://opensource.org/licenses/MIT' ],
            repository => {
                type => 'git',
                url  => 'https://github.com/CrescNet/iss-ah-predictor.git',
                web  => 'https://github.com/CrescNet/iss-ah-predictor',
            },
        },
    },
    CONFIGURE_REQUIRES => { 'ExtUtils::MakeMaker' => '7.44' },
    TEST_REQUIRES      => { 'Test::More' => '1.3' },
    test  => { TESTS => 't/*.t t/*/*.t' },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Iss-Ah-Predictor-*' },
);
