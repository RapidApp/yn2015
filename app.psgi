use Path::Class qw/file dir/;
my $Bin = file($0)->parent->stringify; # Like FindBin

use Plack::Builder;
use Plack::Util;
sub load_psgi { Plack::Util::load_psgi(@_) }

builder {
  mount '/slides/'  => load_psgi("$Bin/slides/app.psgi");
  mount '/chinook/' => load_psgi("$Bin/chinook/app.psgi");
  mount '/bluebox/' => load_psgi("$Bin/BlueBox/app.psgi");
  mount '/fs/'      => load_psgi("$Bin/fs.psgi");
  mount '/czoo/'    => load_psgi("$Bin/CreatureZoo/app.psgi");
  
  # Redirect root requests to the slideshow:
  mount '/' => sub { [ 307, ['Location', "/slides/"], [] ] };
};
