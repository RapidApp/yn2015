use strict;
use warnings;

use Rapi::Demo::Chinook 1.01;
use FindBin '$Bin';

# Make an inline cfg change:
use Rapi::Demo::Chinook::Model::DB;
Rapi::Demo::Chinook::Model::DB
  ->config
  ->{RapidDbic}{grid_params}{Track}{persist_immediately}
  ->{update} = 1;


my $app = Rapi::Demo::Chinook->new({
  chinook_db => "$Bin/chinook.db"
});

# Always start from db in its default state:
$app->init_db(1);

$app->to_app
