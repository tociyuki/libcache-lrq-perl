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
my $h = Cache::Lrq->new('size' => 4);
+{'got' => scalar $h->set('a' => 'A'), 'after' => $h}
--- expected
+{
    'got' => 'A',
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

=== set b [a => A]
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
+{'got' => scalar $h->set('b' => 'B'), 'after' => $h}
--- expected
+{
    'got' => 'B',
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

=== set c [a => A, b => B]
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
+{'got' => scalar $h->set('c' => 'C'), 'after' => $h}
--- expected
+{
    'got' => 'C',
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

=== set d [a => A, b => B, c => C]
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
+{'got' => scalar $h->set('d' => 'D'), 'after' => $h}
--- expected
+{
    'got' => 'D',
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

=== set e [a => A, b => B, c => C, d => D]
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
+{'got' => scalar $h->set('e' => 'E'), 'after' => $h}
--- expected
+{
    'got' => 'E',
    'after' => {
        'size' => 4,
        '_list' => [
             0,  0, q() => q(),
             8, 12, q() => q(),
            20,  4, 'e' => 'E',
             4, 16, 'b' => 'B',
            12, 20, 'c' => 'C',
            16,  8, 'd' => 'D',
        ],
        '_index' => {'b' => 12, 'c' => 16, 'd' => 20, 'e' => 8},
    },
}

=== set f [b => B, c => C, d => D, e => E]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => [
         0,  0, q() => q(),
         8, 12, q() => q(),
        20,  4, 'e' => 'E',
         4, 16, 'b' => 'B',
        12, 20, 'c' => 'C',
        16,  8, 'd' => 'D',
    ],
    '_index' => {'b' => 12, 'c' => 16, 'd' => 20, 'e' => 8},
);
+{'got' => scalar $h->set('f' => 'F'), 'after' => $h}
--- expected
+{
    'got' => 'F',
    'after' => {
        'size' => 4,
        '_list' => [
             0,  0, q() => q(),
            12, 16, q() => q(),
            20, 12, 'e' => 'E',
             8,  4, 'f' => 'F',
             4, 20, 'c' => 'C',
            16,  8, 'd' => 'D',
        ],
        '_index' => {'c' => 16, 'd' => 20, 'e' => 8, 'f' => 12},
    },
}

