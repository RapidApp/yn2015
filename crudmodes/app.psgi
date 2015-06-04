use Rapi::Demo::CrudModes 0.001;

use Path::Class 'file'; 
my $Bin = file($0)->parent; # Like FindBin

my $app = Rapi::Demo::CrudModes->new(
  data_dir       => "$Bin/crudmodes_data",
  clear_data_dir => 1
);

# Plack/PSGI app:
$app->to_app