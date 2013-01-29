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

=== get a [a => A]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A'],
    '_index' => {'a' => 0},
);
+{'got' => scalar $h->get('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A'],
        '_index' => {'a' => 0},
    },
}

=== get b [a => A]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A'],
    '_index' => {'a' => 0},
);
+{'got' => scalar $h->get('b'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A'],
        '_index' => {'a' => 0},
    },
}

=== get a [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B'],
    '_index' => {'a' => 0, 'b' => 2},
);
+{'got' => scalar $h->get('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => ['b' => 'B', 'a' => 'A'],
        '_index' => {'b' => 0, 'a' => 2},
    },
}

=== get b [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B'],
    '_index' => {'a' => 0, 'b' => 2},
);
+{'got' => scalar $h->get('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B'],
        '_index' => {'a' => 0, 'b' => 2},
    },
}

=== get c [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B'],
    '_index' => {'a' => 0, 'b' => 2},
);
+{'got' => scalar $h->get('c'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B'],
        '_index' => {'a' => 0, 'b' => 2},
    },
}

=== get a [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->get('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => ['b' => 'B', 'c' => 'C', 'a' => 'A'],
        '_index' => {'b' => 0, 'c' => 2, 'a' => 4},
    },
}

=== get b [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->get('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'c' => 'C', 'b' => 'B'],
        '_index' => {'a' => 0, 'c' => 2, 'b' => 4},
    },
}

=== get c [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->get('c'), 'after' => $h}
--- expected
+{
    'got' => 'C',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
        '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
    },
}

=== get d [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->get('d'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
        '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
    },
}

=== get a [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->get('a'), 'after' => $h}
--- expected
+{
    'got' => 'A',
    'after' => {
        'size' => 4,
        '_list' => ['b' => 'B', 'c' => 'C', 'd' => 'D', 'a' => 'A'],
        '_index' => {'b' => 0, 'c' => 2, 'd' => 4, 'a' => 6},
    },
}

=== get b [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->get('b'), 'after' => $h}
--- expected
+{
    'got' => 'B',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'c' => 'C', 'd' => 'D', 'b' => 'B'],
        '_index' => {'a' => 0, 'c' => 2, 'd' => 4, 'b' => 6},
    },
}

=== get c [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->get('c'), 'after' => $h}
--- expected
+{
    'got' => 'C',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'd' => 'D', 'c' => 'C'],
        '_index' => {'a' => 0, 'b' => 2, 'd' => 4, 'c' => 6},
    },
}

=== get d [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->get('d'), 'after' => $h}
--- expected
+{
    'got' => 'D',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
        '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
    },
}

=== get e [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->get('e'), 'after' => $h}
--- expected
+{
    'got' => undef,
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
        '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
    },
}

