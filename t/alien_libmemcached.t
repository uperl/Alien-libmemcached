use Test2::V0 -no_srand => 1;
use Alien::libmemcached;
use Test::Alien;
use Test::Alien::Diag qw( alien_diag );

alien_ok 'Alien::libmemcached';
alien_diag 'Alien::libmemcached';

my $xs = q{

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <libmemcached/memcached.h>

MODULE = TA_MODULE PACKAGE = TA_MODULE

const char *
version(class)
    const char *class
  CODE:
    RETVAL = memcached_lib_version();
  OUTPUT:
    RETVAL

};

xs_ok $xs, with_subtest {
  my $mod = shift;
  my $version = $mod->version;
  pass 'did not crash';
  note "version = $version";
};

done_testing;
