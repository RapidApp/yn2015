use strict;
use warnings;

use Rapi::Fs 1.101;
use FindBin '$Bin';

my $app = Rapi::Fs->new({
  mounts => [{
    name => 'approot',
    args => $Bin
  }]
});


$app->to_app
