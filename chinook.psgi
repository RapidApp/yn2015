use strict;
use warnings;

use Rapi::Demo::Chinook 1.01;
use FindBin '$Bin';

my $app = Rapi::Demo::Chinook->new({
  chinook_db => "$Bin/chinook.db"
});

# Always start from db in its default state:
$app->init_db(1);

$app->to_app
