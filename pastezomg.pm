#! /usr/bin/perl
package pastezomg;
use LWP::UserAgent;
# paste.thezomg script

my $self = undef;

sub new {
    my ($class) = @_;
    my $self = {
		_user => undef,
    };
    bless $self, $class;
    return $self;
}

sub construct {
    my ( $self, $user ) = @_;
    $self->{_user} = $user if defined($user);
    return;
}

sub paste {
	my ( $self, $pasteline ) = @_;

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
	return 'http://paste.thezomg.com/' . $id . '/' . $hash ."\n";
}
1;