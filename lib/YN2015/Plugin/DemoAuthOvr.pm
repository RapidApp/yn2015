package YN2015::Plugin::DemoAuthOvr;
use Moose::Role;
use namespace::autoclean;

use RapidApp::Util qw(:all);

# This is a special plugin for demo use only -- will auto-login
# as admin/pass, if needed, whenever the request referer contains 
# /slides/ which is generated from the iframes in the slideshow

before 'dispatch' => sub {
  my $c = shift;
  
  my $referer = $c->req->header('referer') || '';
  if($referer =~ /slides/) {
    if(my $AuthC = $c->controller('Auth')) {
      unless ($c->session && $c->session_is_valid and $c->user_exists) {
        $AuthC->do_login($c,'admin','pass');
      }
    }
  }
};


1;
