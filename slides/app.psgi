use Path::Class qw/file dir/;
my $Bin = file($0)->parent->stringify; # Like FindBin

use Plack::Builder;
use Plack::App::File;
my $app = Plack::App::File->new( root => "$Bin" )->to_app; 

builder {
  enable 'Headers', set => [ 'Cache-Control' => 'no-cache' ];
  sub {
    my $env = shift;
    $env->{PATH_INFO} = '/index.html' if ($env->{PATH_INFO} eq '/');
    $env->{PATH_INFO} eq '' # i.e. redirect /foo to /foo/
      ? [ 302 => ['Location' => "$env->{SCRIPT_NAME}/"], [] ] 
      : $app->($env)
  };
}
