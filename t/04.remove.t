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
    '_list' => [],
    '_index' => {},
);
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => [],
        '_index' => {},
    },
}

=== remove a [a => A]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A'],
    '_index' => {'a' => 0},
);
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => [],
        '_index' => {},
    },
}

=== remove b [a => A]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A'],
    '_index' => {'a' => 0},
);
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A'],
        '_index' => {'a' => 0},
    },
}

=== remove a [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B'],
    '_index' => {'a' => 0, 'b' => 2},
);
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => ['b' => 'B'],
        '_index' => {'b' => 0},
    },
}

=== remove b [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B'],
    '_index' => {'a' => 0, 'b' => 2},
);
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A'],
        '_index' => {'a' => 0},
    },
}

=== remove c [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B'],
    '_index' => {'a' => 0, 'b' => 2},
);
+{'got' => scalar $h->remove('c'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B'],
        '_index' => {'a' => 0, 'b' => 2},
    },
}

=== remove a [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => ['b' => 'B', 'c' => 'C'],
        '_index' => {'b' => 0, 'c' => 2},
    },
}

=== remove b [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'c' => 'C'],
        '_index' => {'a' => 0, 'c' => 2},
    },
}

=== remove c [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->remove('c'), 'after' => $h}
--- expected
+{
    'got' => 'C',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B'],
        '_index' => {'a' => 0, 'b' => 2},
    },
}

=== remove d [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->remove('d'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
        '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
    },
}

=== remove a [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->remove('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => ['b' => 'B', 'c' => 'C', 'd' => 'D'],
        '_index' => {'b' => 0, 'c' => 2, 'd' => 4},
    },
}

=== remove b [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->remove('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'c' => 'C', 'd' => 'D'],
        '_index' => {'a' => 0, 'c' => 2, 'd' => 4},
    },
}

=== remove d [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->remove('c'), 'after' => $h}
--- expected
+{
    'got' => 'C',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'd' => 'D'],
        '_index' => {'a' => 0, 'b' => 2, 'd' => 4},
    },
}

=== remove d [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->remove('d'), 'after' => $h}
--- expected
+{
    'got' => 'D',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
        '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
    },
}

=== remove e [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->remove('e'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
        '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
    },
}

