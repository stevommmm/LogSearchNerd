#!/usr/bin/perl
use Cwd 'abs_path';
use File::Basename;
use lib dirname( abs_path $0 );
# -- Auth --
use auth;
my $auth = new auth();
$auth->construct("5551efeffesafesf");
# -- Auth End --

if (!$auth->checkUser("admin","nerd")) {
        die "User not Authenticated.";
}
print "success\n";
