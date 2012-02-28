#!/usr/bin/perl -w

use strict;
use DBI;
use Data::Dumper;
my $db = DBI->connect("dbi:SQLite:UserAuth.db", "", "",
{RaiseError => 1, AutoCommit => 1});

$db->do("CREATE TABLE auth (id INTEGER PRIMARY KEY, user VARCHAR, pass VARCHAR)");
my $cryptpass = crypt("admin","MyCryptSalt");

$sth = $self->{_db}->prepare(qq{
	INSERT INTO auth VALUES (id, user,pass) VALUES (?, ?, ?)
});
$sth->execute(undef, "admin", $cryptpass);
