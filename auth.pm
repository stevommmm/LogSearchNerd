#!/usr/bin/perl
package auth;
use strict;
use DBI;
use constant TRUE => 1;
use constant FALSE => 0;

my $self = undef;

sub new {
    my ($class) = @_;
    my $self = {
		_Salt => undef,
		_db => undef,
    };
    bless $self, $class;
    return $self;
}

sub construct {
    my ( $self, $salt ) = @_;
	$self->{_Salt} = $salt if defined($salt);
	$self->{_db} = DBI->connect("dbi:SQLite:UserAuth.db", "", "", {RaiseError => 1, AutoCommit => 1});
    return;
}

sub checkUser {
    my ( $self , $username, $password ) = @_;
	my $cryptpass = crypt("$password",$self->{_Salt});
	my $sth = $self->{_db}->prepare(qq{
    SELECT count(*) AS count FROM auth WHERE user= ? AND pass= ?
  	});
  	$sth->execute( $username, $cryptpass);
	 while (my $data = $sth->fetchrow_hashref) {
		if ($data->{count} > 0) {
			return TRUE;
		}
	}
	return FALSE;
}

sub addNewUser {
    my ( $self , $username, $password ) = @_;
	my $cryptpass = crypt("$password",$self->{_Salt});

	$sth = $self->{_db}->prepare(qq{
    	INSERT INTO auth VALUES (id, user,pass) VALUES (?, ?, ?)
  	});
  	$sth->execute(undef, $username, $cryptpass);
}

sub changeUser {
	my ( $self , $username, $password ) = @_;
	my $cryptpass = crypt("$password",$self->{_Salt});
	$sth = $dbh->prepare(qq{
    	UPDATE auth SET pass = ? WHERE user = ?
  	});
  	$sth->execute($cryptpass, $username);
}

1;
