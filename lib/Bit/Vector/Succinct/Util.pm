package Bit::Vector::Succinct::Util;
use strict;
use warnings;
use Exporter::Lite;

our @EXPORT = qw/popcount/;
our @EXPORT_OK = @EXPORT;

sub popcount ($) {
    use integer;
    my $r = shift;

    $r = (($r & 0xAAAAAAAA) >> 1) + ($r & 0x55555555);
    $r = (($r & 0xCCCCCCCC) >> 2) + ($r & 0x33333333);
    $r = (($r >> 4) + $r) & 0x0F0F0F0F;
    $r = ($r >> 8) + $r;

    return (($r >> 16) + $r) & 0x3F;
}

1;
