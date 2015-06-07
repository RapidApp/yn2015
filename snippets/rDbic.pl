use Plack::App::RapidApp::rDbic;
 
my $app = Plack::App::RapidApp::rDbic->new({
  connect_info => {
    dsn      => 'dbi:mysql:classicmodels',
    user     => 'root',
    password => ''
  }
});

$app->to_app;
