use strict;
use warnings;

use Rapi::Fs 1.101;

use Path::Class qw/file dir/;
my $Bin = file($0)->parent->stringify; # Like FindBin

my $app = Rapi::Fs->new({
  mounts => [{
    name => 'approot',
    args => $Bin
  }]
});

# Smaller navtree width from the default 230
$app->config
  ->{'Plugin::RapidApp::TabGui'}
  ->{navtree_init_width} = 160;


$app->to_app
