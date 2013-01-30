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

=== set a [a => A]
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
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            [5, 3, q() => q()],
            [2, 2, q() => q()],
            [1, 1, 'a' => 'V'],
            [0, 4, q() => q()],
            [3, 5, q() => q()],
            [4, 0, q() => q()],
        ],
        '_index' => {'a' => 2},
    },
}

=== set a [a => A, b => B]
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
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            [5, 4, q() => q()],
            [2, 3, q() => q()],
            [3, 1, 'a' => 'V'],
            [1, 2, 'b' => 'B'],
            [0, 5, q() => q()],
            [4, 0, q() => q()],
        ],
        '_index' => {'a' => 2, 'b' => 3},
    },
}

=== set b [a => A, b => B]
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
+{'got' => scalar $h->set('b' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            [5, 4, q() => q()],
            [3, 2, q() => q()],
            [1, 3, 'a' => 'A'],
            [2, 1, 'b' => 'V'],
            [0, 5, q() => q()],
            [4, 0, q() => q()],
        ],
        '_index' => {'a' => 2, 'b' => 3},
    },
}

=== set a [a => A, b => B, c => C]
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
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        'size' => 4,
        '_list' => [
            [5, 5, q() => q()],
            [2, 3, q() => q()],
            [4, 1, 'a' => 'V'],
            [1, 4, 'b' => 'B'],
            [3, 2, 'c' => 'C'],
            [0, 0, q() => q()],
        ],
        '_index' => {'a' => 2, 'b' => 3, 'c' => 4},
    },
}

=== set b [a => A, b => B, c => C]
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
+{'got' => scalar $h->set('b' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            [5, 5, q() => q()],
            [3, 2, q() => q()],
            [1, 4, 'a' => 'A'],
            [4, 1, 'b' => 'V'],
            [2, 3, 'c' => 'C'],
            [0, 0, q() => q()],
        ],
        '_index' => {'a' => 2, 'b' => 3, 'c' => 4},
    },
}

=== set c [a => A, b => B, c => C]
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
+{'got' => scalar $h->set('c' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            [5, 5, q() => q()],
            [4, 2, q() => q()],
            [1, 3, 'a' => 'A'],
            [2, 4, 'b' => 'B'],
            [3, 1, 'c' => 'V'],
            [0, 0, q() => q()],
        ],
        '_index' => {'a' => 2, 'b' => 3, 'c' => 4},
    },
}

=== set a [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            [0, 0, q() => q()],
            [2, 3, q() => q()],
            [5, 1, 'a' => 'V'],
            [1, 4, 'b' => 'B'],
            [3, 5, 'c' => 'C'],
            [4, 2, 'd' => 'D'],
        ],
        '_index' => {'a' => 2, 'b' => 3, 'c' => 4, 'd' => 5},
    },
}

=== set b [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->set('b' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            [0, 0, q() => q()],
            [3, 2, q() => q()],
            [1, 4, 'a' => 'A'],
            [5, 1, 'b' => 'V'],
            [2, 5, 'c' => 'C'],
            [4, 3, 'd' => 'D'],
        ],
        '_index' => {'a' => 2, 'b' => 3, 'c' => 4, 'd' => 5},
    },
}

=== set c [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->set('c' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            [0, 0, q() => q()],
            [4, 2, q() => q()],
            [1, 3, 'a' => 'A'],
            [2, 5, 'b' => 'B'],
            [5, 1, 'c' => 'V'],
            [3, 4, 'd' => 'D'],
        ],
        '_index' => {'a' => 2, 'b' => 3, 'c' => 4, 'd' => 5},
    },
}

=== set d [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->set('d' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            [0, 0, q() => q()],
            [5, 2, q() => q()],
            [1, 3, 'a' => 'A'],
            [2, 4, 'b' => 'B'],
            [3, 5, 'c' => 'C'],
            [4, 1, 'd' => 'V'],
        ],
        '_index' => {'a' => 2, 'b' => 3, 'c' => 4, 'd' => 5},
    },
}

