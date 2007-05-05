use strict;
use warnings;
use Test::More;
my $tests;

plan tests => 2 + $tests*2;

use_ok('Proc::ProcessTable');
diag "Testing Proc::ProcessTable $Proc::ProcessTable::VERSION";

BEGIN {$tests = 3;}
look_for_memory_leak(\&do_something, 'do_something', 100, 0, 0);
diag "In the beginning I got 0 memory growth here, now I get 135168";
look_for_memory_leak(\&leak_memory, 'leak_memory', 100, 0, 0);
look_for_memory_leak(\&leak_memory, 'leak_memory', 1000, 270336, 270336);
diag "In the previous test I got consistently 270336 growth on my machine";

external_perl();



sub look_for_memory_leak {
    my ($sub, $name, $n, $min, $max) = @_;
    my $size_before = get_process_size($$);
    $sub->() for 1..$n;
    my $size_after = get_process_size($$);
    diag "Size before: $size_before";
    diag "Size after: $size_after";
    my $diff = $size_after - $size_before;
#    is($size_after, $size_before, "Memory size did not change for $name $n")
#        or diag "The difference is $diff";
    cmp_ok($diff, '>=', $min, "Difference should be bigger than expected minimum for $name $n");
    cmp_ok($diff, '<=', $max, "Difference should be smaller than expected maximum for $name $n");
}


sub get_process_size {
    my ($pid) = @_;
    my $pt = Proc::ProcessTable->new;
    foreach my $p ( @{$pt->table} ) {
        return $p->size if $pid == $p->pid;
    }
    return;
}

sub do_something {
    my @x = (1)x100;
}

sub leak_memory {
    my (%a, %b);
    $a{b} = \%b;
    $b{a} = \%a;
}

sub external_perl {
    my @results;
    for (1..10) {
        my $pid = fork();
        return if not defined $pid;

        if (not $pid) {
            exec qq($^X -e "sleep 1");
        }
        my $mem = get_process_size($pid);
        wait();
        diag "External memory usage: $mem";
        push @results, $mem;
    }
    @results = sort @results;
    is($results[0], $results[-1], "Same memory consumption in external calls");
}



