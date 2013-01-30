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
    '_list' => [
        [5, 2, q() => q()],
        [1, 1, q() => q()],
        [0, 3, q() => q()],
        [2, 4, q() => q()],
        [3, 5, q() => q()],
        [4, 0, q() => q()],
    ],
    '_index' => {},
);
+{'got' => scalar $h->set('a' => 'A'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => [
            [5, 3, q() => q()],
            [2, 2, q() => q()],
            [1, 1, 'a' => 'A'],
            [0, 4, q() => q()],
            [3, 5, q() => q()],
            [4, 0, q() => q()],
        ],
        '_index' => {'a' => 2},
    },
}

=== set b [a => A]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        [5, 3, q() => q()],
        [2, 2, q() => q()],
        [1, 1, 'a' => 'A'],
        [0, 4, q() => q()],
        [3, 5, q() => q()],
        [4, 0, q() => q()],
    ],
    '_index' => {'a' => 2},
);
+{'got' => scalar $h->set('b' => 'B'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => [
            [5, 4, q() => q()],
            [3, 2, q() => q()],
            [1, 3, 'a' => 'A'],
            [2, 1, 'b' => 'B'],
            [0, 5, q() => q()],
            [4, 0, q() => q()],
        ],
        '_index' => {'a' => 2, 'b' => 3},
    },
}

=== set c [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        [5, 4, q() => q()],
        [3, 2, q() => q()],
        [1, 3, 'a' => 'A'],
        [2, 1, 'b' => 'B'],
        [0, 5, q() => q()],
        [4, 0, q() => q()],
    ],
    '_index' => {'a' => 2, 'b' => 3},
);
+{'got' => scalar $h->set('c' => 'C'), 'after' => $h}
--- expected
+{
    'got' => 'C',
    'after' => {
        'size' => 4,
        '_list' => [
            [5, 5, q() => q()],
            [4, 2, q() => q()],
            [1, 3, 'a' => 'A'],
            [2, 4, 'b' => 'B'],
            [3, 1, 'c' => 'C'],
            [0, 0, q() => q()],
        ],
        '_index' => {'a' => 2, 'b' => 3, 'c' => 4},
    },
}

=== set d [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        [5, 5, q() => q()],
        [4, 2, q() => q()],
        [1, 3, 'a' => 'A'],
        [2, 4, 'b' => 'B'],
        [3, 1, 'c' => 'C'],
        [0, 0, q() => q()],
    ],
    '_index' => {'a' => 2, 'b' => 3, 'c' => 4},
);
+{'got' => scalar $h->set('d' => 'D'), 'after' => $h}
--- expected
+{
    'got' => 'D',
    'after' => {
        'size' => 4,
        '_list' => [
            [0, 0, q() => q()],
            [5, 2, q() => q()],
            [1, 3, 'a' => 'A'],
            [2, 4, 'b' => 'B'],
            [3, 5, 'c' => 'C'],
            [4, 1, 'd' => 'D'],
        ],
        '_index' => {'a' => 2, 'b' => 3, 'c' => 4, 'd' => 5},
    },
}

=== set e [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        [0, 0, q() => q()],
        [5, 2, q() => q()],
        [1, 3, 'a' => 'A'],
        [2, 4, 'b' => 'B'],
        [3, 5, 'c' => 'C'],
        [4, 1, 'd' => 'D'],
    ],
    '_index' => {'a' => 2, 'b' => 3, 'c' => 4, 'd' => 5},
);
+{'got' => scalar $h->set('e' => 'E'), 'after' => $h}
--- expected
+{
    'got' => 'E',
    'after' => {
        'size' => 4,
        '_list' => [
            [0, 0, q() => q()],
            [2, 3, q() => q()],
            [5, 1, 'e' => 'E'],
            [1, 4, 'b' => 'B'],
            [3, 5, 'c' => 'C'],
            [4, 2, 'd' => 'D'],
        ],
        '_index' => {'b' => 3, 'c' => 4, 'd' => 5, 'e' => 2},
    },
}

=== set f [b => B, c => C, d => D, e => E]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        [0, 0, q() => q()],
        [2, 3, q() => q()],
        [5, 1, 'e' => 'E'],
        [1, 4, 'b' => 'B'],
        [3, 5, 'c' => 'C'],
        [4, 2, 'd' => 'D'],
    ],
    '_index' => {'b' => 3, 'c' => 4, 'd' => 5, 'e' => 2},
);
+{'got' => scalar $h->set('f' => 'F'), 'after' => $h}
--- expected
+{
    'got' => 'F',
    'after' => {
        'size' => 4,
        '_list' => [
            [0, 0, q() => q()],
            [3, 4, q() => q()],
            [5, 3, 'e' => 'E'],
            [2, 1, 'f' => 'F'],
            [1, 5, 'c' => 'C'],
            [4, 2, 'd' => 'D'],
        ],
        '_index' => {'c' => 4, 'd' => 5, 'e' => 2, 'f' => 3},
    },
}

