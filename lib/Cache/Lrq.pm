package Cache::Lrq;
use warnings;
use strict;
use Carp;

our $VERSION = '0.01';

sub new {
    my($class, %arguments) = @_;
    return bless {
        'size' => 256,
        '_list' => [],
        '_index' => {},
        %arguments,
    }, ref $class || $class;
}

sub set {   ## no critic qw(AmbiguousNames)
    my($self, $key, $value) = @_;
    # $self->_assert or croak 'set: fail pre condition';
    if (exists $self->{'_index'}{$key}) {
        $self->get($key);   # rotate
    }
    else {
        if ($self->{'size'} * 2 <= @{$self->{'_list'}}) {
            $self->remove($self->{'_list'}[0]);     # shift
        }
        $self->{'_index'}{$key} = @{$self->{'_list'}};
        push @{$self->{'_list'}}, $key, undef;
    }
    # $self->_assert or croak 'set: fail post condition';
    $self->{'_list'}[$self->{'_index'}{$key} + 1] = $value;
    return $value;
}

sub get {
    my($self, $key) = @_;
    # $self->_assert or croak 'get: fail pre condition';
    return if ! exists $self->{'_index'}{$key};
    my $i = $self->{'_index'}{$key};
    if ($i + 2 < @{$self->{'_list'}}) {
        push @{$self->{'_list'}}, splice @{$self->{'_list'}}, $i, 2;
        $self->_reindex($i);
    }
    # $self->_assert or croak 'get: fail post condition';
    return $self->{'_list'}[$self->{'_index'}{$key} + 1];
}

sub remove {
    my($self, $key) = @_;
    # $self->_assert or croak 'remove: fail pre condition';
    return if ! exists $self->{'_index'}{$key};
    my $i = delete $self->{'_index'}{$key};
    my(undef, $value) = splice @{$self->{'_list'}}, $i, 2;
    $self->_reindex($i);
    # $self->_assert or croak 'remove: fail post condition';
    return $value;
}

sub _reindex {
    my($self, $i) = @_;
    $i ||= 0;
    my $n = @{$self->{'_list'}};
    while ($i < $n) {
        $self->{'_index'}{$self->{'_list'}[$i]} = $i;
        $i += 2;
    }
    return;
}

# _list => [key => value, ..] where order is earliest .. latest
# _index => {key => index of key in _list, ..}
sub _assert {
    my($self) = @_;
    return if @{$self->{'_list'}} > $self->{'size'} * 2;
    my $n = 0;
    for my $key (keys %{$self->{'_index'}}) {
        my $i = $self->{'_index'}{$key};
        return if $i % 2 != 0;
        return if ! exists $self->{'_list'}[$i];
        return if $self->{'_list'}[$i] ne $key;
        ++$n;
    }
    return if @{$self->{'_list'}} != $n * 2;
    return 'good';
}

1;

__END__

=pod

=head1 NAME

Cache::Lrq - Least recently used cache queue in pure perl.

=head1 VERSION

0.01

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
The queue are the combination of a pair list and a hash index.

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

