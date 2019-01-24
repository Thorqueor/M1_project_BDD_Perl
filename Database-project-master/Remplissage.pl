#!/usr/bin/perl
use strict;
use DBI;

my $cpt;
my $v1;my $v2;my $v3;my $v4;my $v5;my $v6;
my $dbh = DBI -> connect("DBI:Pg:dbname=pwintrin;host=dbserver","pwintrin","cacapizza",
{'RaiseError' => 1}) or die "connection error";
my $line;
my $str;

my $file='Hostel.csv';
open (F,$file) or die "Could not open file";
$cpt=0;
while ($line = <F>) {
  if ($cpt!=0) {
    chomp $line;
    ($v1,$v2,$v3) = split ",", $line;
    $str = $dbh -> prepare("INSERT INTO hostel VALUES ('$v1','$v2','$v3')");
    $str -> execute() or die "request error";
  }
  $cpt=$cpt+1;
}

$file='Client.csv';
open (F,$file) or die "Could not open file";
$cpt=0;
while ($line = <F>) {
  if ($cpt!=0) {
    chomp $line;
    ($v1,$v2) = split ",", $line;
    $str = $dbh -> prepare("INSERT INTO client VALUES ('$v1','$v2')");
    $str -> execute() or die "request error";
  }
  $cpt=$cpt+1;
}



$file='Room.csv';
open (F,$file) or die "Could not open file";
$cpt=0;
while ($line = <F>) {
  if ($cpt!=0) {
    chomp $line;
    ($v1,$v2,$v3,$v4,$v5) = split ",", $line;
    $str = $dbh -> prepare("INSERT INTO room VALUES ('$v1','$v2','$v3','$v4','$v5')");
    $str -> execute() or die "request error";
  }
  $cpt=$cpt+1;
}

my $file='Reservation.csv';
open (F,$file) or die "Could not open file";
$cpt=0;
while ($line = <F>) {
  if ($cpt!=0) {
    chomp $line;
    ($v1,$v2,$v3,$v4,$v5,$v6) = split ",", $line;
    $str = $dbh -> prepare("INSERT INTO reservation VALUES ('$v1','$v2','$v3','$v4','$v5','$v6')");
    $str -> execute() or die "request error";
  }
  $cpt=$cpt+1;
}
