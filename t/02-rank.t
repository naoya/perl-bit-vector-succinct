use strict;
use warnings;

use Test::More qw/no_plan/;

use Bit::Vector;
use Bit::Vector::Succinct;

my $vec = Bit::Vector->new;
$vec->set(1);
$vec->set(2);
$vec->set(3);

my $sucbv = Bit::Vector::Succinct->new($vec);

is $sucbv->size,        32;

## rank1
is $sucbv->rank(0, 1),   0;
is $sucbv->rank(1, 1),   1;
is $sucbv->rank(2, 1),   2;
is $sucbv->rank(3, 1),   3;
is $sucbv->rank(4, 1),   3;
is $sucbv->rank(5, 1),   3;
is $sucbv->rank(31, 1),  3;
is $sucbv->rank(32, 1),  3;
is $sucbv->rank(33, 1),  3;

## rank0
is $sucbv->rank(0, 0),   1;
is $sucbv->rank(1, 0),   1;
is $sucbv->rank(2, 0),   1;
is $sucbv->rank(3, 0),   1;
is $sucbv->rank(4, 0),   2;
is $sucbv->rank(5, 0),   3;
is $sucbv->rank(6, 0),   4;
is $sucbv->rank(7, 0),   5;
is $sucbv->rank(8, 0),   6;

## FIME: 範囲超えた場合を考慮してない => init には範囲が必要 ... 要サイズ固定?
# is $sucbv->rank(128, 1), 3;
# is $sucbv->rank(255, 1), 3;

$vec = Bit::Vector->new;
$vec->set(1);
$vec->set(23);
$vec->set(35);
$vec->set(128);

$sucbv = Bit::Vector::Succinct->new($vec);

is $sucbv->size,        136; # hmm ...

is $sucbv->rank(1, 1), 1;
is $sucbv->rank(8, 1), 1;
is $sucbv->rank(32, 1), 2;
is $sucbv->rank(35, 1), 3;
is $sucbv->rank(64, 1), 3;
is $sucbv->rank(128, 1), 4;
is $sucbv->rank(150, 1), 4;

is $sucbv->rank(1, 0), 1;
is $sucbv->rank(8, 0), 8;
is $sucbv->rank(32, 0), 31;
is $sucbv->rank(35, 0), 33;
is $sucbv->rank(64, 0), 62;
is $sucbv->rank(128, 0), 125;
is $sucbv->rank(150, 0), 147;
