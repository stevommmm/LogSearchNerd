#!/usr/bin/perl
use Cwd 'abs_path';
use File::Basename;
use lib dirname( abs_path $0 );
# -- Auth --
use auth;
my $auth = new auth();
$auth->construct("./authfile.pl","MyrandomSalt:adjvbevbf8rg3983r");
# -- Auth End --
use CGI;
$q = CGI->new;
print $q->header;

# -- Check all params are passed.
die "Param error." unless defined $q->param('user');
die "Param error." unless defined $q->param('pass');
die "Param error." unless defined $q->param('newuser');
die "Param error." unless defined $q->param('newpass');
# -- End param check.

# -- Check if user is authenticated --
my $username = $q->param('user');
my $password = $q->param('pass');
if (!$auth->checkUser($username,$password)) {
        die "User not Authenticated.";
}

my $newusername = $q->param('newuser');
my $newpassword = $q->param('newpass');
$auth->addNewUser($newusername,$newpassword);
$auth->removeUser($newusername,$newpassword);