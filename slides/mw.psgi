# Custom middleware to join multiple files into one

use Path::Class qw/file dir/;
my $Bin = file($0)->parent->stringify; # Like FindBin

my $for  = '/slides/slides.html';
my $path = "$Bin/slides/parts";

sub {
  my $app = shift;
  sub {
    my $env = shift;
    if ($for && $env->{PATH_INFO} eq $for) {
      my $slidedir = dir( $path )->resolve;

      my $html = '';
      $slidedir->recurse(
        preorder => 1, depth_first => 1,
        callback => sub {
          my $File = shift;
          $html .= $File->slurp if (-f $File);
        }
      );

      return [ 200 => [
        'Content-Type'   => 'text/html; charset=utf-8',
        'Content-Length' => length($html),
        'Cache-Control'  => 'no-cache'
      ], [ $html ] ]
    }
    
    $app->($env)
  }
}