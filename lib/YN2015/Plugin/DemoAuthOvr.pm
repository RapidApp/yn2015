package YN2015::Plugin::DemoAuthOvr;
use Moose::Role;
use namespace::autoclean;

use RapidApp::Util qw(:all);

# This is a special plugin for demo use only -- will auto-login
# as the user 'admin', if needed, whenever the request contains 
# the query string '?auth_ovr=1'

before 'dispatch' => sub {
  my $c = shift;
  
  my $username = 'admin';
  
  if($c->req->params->{auth_ovr}) {
    if(my $AuthC = $c->controller('Auth')) {
      unless ($c->session && $c->session_is_valid and $c->user_exists) {
        my $user = $c->find_user({ username => $username }) or die "Failed to find user '$username'";
        $c->set_authenticated( $user );
        $c->session->{RapidApp_username} = $username;
        $c->res->header('X-RapidApp-Authenticated' => $username);
      }
    }
  }
};


1;
