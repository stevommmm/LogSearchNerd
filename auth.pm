#class auth
package auth;
use strict;
use constant TRUE => 1;
use constant FALSE => 0;
my $self = undef;

sub new {
    my ($class) = @_;
    my $self = {
        _AuthFile => undef,
    };
    bless $self, $class;
    return $self;
}

sub construct {
    my ( $self, $authfile ) = @_;
    $self->{_AuthFile} = $authfile if defined($authfile);
    return;
}

sub checkUser {
    my ( $self , $username, $password ) = @_;
        if ($self->isInFile($username,$password)){
                return TRUE;
        }
        return FALSE;
}

sub isInFile {
		# No encryption implemented, coming soon-ish.
		### Do NOT send this live ###
        my ( $self , $username, $password ) = @_;
        open PWFILE, $self->{_AuthFile} or die $!;
        while (my $line = <PWFILE>) {
                chomp($line);
				if ($line =~ /^#_:/) {
					if ("#_:$username:$password" eq "$line") {
							return TRUE;
					}
				}
        }
        return FALSE;
}

1;