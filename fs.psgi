use Rapi::Fs 1.104;

use Path::Class 'file'; 
require Module::Locate;

my $Bin  = file($0)->parent->stringify; # Like FindBin
my $pmf  = Module::Locate::locate('Rapi::Fs');
my $plib = file( $pmf )->parent->parent->stringify;


my $app = Rapi::Fs->new({ mounts => [
  { name => 'approot',  args => "$Bin"  },
  { name => 'perllib',  args => "$plib" }
]});

$app->to_app
