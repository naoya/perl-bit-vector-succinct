use strict;
use warnings;

use Test::More qw/no_plan/;

use Bit::Vector::Succinct::Util qw/popcount/;

is popcount(0), 0;
is popcount(1), 1;
is popcount(2), 1;
is popcount(3), 2;
is popcount(4), 1;
is popcount(5), 2;
is popcount(6), 2;
is popcount(0xff), 8;
is popcount(0x100), 1;
