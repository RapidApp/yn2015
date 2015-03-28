use strict;
use warnings;

use FindBin '$Bin';
use Plack::App::File;
use Plack::Builder;

my $app = Plack::App::File->new( root => "$Bin/slides" )->to_app; 

builder {

  enable 'Headers',
    set => [ 'Cache-Control' => 'no-cache' ];

  sub {
    my $env = shift;
    
    # Redirect /fs to /fs/
    return [ 302 => ['Location' => "$env->{SCRIPT_NAME}/"], [ ] ] if ($env->{PATH_INFO} eq '');
    
    # Default document:
    $env->{PATH_INFO} = '/index.html' if ($env->{PATH_INFO} eq '/');
      
    $app->($env)
  };
}