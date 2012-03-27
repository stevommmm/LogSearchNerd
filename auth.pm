#!/usr/bin/perl
package auth;
	use strict;
	use constant TRUE => 1;
	use constant FALSE => 0;

	my $self = undef;

	sub new {
		my ($class) = @_;
		my $self = {
			_Salt => undef
		};
		bless $self, $class;
		return $self;
	}

	sub construct {
		my ( $self, $salt ) = @_;
		$self->{_Salt} = $salt if defined($salt);
		return;
	}

	sub checkUser {
		my ( $self , $username, $password ) = @_;
		my $cryptpass = crypt("$password",$self->{_Salt});
		open FILE, "<", "authfile.pl" or die;
		while (my $line = <FILE>) {
			chomp($line);
			if ($line eq "+_$username:$cryptpass") {
				return TRUE;
			}
		}
		return FALSE;
	}

	sub addUser {
		my ( $self , $username, $password ) = @_;
		my $cryptpass = crypt("$password",$self->{_Salt});
		open FILE, ">>", "authfile.pl" or die;
		print FILE "+_$username:$cryptpass\n";
	}

1;
