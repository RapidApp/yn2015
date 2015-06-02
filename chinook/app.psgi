use Rapi::Demo::Chinook 1.02;

use Path::Class 'file'; 
my $Bin = file($0)->parent; # Like FindBin

# Make an inline cfg change:
use Rapi::Demo::Chinook::Model::DB;
Rapi::Demo::Chinook::Model::DB->config->{RapidDbic}
  ->{grid_params}{Track}{persist_immediately}{update} = 1;

my $app = Rapi::Demo::Chinook->new({
  chinook_db => "$Bin/chinook.db"
});
$app->init_db(1); # always reset db 

$app->to_app
