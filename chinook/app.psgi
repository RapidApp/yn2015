use strict;

use Path::Class qw/file dir/;
my $Bin = file($0)->parent->stringify; # Like FindBin but safer

use Rapi::Demo::Chinook 1.01;

# Make an inline cfg change:
use Rapi::Demo::Chinook::Model::DB;
Rapi::Demo::Chinook::Model::DB->config->{RapidDbic}
  ->{grid_params}{Track}{persist_immediately}{update} = 1;

my $app = Rapi::Demo::Chinook->new({
  chinook_db => "$Bin/chinook.db",
  plugins => [qw/RapidApp::RapidDbic RapidApp::NavCore/],
  config  => { 
    'Model::RapidApp::CoreSchema' => {
      sqlite_file => "$Bin/ra_coreschema.db"
    }
  }
});

# Always start from db in its default state:
$app->init_db(1);

$app->to_app
