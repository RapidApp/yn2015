BEGIN {
  use Path::Class qw/file dir/;
  $Bin = file($0)->parent->stringify; # Like FindBin
  $lib = "$Bin/CreatureZoo/lib";
}

use lib $lib;

use Rapi::Demo::CreatureZoo;
my $app = Rapi::Demo::CreatureZoo->new(
  plugins   => ['+YN2015::Plugin::DemoAuthOvr'],
  share_dir => "$Bin/CreatureZoo/share",
  data_dir  => "$Bin/CreatureZoo/creaturezoo_data"
);

# Plack/PSGI app:
$app->to_app