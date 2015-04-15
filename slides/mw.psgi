# Custom middleware joins multiple files into one
use Path::Class 'file'; my $Bin = file($0)->parent;
my ($path,$for) = ("$Bin/slides",'/slides/slides.html');

sub { 
  my $app = shift;
  sub {
    my $env = shift;
    if ($for && $env->{PATH_INFO} eq $for) {
      my @files = (); my $slidedir = dir( $path )->resolve;
      $slidedir->recurse( preorder => 1, depth_first => 1,
        callback => sub { push @files, $_[0] if (-f $_[0]); }
      );
      my $html = join('', map { $_->slurp } sort @files);
      return [ 200 => [ 'Cache-Control'  => 'no-cache',
        'Content-Length' => length($html),
        'Content-Type'   => 'text/html; charset=utf-8'
      ], [ $html ] ]
    }
    $app->($env)
  }
}
