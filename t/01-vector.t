use strict;
use warnings;

use Test::More qw/no_plan/;

use Bit::Vector;

my $vec = Bit::Vector->new;

is $vec->length,      4;
is $vec->bit_length, 32;
is $vec->as_number,   0;

$vec->set(0);

is $vec->as_number,   1;
is $vec->as_bitstring, '10000000000000000000000000000000';

$vec->set(1);

is $vec->as_number,   3;
is $vec->as_bitstring, '11000000000000000000000000000000';

$vec->set(0 => 0);

is $vec->as_number,   2;
is $vec->as_bitstring, '01000000000000000000000000000000';

$vec->set(2 => 1);

is $vec->as_number,   6;
is $vec->as_bitstring, '01100000000000000000000000000000';

$vec->set(32 => 1);

is $vec->as_number,   6;
is $vec->length,      5;
is $vec->bit_length,  32 + 8;
is $vec->as_bitstring, '0110000000000000000000000000000010000000'; # ここ 64 bit かな...

my $block = $vec->get_block(0);

is $block->as_number,  6;
is $block->length,     4;
is $block->bit_length, 32;
is $block->as_bitstring, '01100000000000000000000000000000';

$block = $vec->get_block(1);

is $block->as_number,  1;
is $block->length,     4;
is $block->bit_length, 32;
is $block->as_bitstring, '10000000000000000000000000000000';

$block = $vec->get_block(2);

is $block->as_number,  0;
is $block->length,     4;
is $block->bit_length, 32;
is $block->as_bitstring, '00000000000000000000000000000000';
