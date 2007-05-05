use strict;
use warnings;
use Module::Build;
use Config;

my $builder = Module::Build->new(
    module_name           => 'CPAN::Test::Others',
    license               => 'perl',
    dist_author           => 'Gabor Szabo',
    create_makefile_pl    => 'traditional',
    create_readme         => 1,
    requires              => {
        'Test::More'          => '0.70',
        'Proc::ProcessTable'  => '0.41',
        'OLE::Storage_Lite'   => '0.08',
    },
);

$builder->create_build_script();
