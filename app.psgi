use strict;
use warnings;

use FindBin '$Bin';

use Plack::Util;
use Plack::Builder;

builder {
  #enable "SimpleLogger";  # show on STDERR #<-- this barfs after moving to the separate psgi
  
  mount '/slides/'   => Plack::Util::load_psgi("$Bin/slides.psgi");
  mount '/chinook/'  => Plack::Util::load_psgi("$Bin/chinook.psgi");
  mount '/fs/'       => Plack::Util::load_psgi("$Bin/fs.psgi");
  
  # Redirect root requests to the RapidApp homepage:
  mount '/' => sub { [ 307 => ['Location' => "/slides/"], [ ] ] };
};
