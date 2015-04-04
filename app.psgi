use strict;
use warnings;

use Path::Class qw/file dir/;
my $Bin = file($0)->parent->stringify; # Like FindBin but safer

use Plack::Builder;

use Plack::Util;
sub load_psgi { Plack::Util::load_psgi(@_) }

builder {
  
  mount '/slides/'  => load_psgi("$Bin/slides.psgi");
  mount '/chinook/' => load_psgi("$Bin/chinook/chinook.psgi");
  mount '/fs/'      => load_psgi("$Bin/fs.psgi");
  
  # Redirect root requests to the slideshow:
  mount '/' => sub { 
    [ 307 => ['Location' => "/slides/"], [ ] ] 
  };
};
