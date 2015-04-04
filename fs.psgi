use strict;
use warnings;

use Rapi::Fs 1.101;

use Path::Class qw/file dir/;
my $Bin = file($0)->parent->stringify; # Like FindBin but safer

my $app = Rapi::Fs->new({
  mounts => [{
    name => 'approot',
    args => $Bin
  }]
});


$app->to_app
