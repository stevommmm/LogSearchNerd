#!/usr/bin/perl
use CGI;
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
	    print $q->ul();
	while (my $line = <FILE>) {
			if ($line =~ m/$regex/is) {
					print $q->li($line);
			}
	}
		
	close FILE;
}

print $q->end_html;