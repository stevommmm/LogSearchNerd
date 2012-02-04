#!/usr/bin/perl
package auth;
use strict;
use constant TRUE => 1;
use constant FALSE => 0;
my $self = undef;

sub new {
    my ($class) = @_;
    my $self = {
		_AuthFile => undef,
		_Salt => undef,
    };
    bless $self, $class;
    return $self;
}

sub construct {
    my ( $self, $authfile, $salt ) = @_;
    $self->{_AuthFile} = $authfile if defined($authfile);
	$self->{_Salt} = $salt if defined($salt);
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
		my $cryptuser = crypt("$username:$password",$self->{_Salt});
        while (my $line = <PWFILE>) {
			chomp($line);
			if ($line =~ /^#_:/) {
				if ("#_:$cryptuser" eq $line) {
					return TRUE;
				}
			}
        }
        return FALSE;
}

sub addNewUser {
        my ( $self , $username, $password ) = @_;
        open PWFILE, '>>', $self->{_AuthFile} or die $!;
		my $cryptuser = crypt("$username:$password",$self->{_Salt});
        print PWFILE "#_:$cryptuser\n";
}

1;