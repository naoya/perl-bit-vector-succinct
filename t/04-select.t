use strict;
use warnings;

use Test::More qw/no_plan/;

use Bit::Vector::Succinct::Raw;
use Bit::Vector::Succinct;

my $vec = Bit::Vector::Succinct::Raw->new;
$vec->set(1);
$vec->set(2);
$vec->set(3);

my $sucbv = Bit::Vector::Succinct->new($vec);

is $sucbv->size, 32;

## select1 ... i + 1番目の 1 が出現している位置
is $sucbv->select(0, 1), 1;
is $sucbv->select(1, 1), 2;
is $sucbv->select(2, 1), 3;
is $sucbv->select(3, 1), undef;
is $sucbv->select(0, 0), 0;
is $sucbv->select(1, 0), 4;

$vec = Bit::Vector::Succinct::Raw->new;
$vec->set(1);
$vec->set(23);
$vec->set(35);
$vec->set(128);

$sucbv = Bit::Vector::Succinct->new($vec);

is $sucbv->size, 136;

is $sucbv->select(0, 1), 1;
is $sucbv->select(1, 1), 23;
is $sucbv->select(2, 1), 35;
is $sucbv->select(3, 1), 128;
is $sucbv->select(4, 1), undef;

is $sucbv->select(0, 0), 0;
is $sucbv->select(1, 0), 2;
is $sucbv->select(2, 0), 3;
is $sucbv->select(3, 0), 4;
is $sucbv->select(4, 0), 5;
is $sucbv->select(35, 0), 38;
is $sucbv->select(130, 0), 134;
