use strict;
use warnings;
use Test::Base;
use Cache::Lrq;

plan tests => 1 * blocks;

filters {
    'input' => [qw(eval)],
    'expected' => [qw(eval)],
};

run_is_deeply 'input' => 'expected';

__END__

=== set a []
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [],
    '_index' => {},
);
+{'got' => scalar $h->set('a' => 'A'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A'],
        '_index' => {'a' => 0},
    },
}

=== set b [a => A]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A'],
    '_index' => {'a' => 0},
);
+{'got' => scalar $h->set('b' => 'B'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B'],
        '_index' => {'a' => 0, 'b' => 2},
    },
}

=== set c [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B'],
    '_index' => {'a' => 0, 'b' => 2},
);
+{'got' => scalar $h->set('c' => 'C'), 'after' => $h}
--- expected
+{
    'got' => 'C',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
        '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
    },
}

=== set d [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->set('d' => 'D'), 'after' => $h}
--- expected
+{
    'got' => 'D',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
        '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
    },
}

=== set e [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->set('e' => 'E'), 'after' => $h}
--- expected
+{
    'got' => 'E',
    'after' => {
        'size' => 4,
        '_list' => ['b' => 'B', 'c' => 'C', 'd' => 'D', 'e' => 'E'],
        '_index' => {'b' => 0, 'c' => 2, 'd' => 4, 'e' => 6},
    },
}

=== set f [b => B, c => C, d => D, e => E]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['b' => 'B', 'c' => 'C', 'd' => 'D', 'e' => 'E'],
    '_index' => {'b' => 0, 'c' => 2, 'd' => 4, 'e' => 6},
);
+{'got' => scalar $h->set('f' => 'F'), 'after' => $h}
--- expected
+{
    'got' => 'F',
    'after' => {
        'size' => 4,
        '_list' => ['c' => 'C', 'd' => 'D', 'e' => 'E', 'f' => 'F'],
        '_index' => {'c' => 0, 'd' => 2, 'e' => 4, 'f' => 6},
    },
}

