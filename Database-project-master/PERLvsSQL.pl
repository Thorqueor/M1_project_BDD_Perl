#!/usr/bin/perl
use strict;
use DBI;

my $file;
my $cpt;
my $v1;my $v2;my $v3;my $v4;my $v5;my $v6;
my $line;
my $str;
my @namesList;
my @v1List;
my @v2List;
my $roomCounter;
my $reservationCounter;

# Requête sur table des hotêls
$file='Hostel.csv';
open (F,$file) or die "Could not open file";
$cpt=0;
while ($line = <F>) {
  if ($cpt!=0) {
    chomp $line;
    ($v1,$v2,$v3) = split ",", $line;
    #nom des différents Hotêls (V1)
    push(@namesList,$v1);
  }
  $cpt=$cpt+1;
}


# Requête sur table des chambres
$file='Room.csv';
open (F,$file) or die "Could not open file";
$cpt=0;
while ($line = <F>) {
  if ($cpt!=0) {
    chomp $line;
    ($v1,$v2,$v3,$v4,$v5) = split ",", $line;
    #on push $v1 dans @v1 et ensuite on compte le nombre d'occurence de chaque nom d'hôtel
    push @v1List, $v1;
  }
  $cpt=$cpt+1;
}


# Requête sur table des réservations
$file='Reservation.csv';
open (F,$file) or die "Could not open file";
$cpt=0;
while ($line = <F>) {
  if ($cpt!=0) {
    chomp $line;
    ($v1,$v2,$v3,$v4,$v5,$v6) = split ",", $line;
    #nombre de réservations totale pour chaque hôtel
    push @v2List, $v2;
  }
  $cpt=$cpt+1;
}

for (my $i = 0; $i < @namesList; $i++) {
  $roomCounter=0;
  $reservationCounter=0;
  print $namesList[$i];
  for (my $j = 0; $j < @v1List; $j++){
    if ($v1List[$j] eq $namesList[$i]){
      $roomCounter++;
    }
  }
  print " ",$roomCounter;

  for (my $k = 0; $k < @v2List; $k++){
    if ($v2List[$k] eq $namesList[$i]){
      $reservationCounter++;
    }
  }
  print " ",$reservationCounter,"\n";
}
