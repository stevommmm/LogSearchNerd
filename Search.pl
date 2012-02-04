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
use CGI::Carp qw(warningsToBrowser fatalsToBrowser); # Remove when testing is done!
$q = CGI->new;
print $q->header;
print $q->start_html('Dev Perl Log Search');
print $q->h1('Perl&lt;3');
my $regex = $q->param('reg');
# -- Check if user is authenticated --
my $username = $q->param('user');
my $password = $q->param('pass');
if (!$auth->checkUser($username,$password)) {
        die "User not Authenticated.";
}
print $q->p($regex);

my @servers = ();
push(@servers, "Creative") if defined $q->param('C');
push(@servers, "Survival") if defined $q->param('S');
push(@servers, "Pve") if defined $q->param('P');

foreach $server (@servers) {
	print "/home/reddit/logs/$server/*\n";
}


@files = <*.gz>;
foreach $filename (@files) {
	open FILE, "gunzip -c $filename|" or die $!;
	while (my $line = <FILE>) {
		if ($line =~ m/$regex/is) {
			print $q->p($line);
		}
	}
	close FILE;
}

print $q->end_html;