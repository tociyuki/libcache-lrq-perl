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
my $h = Cache::Lrq->new('size' => 4);
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => [
            20,  8, q() => q(),
             4,  4, q() => q(),
             0, 12, q() => q(),
             8, 16, q() => q(),
            12, 20, q() => q(),
            16,  0, q() => q(),
        ],
        '_index' => {},
    },
}

=== remove a [a => A]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        20, 12, q() => q(),
         8,  8, q() => q(),
         4,  4, 'a' => 'A',
         0, 16, q() => q(),
        12, 20, q() => q(),
        16,  0, q() => q(),
    ],
    '_index' => {'a' => 8},
);
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => [
             8, 12, q() => q(),
             4,  4, q() => q(),
            20,  0, q() => q(),
             0, 16, q() => q(),
            12, 20, q() => q(),
            16,  8, q() => q(),
        ],
        '_index' => {},
    },
}

=== remove b [a => A]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        20, 12, q() => q(),
         8,  8, q() => q(),
         4,  4, 'a' => 'A',
         0, 16, q() => q(),
        12, 20, q() => q(),
        16,  0, q() => q(),
    ],
    '_index' => {'a' => 8},
);
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => [
            20, 12, q() => q(),
             8,  8, q() => q(),
             4,  4, 'a' => 'A',
             0, 16, q() => q(),
            12, 20, q() => q(),
            16,  0, q() => q(),
        ],
        '_index' => {'a' => 8},
    },
}

=== remove a [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        20, 16, q() => q(),
        12,  8, q() => q(),
         4, 12, 'a' => 'A',
         8,  4, 'b' => 'B',
         0, 20, q() => q(),
        16,  0, q() => q(),
    ],
    '_index' => {'a' => 8, 'b' => 12},
);
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => [
             8, 16, q() => q(),
            12, 12, q() => q(),
            20,  0, q() => q(),
             4,  4, 'b' => 'B',
             0, 20, q() => q(),
            16,  8, q() => q(),
        ],
        '_index' => {'b' => 12},
    },
}

=== remove b [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        20, 16, q() => q(),
        12,  8, q() => q(),
         4, 12, 'a' => 'A',
         8,  4, 'b' => 'B',
         0, 20, q() => q(),
        16,  0, q() => q(),
    ],
    '_index' => {'a' => 8, 'b' => 12},
);
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => [
            12, 16, q() => q(),
             8,  8, q() => q(),
             4,  4, 'a' => 'A',
            20,  0, q() => q(),
             0, 20, q() => q(),
            16, 12, q() => q(),
        ],
        '_index' => {'a' => 8},
    },
}

=== remove c [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        20, 16, q() => q(),
        12,  8, q() => q(),
         4, 12, 'a' => 'A',
         8,  4, 'b' => 'B',
         0, 20, q() => q(),
        16,  0, q() => q(),
    ],
    '_index' => {'a' => 8, 'b' => 12},
);
+{'got' => scalar $h->remove('c'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => [
            20, 16, q() => q(),
            12,  8, q() => q(),
             4, 12, 'a' => 'A',
             8,  4, 'b' => 'B',
             0, 20, q() => q(),
            16,  0, q() => q(),
        ],
        '_index' => {'a' => 8, 'b' => 12},
    },
}

=== remove a [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        20, 20, q() => q(),
        16,  8, q() => q(),
         4, 12, 'a' => 'A',
         8, 16, 'b' => 'B',
        12,  4, 'c' => 'C',
         0,  0, q() => q(),
    ],
    '_index' => {'a' => 8, 'b' => 12, 'c' => 16},
);
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => [
             8, 20, q() => q(),
            16, 12, q() => q(),
            20,  0, q() => q(),
             4, 16, 'b' => 'B',
            12,  4, 'c' => 'C',
             0,  8, q() => q(),
        ],
        '_index' => {'b' => 12, 'c' => 16},
    },
}

=== remove b [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        20, 20, q() => q(),
        16,  8, q() => q(),
         4, 12, 'a' => 'A',
         8, 16, 'b' => 'B',
        12,  4, 'c' => 'C',
         0,  0, q() => q(),
    ],
    '_index' => {'a' => 8, 'b' => 12, 'c' => 16},
);
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => [
            12, 20, q() => q(),
            16,  8, q() => q(),
             4, 16, 'a' => 'A',
            20,  0, q() => q(),
             8,  4, 'c' => 'C',
             0, 12, q() => q(),
        ],
        '_index' => {'a' => 8, 'c' => 16},
    },
}

=== remove c [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        20, 20, q() => q(),
        16,  8, q() => q(),
         4, 12, 'a' => 'A',
         8, 16, 'b' => 'B',
        12,  4, 'c' => 'C',
         0,  0, q() => q(),
    ],
    '_index' => {'a' => 8, 'b' => 12, 'c' => 16},
);
+{'got' => scalar $h->remove('c'), 'after' => $h}
--- expected
+{
    'got' => 'C',
    'after' => {
        'size' => 4,
        '_list' => [
            16, 20, q() => q(),
            12,  8, q() => q(),
             4, 12, 'a' => 'A',
             8,  4, 'b' => 'B',
            20,  0, q() => q(),
             0, 16, q() => q(),
        ],
        '_index' => {'a' => 8, 'b' => 12},
    },
}

=== remove d [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
        20, 20, q() => q(),
        16,  8, q() => q(),
         4, 12, 'a' => 'A',
         8, 16, 'b' => 'B',
        12,  4, 'c' => 'C',
         0,  0, q() => q(),
    ],
    '_index' => {'a' => 8, 'b' => 12, 'c' => 16},
);
+{'got' => scalar $h->remove('d'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => [
            20, 20, q() => q(),
            16,  8, q() => q(),
             4, 12, 'a' => 'A',
             8, 16, 'b' => 'B',
            12,  4, 'c' => 'C',
             0,  0, q() => q(),
        ],
        '_index' => {'a' => 8, 'b' => 12, 'c' => 16},
    },
}

=== remove a [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
         0,  0, q() => q(),
        20,  8, q() => q(),
         4, 12, 'a' => 'A',
         8, 16, 'b' => 'B',
        12, 20, 'c' => 'C',
        16,  4, 'd' => 'D',
    ],
    '_index' => {'a' => 8, 'b' => 12, 'c' => 16, 'd' => 20},
);
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => [
             8,  8, q() => q(),
            20, 12, q() => q(),
             0,  0, q() => q(),
             4, 16, 'b' => 'B',
            12, 20, 'c' => 'C',
            16,  4, 'd' => 'D',
        ],
        '_index' => {'b' => 12, 'c' => 16, 'd' => 20},
    },
}

=== remove b [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
         0,  0, q() => q(),
        20,  8, q() => q(),
         4, 12, 'a' => 'A',
         8, 16, 'b' => 'B',
        12, 20, 'c' => 'C',
        16,  4, 'd' => 'D',
    ],
    '_index' => {'a' => 8, 'b' => 12, 'c' => 16, 'd' => 20},
);
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => [
            12, 12, q() => q(),
            20,  8, q() => q(),
             4, 16, 'a' => 'A',
             0,  0, q() => q(),
             8, 20, 'c' => 'C',
            16,  4, 'd' => 'D',
        ],
        '_index' => {'a' => 8, 'c' => 16, 'd' => 20},
    },
}

=== remove d [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
         0,  0, q() => q(),
        20,  8, q() => q(),
         4, 12, 'a' => 'A',
         8, 16, 'b' => 'B',
        12, 20, 'c' => 'C',
        16,  4, 'd' => 'D',
    ],
    '_index' => {'a' => 8, 'b' => 12, 'c' => 16, 'd' => 20},
);
+{'got' => scalar $h->remove('c'), 'after' => $h}
--- expected
+{
    'got' => 'C',
    'after' => {
        'size' => 4,
        '_list' => [
            16, 16, q() => q(),
            20,  8, q() => q(),
             4, 12, 'a' => 'A',
             8, 20, 'b' => 'B',
             0,  0, q() => q(),
            12,  4, 'd' => 'D',
        ],
        '_index' => {'a' => 8, 'b' => 12, 'd' => 20},
    },
}

=== remove d [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
         0,  0, q() => q(),
        20,  8, q() => q(),
         4, 12, 'a' => 'A',
         8, 16, 'b' => 'B',
        12, 20, 'c' => 'C',
        16,  4, 'd' => 'D',
    ],
    '_index' => {'a' => 8, 'b' => 12, 'c' => 16, 'd' => 20},
);
+{'got' => scalar $h->remove('d'), 'after' => $h}
--- expected
+{
    'got' => 'D',
    'after' => {
        'size' => 4,
        '_list' => [
            20, 20, q() => q(),
            16,  8, q() => q(),
             4, 12, 'a' => 'A',
             8, 16, 'b' => 'B',
            12,  4, 'c' => 'C',
             0,  0, q() => q(),
        ],
        '_index' => {'a' => 8, 'b' => 12, 'c' => 16},
    },
}

=== remove e [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
         0,  0, q() => q(),
        20,  8, q() => q(),
         4, 12, 'a' => 'A',
         8, 16, 'b' => 'B',
        12, 20, 'c' => 'C',
        16,  4, 'd' => 'D',
    ],
    '_index' => {'a' => 8, 'b' => 12, 'c' => 16, 'd' => 20},
);
+{'got' => scalar $h->remove('e'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => [
             0,  0, q() => q(),
            20,  8, q() => q(),
             4, 12, 'a' => 'A',
             8, 16, 'b' => 'B',
            12, 20, 'c' => 'C',
            16,  4, 'd' => 'D',
        ],
        '_index' => {'a' => 8, 'b' => 12, 'c' => 16, 'd' => 20},
    },
}

