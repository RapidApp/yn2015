use strict;

use Path::Class qw/file dir/;
my $Bin = file($0)->parent->stringify; # Like FindBin

use Plack::Builder;
use Plack::App::File;

my $app = Plack::App::File->new( root => "$Bin" )->to_app; 

builder {
  # Tell the browser not to cache anything (Plack::Middleware::Headers)
  enable 'Headers', set => [ 'Cache-Control' => 'no-cache' ];

  sub {
    my $env = shift;

    if ($env->{PATH_INFO} eq '') { # i.e. redirect /foo to /foo/
      return [ 302 => ['Location' => "$env->{SCRIPT_NAME}/"], [] ];
    }
    elsif ($env->{PATH_INFO} eq '/') { # Default document '/'
      $env->{PATH_INFO} = '/index.html';
    }

    $app->($env)
  };
}