#! /usr/bin/perl
use LWP::UserAgent;
use CGI;
$q = CGI->new;
die "Param error." unless defined $q->param('pastedata');
my $pasteline = $q->param('pastedata');
$ua = LWP::UserAgent->new;
my $response = $ua->post('http://paste.thezomg.com',
	["paste_user" => "modreq",
	"paste_data" => $pasteline,
	"paste_lang" => "text",
	"api_submit" => "true",
	"mode" => "xml",
	"paste_private" => "true",]);
my $id = 0;
my $hash = 0;
my $returnob = $response->content;
if ($returnob =~ /.*<id>([0-9]+)<\/id>.*/) {
	$id = $1;
}
if ($returnob =~ /.*<hash>([0-9]+)<\/hash>.*/) {
	$hash = $1;
}
print 'http://paste.thezomg.com/' . $id . '/' . $hash ."\n";