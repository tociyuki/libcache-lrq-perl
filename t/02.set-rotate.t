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
        20, 12, q() => q(),
         8,  8, q() => q(),
         4,  4, 'a' => 'A',
         0, 16, q() => q(),
        12, 20, q() => q(),
        16,  0, q() => q(),
    ],
    '_index' => {'a' => 8},
);
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            20, 12, q() => q(),
             8,  8, q() => q(),
             4,  4, 'a' => 'V',
             0, 16, q() => q(),
            12, 20, q() => q(),
            16,  0, q() => q(),
        ],
        '_index' => {'a' => 8},
    },
}

=== set a [a => A, b => B]
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
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            20, 16, q() => q(),
             8, 12, q() => q(),
            12,  4, 'a' => 'V',
             4,  8, 'b' => 'B',
             0, 20, q() => q(),
            16,  0, q() => q(),
        ],
        '_index' => {'a' => 8, 'b' => 12},
    },
}

=== set b [a => A, b => B]
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
+{'got' => scalar $h->set('b' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            20, 16, q() => q(),
            12,  8, q() => q(),
             4, 12, 'a' => 'A',
             8,  4, 'b' => 'V',
             0, 20, q() => q(),
            16,  0, q() => q(),
        ],
        '_index' => {'a' => 8, 'b' => 12},
    },
}

=== set a [a => A, b => B, c => C]
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
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            20, 20, q() => q(),
             8, 12, q() => q(),
            16,  4, 'a' => 'V',
             4, 16, 'b' => 'B',
            12,  8, 'c' => 'C',
             0,  0, q() => q(),
        ],
        '_index' => {'a' => 8, 'b' => 12, 'c' => 16},
    },
}

=== set b [a => A, b => B, c => C]
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
+{'got' => scalar $h->set('b' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            20, 20, q() => q(),
            12,  8, q() => q(),
             4, 16, 'a' => 'A',
            16,  4, 'b' => 'V',
             8, 12, 'c' => 'C',
             0,  0, q() => q(),
        ],
        '_index' => {'a' => 8, 'b' => 12, 'c' => 16},
    },
}

=== set c [a => A, b => B, c => C]
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
+{'got' => scalar $h->set('c' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
            20, 20, q() => q(),
            16,  8, q() => q(),
             4, 12, 'a' => 'A',
             8, 16, 'b' => 'B',
            12,  4, 'c' => 'V',
             0,  0, q() => q(),
        ],
        '_index' => {'a' => 8, 'b' => 12, 'c' => 16},
    },
}

=== set a [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
             0,  0, q() => q(),
             8, 12, q() => q(),
            20,  4, 'a' => 'V',
             4, 16, 'b' => 'B',
            12, 20, 'c' => 'C',
            16,  8, 'd' => 'D',
        ],
        '_index' => {'a' => 8, 'b' => 12, 'c' => 16, 'd' => 20},
    },
}

=== set b [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->set('b' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
             0,  0, q() => q(),
            12,  8, q() => q(),
             4, 16, 'a' => 'A',
            20,  4, 'b' => 'V',
             8, 20, 'c' => 'C',
            16, 12, 'd' => 'D',
        ],
        '_index' => {'a' => 8, 'b' => 12, 'c' => 16, 'd' => 20},
    },
}

=== set c [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->set('c' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
             0,  0, q() => q(),
            16,  8, q() => q(),
             4, 12, 'a' => 'A',
             8, 20, 'b' => 'B',
            20,  4, 'c' => 'V',
            12, 16, 'd' => 'D',
        ],
        '_index' => {'a' => 8, 'b' => 12, 'c' => 16, 'd' => 20},
    },
}

=== set d [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->set('d' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => [
             0,  0, q() => q(),
            20,  8, q() => q(),
             4, 12, 'a' => 'A',
             8, 16, 'b' => 'B',
            12, 20, 'c' => 'C',
            16,  4, 'd' => 'V',
        ],
        '_index' => {'a' => 8, 'b' => 12, 'c' => 16, 'd' => 20},
    },
}

