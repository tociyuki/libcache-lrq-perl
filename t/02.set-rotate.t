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
    '_list' => ['a' => 'A'],
    '_index' => {'a' => 0},
);
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'V'],
        '_index' => {'a' => 0},
    },
}

=== set a [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B'],
    '_index' => {'a' => 0, 'b' => 2},
);
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => ['b' => 'B', 'a' => 'V'],
        '_index' => {'b' => 0, 'a' => 2},
    },
}

=== set b [a => A, b => B]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B'],
    '_index' => {'a' => 0, 'b' => 2},
);
+{'got' => scalar $h->set('b' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'V'],
        '_index' => {'a' => 0, 'b' => 2},
    },
}

=== set a [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => ['b' => 'B', 'c' => 'C', 'a' => 'V'],
        '_index' => {'b' => 0, 'c' => 2, 'a' => 4},
    },
}

=== set b [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->set('b' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'c' => 'C', 'b' => 'V'],
        '_index' => {'a' => 0, 'c' => 2, 'b' => 4},
    },
}

=== set c [a => A, b => B, c => C]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
);
+{'got' => scalar $h->set('c' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'V'],
        '_index' => {'a' => 0, 'b' => 2, 'c' => 4},
    },
}

=== set a [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->set('a' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => ['b' => 'B', 'c' => 'C', 'd' => 'D', 'a' => 'V'],
        '_index' => {'b' => 0, 'c' => 2, 'd' => 4, 'a' => 6},
    },
}

=== set b [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->set('b' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'c' => 'C', 'd' => 'D', 'b' => 'V'],
        '_index' => {'a' => 0, 'c' => 2, 'd' => 4, 'b' => 6},
    },
}

=== set c [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->set('c' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'd' => 'D', 'c' => 'V'],
        '_index' => {'a' => 0, 'b' => 2, 'd' => 4, 'c' => 6},
    },
}

=== set d [a => A, b => B, c => C, d => D]
--- input
my $h = Cache::Lrq->new(
    'size' => 4,
    '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'D'],
    '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
);
+{'got' => scalar $h->set('d' => 'V'), 'after' => $h}
--- expected
+{
    'got' => 'V',
    'after' => {
        'size' => 4,
        '_list' => ['a' => 'A', 'b' => 'B', 'c' => 'C', 'd' => 'V'],
        '_index' => {'a' => 0, 'b' => 2, 'c' => 4, 'd' => 6},
    },
}

