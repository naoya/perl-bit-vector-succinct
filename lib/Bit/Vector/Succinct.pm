package Bit::Vector::Succinct;
use strict;
use warnings;
use base qw/Class::Accessor::Lvalue::Fast/;

our $VERSION = '0.01';

use integer;
use Bit::Vector::Succinct::Util qw/popcount/;

use constant BSIZE    => (1 << 5);
use constant LEVEL_SB => (1 << 8);
use constant LEVEL_TB => (1 << 5);

__PACKAGE__->mk_accessors(qw/bv size block_size sb tb sb_size tb_size/);

sub new {
    my ($class, $vec) = @_;
    my $self = $class->SUPER::new;

    $self->bv   = $vec;
    $self->size = $vec->bit_length;

    $self->block_size = ($self->size + BSIZE - 1) / BSIZE;
    $self->sb_size = $self->size / LEVEL_SB + 1;
    $self->tb_size = $self->size / LEVEL_TB + 1;
    $self->sb      = [];
    $self->tb      = [];

    $self->build_table;

    bless $self, $class;
}

sub build_table {
    my $self = shift;

    my $r = 0;
    for (my $i = 0; $i <= $self->size; $i++) {
        if ($i % LEVEL_SB == 0) {
            $self->sb->[ $i / LEVEL_SB ] = $r;
        }

        if ($i % LEVEL_TB == 0) {
            $self->tb->[ $i / LEVEL_TB ] = $r - $self->sb->[ $i / LEVEL_SB ];
        }

        if ($i != $self->size and $i % BSIZE == 0) {
            $r += popcount( $self->bv->get_block( $i / BSIZE )->as_number );
        }
    }
}

sub _rank1 {
    my ($self, $pos) = @_;

    my $remain  = $pos    % LEVEL_TB;
    my $remainp = $remain % BSIZE;

    my $r = $self->sb->[ $pos / LEVEL_SB ] + $self->tb->[ $pos / LEVEL_TB ];
    $r += popcount( $self->bv->get_block( $pos / BSIZE )->as_number & ((1 << $remainp) - 1) );

    return $r;
}

sub rank {
    my ($self, $pos, $bit) = @_;
    $pos++;

    $bit ? $self->_rank1($pos) : $pos - _rank1($pos);
}

1;
__END__

=head1 NAME

Bit::Vector::Succinct - Succinct Data Structure for a bit vector

=head1 SYNOPSIS

  use Bit::Vector::Succinct;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Bit::Vector::Succinct, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head1 SEE ALSO

L<http://codezine.jp/article/detail/260>

=head1 AUTHOR

Naoya Ito, E<lt>naoya at blochakers.net E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Naoya Ito

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
