use strict;
use warnings;

use FindBin '$Bin';

use Plack::Builder;

use Plack::Util;
sub load_psgi { Plack::Util::load_psgi(@_) }

builder {
  
  mount '/slides/'  => load_psgi("$Bin/slides.psgi");
  mount '/chinook/' => load_psgi("$Bin/chinook.psgi");
  mount '/fs/'      => load_psgi("$Bin/fs.psgi");
  
  # Redirect root requests to the slideshow:
  mount '/' => sub { 
    [ 307 => ['Location' => "/slides/"], [ ] ] 
  };
};
