#!/usr/bin/perl
use Cwd 'abs_path';
use File::Basename;
use lib dirname( abs_path $0 );
# -- Auth --
use auth;
my $auth = new auth();
 
#set object attributes
$auth->construct("./authfile.txt");
if !($auth->checkUser($q->param('user'),$q->param('pass'))) {
	die
}

# -- Auth End --

use CGI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser); 
$q = CGI->new;
print $q->header;
print $q->start_html('Dev Perl Log Search');
print $q->h1('Perl&lt;3');
my $regex = $q->param('reg');

print $q->p($regex);
#my $filename = './server-2011-09-11-22:46:14.log.gz';
@files = <*>;
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