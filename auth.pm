#class auth
package auth;
use strict;
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

## Ban related methods ##

sub checkUser {
    my ( $self , $username, $password ) = @_;
    return true;
}

1;
