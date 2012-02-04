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
print $q->start_html('Dev Perl Log Search');
print $q->h1('Perl&lt;3');

# -- Check all params are passed.
die "Param error." unless defined $q->param('user');
die "Param error." unless defined $q->param('pass');
die "Param error." unless defined $q->param('reg');
die "Param error." unless defined $q->param('day');
# -- End param check.

my $regex = $q->param('reg');
# -- Check if user is authenticated --
my $username = $q->param('user');
my $password = $q->param('pass');
if (!$auth->checkUser($username,$password)) {
        die "User not Authenticated.";
}
print $q->p($regex); #debug, remove.

my @servers = ();
push(@servers, "creative") if defined $q->param('C');
push(@servers, "survival") if defined $q->param('S');
push(@servers, "pve") if defined $q->param('P');
my $day_limit = $q->param('day');
die if $day_limit > 10;

foreach $server (@servers) {
	print "<a href=\"#$server\">$server</a><br>";
}

foreach $server (@servers) {
	print $q->h1("$server\n");
	print "<a name=\"$server\"></a>";
	@files = </home/reddit/logs/$server/*.gz>;
	foreach $filename (@files) {
		if (-M $filename < $day_limit) {
			open FILE, "gunzip -c $filename|" or die $!;
			while (my $line = <FILE>) {
				if ($line =~ m/$regex/is) {
					$line =~ s/�[a-f0-9]//g;
					$line =~ s/\[[a-z0-9]+m//g;
					$line =~ s/</&lt;/g;
					$line =~ s/>/&gt;/g;
					print $q->p($line);
				}
			}
			close FILE;
		}
	}
}

print $q->end_html;