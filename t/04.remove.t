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

=== remove a []
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
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
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
    },
}

=== remove a [a => A]
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
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => [
            [2, 3, q() => q()],
            [1, 1, q() => q()],
            [5, 0, q() => q()],
            [0, 4, q() => q()],
            [3, 5, q() => q()],
            [4, 2, q() => q()],
        ],
        '_index' => {},
    },
}

=== remove b [a => A]
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
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => undef,
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

=== remove a [a => A, b => B]
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
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => [
            [2, 4, q() => q()],
            [3, 3, q() => q()],
            [5, 0, q() => q()],
            [1, 1, 'b' => 'B'],
            [0, 5, q() => q()],
            [4, 2, q() => q()],
        ],
        '_index' => {'b' => 3},
    },
}

=== remove b [a => A, b => B]
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
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => [
            [3, 4, q() => q()],
            [2, 2, q() => q()],
            [1, 1, 'a' => 'A'],
            [5, 0, q() => q()],
            [0, 5, q() => q()],
            [4, 3, q() => q()],
        ],
        '_index' => {'a' => 2},
    },
}

=== remove c [a => A, b => B]
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
+{'got' => scalar $h->remove('c'), 'after' => $h}
--- expected
+{
    'got' => undef,
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

=== remove a [a => A, b => B, c => C]
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
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => [
            [2, 5, q() => q()],
            [4, 3, q() => q()],
            [5, 0, q() => q()],
            [1, 4, 'b' => 'B'],
            [3, 1, 'c' => 'C'],
            [0, 2, q() => q()],
        ],
        '_index' => {'b' => 3, 'c' => 4},
    },
}

=== remove b [a => A, b => B, c => C]
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
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => [
            [3, 5, q() => q()],
            [4, 2, q() => q()],
            [1, 4, 'a' => 'A'],
            [5, 0, q() => q()],
            [2, 1, 'c' => 'C'],
            [0, 3, q() => q()],
        ],
        '_index' => {'a' => 2, 'c' => 4},
    },
}

=== remove c [a => A, b => B, c => C]
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
+{'got' => scalar $h->remove('c'), 'after' => $h}
--- expected
+{
    'got' => 'C',
    'after' => {
        'size' => 4,
        '_list' => [
            [4, 5, q() => q()],
            [3, 2, q() => q()],
            [1, 3, 'a' => 'A'],
            [2, 1, 'b' => 'B'],
            [5, 0, q() => q()],
            [0, 4, q() => q()],
        ],
        '_index' => {'a' => 2, 'b' => 3},
    },
}

=== remove d [a => A, b => B, c => C]
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
+{'got' => scalar $h->remove('d'), 'after' => $h}
--- expected
+{
    'got' => undef,
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

=== remove a [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => [
            [2, 2, q() => q()],
            [5, 3, q() => q()],
            [0, 0, q() => q()],
            [1, 4, 'b' => 'B'],
            [3, 5, 'c' => 'C'],
            [4, 1, 'd' => 'D'],
        ],
        '_index' => {'b' => 3, 'c' => 4, 'd' => 5},
    },
}

=== remove b [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => [
            [3, 3, q() => q()],
            [5, 2, q() => q()],
            [1, 4, 'a' => 'A'],
            [0, 0, q() => q()],
            [2, 5, 'c' => 'C'],
            [4, 1, 'd' => 'D'],
        ],
        '_index' => {'a' => 2, 'c' => 4, 'd' => 5},
    },
}

=== remove d [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->remove('c'), 'after' => $h}
--- expected
+{
    'got' => 'C',
    'after' => {
        'size' => 4,
        '_list' => [
            [4, 4, q() => q()],
            [5, 2, q() => q()],
            [1, 3, 'a' => 'A'],
            [2, 5, 'b' => 'B'],
            [0, 0, q() => q()],
            [3, 1, 'd' => 'D'],
        ],
        '_index' => {'a' => 2, 'b' => 3, 'd' => 5},
    },
}

=== remove d [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->remove('d'), 'after' => $h}
--- expected
+{
    'got' => 'D',
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

=== remove e [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->remove('e'), 'after' => $h}
--- expected
+{
    'got' => undef,
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

