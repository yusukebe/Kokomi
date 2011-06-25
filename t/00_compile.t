use strict;
use Test::More;

BEGIN { use_ok 'Kokomi' }

my $kokomi = Kokomi->new;
ok( $kokomi );

done_testing;
