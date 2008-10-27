use inc::Module::Install;

perl_version '5.8.1';
name 'Bit-Vector-Succinct';

all_from 'lib/Bit/Vector/Succinct.pm';

requires 'perl' => '5.8.1';
requires 'Class::Accessor::Lvalue::Fast';

auto_install;

WriteAll;
