package Bit::Vector;
use strict;
use warnings;

use constant BSIZE  => (1 << 5);

sub new {
    my ($class, $vec) = @_;

    if (not defined $vec) {
        $vec = pack("V", 0);
    }

    bless \$vec, $class;
}

sub set {
    my ($self, $pos, $val) = @_;

    if (not defined $val) {
        $val = 1;
    }

    vec($$self, $pos, 1) = $val;
}

sub get {
    my ($self, $pos) = @_;
    return vec($$self, $pos, 1);
}

sub get_block {
    my ($self, $pos) = @_;

    ## ulong で取り出すとエンディアンが反転してしまう
    ## perl の vec は BITS が 16 以上の場合入力を BITS/8 にグループ化して
    ## big endian format (pack の n/N) で数値に変換する∴ L ではなく N を使う

    return Bit::Vector->new( pack("N", vec($$self, $pos, BSIZE)) );
}

sub bit_length {
    length(${$_[0]}) * 8;
}

sub as_bitstring {
    unpack("b*", ${$_[0]});
}

sub as_number {
    unpack("V", ${$_[0]});
}

sub as_binary {
    ${$_[0]};
}

sub length {
    CORE::length ${$_[0]};
}

1;
