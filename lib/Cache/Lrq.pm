package Cache::Lrq;
use warnings;
use strict;
use Carp;

our $VERSION = '0.02';

# ring heads address
my($FREE, $ROOT) = (0, 1);
# fields of entries in doubly linked ring
my($BACK, $FORW, $FKEY, $FVAL) = (0, 1, 2, 3);

## no critic qw(AmbiguousNames)

sub new {
    my($class, %arguments) = @_;
    my $self = bless {
        'size' => 256,
        '_list' => [],
        '_index' => {},
        %arguments,
    }, ref $class || $class;
    if (@{$self->{'_list'}} != $self->{'size'} + 2) {
        $self->_clear;
    }
    return $self;
}

sub set {
    my($self, $key, $value) = @_;
    # $self->_assert or croak 'set: fail pre condition';
    my $e = $self->{'_list'};
    if (exists $self->{'_index'}{$key}) {
        $self->get($key);
    }
    else {
        if ($e->[$FREE][$FORW] == $FREE) {
            $self->remove($e->[$e->[$ROOT][$FORW]]->[$FKEY]);
        }
        my $j = $e->[$FREE][$FORW];
        $self->_move($j, $ROOT);
        $self->{'_index'}{$key} = $j;
        $e->[$j][$FKEY] = $key;
    }
    my $i = $self->{'_index'}{$key};
    # $self->_assert or croak 'set: fail post condition';
    $e->[$i][$FVAL] = $value;
    return $value;
}

sub get {
    my($self, $key) = @_;
    return if ! exists $self->{'_index'}{$key};
    # $self->_assert or croak 'get: fail pre condition';
    my $i = $self->{'_index'}{$key};
    my $e = $self->{'_list'};
    if ($i != $e->[$ROOT][$BACK]) {
        $self->_move($i, $ROOT);
    }
    # $self->_assert or croak 'get: fail post condition';
    return $e->[$i][$FVAL];
}

sub remove {
    my($self, $key) = @_;
    return if ! exists $self->{'_index'}{$key};
    # $self->_assert or croak 'remove: fail pre condition';
    my $i = delete $self->{'_index'}{$key};
    my $e = $self->{'_list'};
    my $value = $e->[$i][$FVAL];
    $self->_move($i, $FREE);
    $e->[$i][$FKEY] = $e->[$i][$FVAL] = q();
    # $self->_assert or croak 'remove: fail post condition';
    return $value;
}

sub _move {
    my($self, $from, $to) = @_;
    my $e = $self->{'_list'};
    $e->[$e->[$from][$BACK]]->[$FORW] = $e->[$from][$FORW];
    $e->[$e->[$from][$FORW]]->[$BACK] = $e->[$from][$BACK];
    $e->[$from][$BACK] = $e->[$to][$BACK];
    $e->[$from][$FORW] = $to;
    $e->[$e->[$from][$BACK]]->[$FORW] = $from;
    $e->[$e->[$from][$FORW]]->[$BACK] = $from;
    return $self;
}

sub _clear {
    my($self) = @_;
    %{$self->{'_index'}} = ();
    my $e = $self->{'_list'};
    @{$e} = ();
    my $n = $self->{'size'} + 2;
    for my $i (0 .. $n - 1) {
        $e->[$i][$BACK] = ($n + $i - 1) % $n;
        $e->[$i][$FORW] = ($n + $i + 1) % $n;
        $e->[$i][$FKEY] = $e->[$i][$FVAL] = q();
    }
    $e->[$e->[$ROOT][$BACK]]->[$FORW] = $e->[$ROOT][$FORW];
    $e->[$e->[$ROOT][$FORW]]->[$BACK] = $e->[$ROOT][$BACK];
    $e->[$ROOT][$BACK] = $e->[$ROOT][$FORW] = $ROOT;
    # $self->_assert or croak '_clear: fail post condition';
    return $self;
}

sub _assert {
    my($self) = @_;
    my $e = $self->{'_list'};
    for my $i (0 .. $#{$e}) {
        return if ! ($e->[$e->[$i][$BACK]]->[$FORW] == $i
                  && $e->[$e->[$i][$FORW]]->[$BACK] == $i);
    }
    my %idx = %{$self->{'_index'}};
    my $j = $e->[$ROOT][$FORW];
    while ($j != $ROOT) {
        my $key = $e->[$j][$FKEY];
        return if ! exists $idx{$key};
        return if $idx{$key} != $j;
        delete $idx{$key};
        $j = $e->[$j][$FORW];
    }
    return if %idx;
    return 'good';
}

1;

__END__

=pod

=head1 NAME

Cache::Lrq - Least recently used cache queue in pure perl.

=head1 VERSION

0.02

=head1 SYNOPSIS

    use Cache::Lrq;

    my $cache_lrq = Cache::Lrq->new; # 256 keys in default
    my $cache_lrq = Cache::Lrq->new(size => 16); # 16 keys
    $cache_lrq->set($key => $value);
    $value = $cache_lrq->get($key); # undef if not exists.
    $latest_value = $cache_lrq->remove($key);

=head1 DESCRIPTION

This module provides you to put objects temporary in the
sized queue working on Least Recently Used (LRU) way.
The queue are the combination of a doubly linked ring
and a hash index.

=head1 METHODS 

Compatible with Kazuho Oku's L<Cache::LRU> module.

=over

=item C<< Cache::Lrq->new(size => $maximum_number_of_keys) >>

=item C<< $cache_lrq->set($key => $value) >>

=item C<< $cache_lrq->get($key) >>

=item C<< $cache_lrq->remove($key) >>

=back

=head1 DEPENDENCIES

None on runtime.
L<Test::Base> on test.

=head1 SEE ALSO

L<Tie::Cache::LRU>
L<Cache::LRU>

=head1 AUTHOR

MIZUTANI Tociyuki  C<< <tociyuki@gmail.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2013, MIZUTANI Tociyuki.  All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

=cut

