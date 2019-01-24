# !/usr/bin/perl
#use strict;
use warnings;
use DBI;

my $choice = 10;
my $a = "";
my $dbh = DBI -> connect("DBI:Pg:dbname=pwintrin;host=dbserver","pwintrin","cacapizza",
{'RaiseError' => 1}) or die "/!/ CONNECTION PROBLEM /!/";

sub display () {
  while($choice != 0){
      print ("\nWhatever do thou wish to display, kind sir or ma'am ?\n");
      $choice = display_menu();
        chomp ($choice);
        if($choice == 1){
          my $req1 = $dbh->prepare("SELECT * FROM Hostel") or die $dbh->errstr();
          $req1->execute() or die $req1->errstr();
          while (my @t = $req1->fetchrow_array()) {
          print join(" ",@t),"\n";
          }
        }
        elsif($choice == 2) {
          my $req2 = $dbh->prepare("SELECT * FROM Client") or die $dbh->errstr();
          $req2->execute() or die $req2->errstr();
          while (my @t = $req2->fetchrow_array()) {
          print join(" ",@t),"\n";
          }

        }
        elsif($choice == 3) {
          my $req3 = $dbh->prepare("SELECT * FROM Room") or die $dbh->errstr();
          $req3->execute() or die $req3->errstr();
          while (my @t = $req3->fetchrow_array()) {
          print join(" ",@t),"\n";
          }
        }
        elsif($choice == 4) {
          my $req4 = $dbh->prepare("SELECT * FROM Reservation") or die $dbh->errstr();
          $req4->execute() or die $req4->errstr();
          while (my @t = $req4->fetchrow_array()) {
          print join(" ",@t),"\n";
          }
        }
        elsif($choice == 5) {
          my $req5 = $dbh->prepare("SELECT Manager FROM Hostel") or die $dbh->errstr();
          $req5->execute() or die $req5->errstr();
          while (my @t = $req5->fetchrow_array()) {
          print join(" ",@t),"\n";
          }
        }
        elsif($choice == 6) {
          my $req6 = $dbh->prepare("SELECT COUNT(Manager) FROM Hostel") or die $dbh->errstr();
          $req6->execute() or die $req6->errstr();
          while (my @t = $req6->fetchrow_array()) {
          print join("Number of manager is ",@t),"\n";
          }
        }
        elsif($choice == 7) {
          my $req7 = $dbh->prepare("SELECT Manager FROM Hostel GROUP BY Manager HAVING COUNT(*)>1") or die $dbh->errstr();
          $req7->execute() or die $req7->errstr();
          while (my @t = $req7->fetchrow_array()) {
          print join(" ",@t),"\n";
          }
        }
        elsif($choice == 8) {
          print ("Enter a start date in format YYYY-MM-DD\n");
          my $start=<>;
          chomp ($start);
          while ($start !~ /(\d{4})\-(\d{2})\-(\d{2})/){
            print ("Enter a valid start date, in format YYYY-MM-DD\n");
            $start=<>;
            chomp ($start);
          }
          print ("Enter an end date in format YYYY-MM-DD\n");
          my $end=<>;
          chomp ($end);
          while ($end !~ /(\d{4})\-(\d{2})\-(\d{2})/){
            print ("Enter a valid end date, in format YYYY-MM-DD\n");
            $end=<>;
            chomp ($end);
          }
          my $req8 = $dbh->prepare("SELECT DISTINCT(Room.HostelName) FROM Room LEFT OUTER JOIN Reservation ON Room.NbRoom=Reservation.NbRoom AND Room.HostelName=Reservation.HostelName WHERE 'ResStart'!='$start' AND 'ResEnd'!='$end'") or die $dbh->errstr();
          $req8->execute() or die $req8->errstr();
          while (my @t = $req8->fetchrow_array()) {
          print join(" ",@t),"\n";
          }
        }
        elsif($choice == 9) {
            return;
        }
    }
}


sub Hostelcheck(){
  my $x=0;
  while ($x==0) {
    print "Which Hostel are thou interested in ?\n";
    my $Hostelchoice = <>;
    chomp($Hostelchoice);
    my $req144 = $dbh->prepare("SELECT HostelName FROM Hostel") or die $dbh->errstr();
    $req144->execute() or die $req144->errstr();
    while (my $t = $req144->fetchrow_array()) {
      if ($Hostelchoice eq $t) {
        $x=1;
        return $Hostelchoice;
      }
    }
    if ($x==0) {
      print "That Hostel doesn't exist, am afraid? Mind you, try again.\n";
    }
  }
}


sub upgrade {
  print "What sorts of upgrades would thou wish to accomplish ?\n";
  my $y = 0;
  my $upchoice = 10;
  while($upchoice != 0){
    $upchoice = upgrade_menu();
    chomp($upchoice);
    if($upchoice == 1){
      my $Hostel = Hostelcheck();
      print "Enter the number of the newly added room:\n";
      my $NbNewRoom=<>;
      chomp($NbNewRoom);
      while ($NbNewRoom !~ /(\d*)/){
        print ("Enter a valid number, mind you.\n");
        $NbNewRoom=<>;
        chomp($NbNewRoom);
      }
      print "Enter the price for low season of the newly added room:\n";
      my $NewPriceDown=<>;
      chomp($NewPriceDown);
      while ($NewPriceDown !~ /(\d*)/){
        print ("Enter a valid number, mind you.\n");
        $NewPriceDown=<>;
        chomp($NewPriceDown);
      }
      print "Enter the price for high season of the newly added room:\n";
      my $NewPriceUp=<>;
      chomp($NewPriceUp);
      if ($NewPriceUp<$NewPriceDown){
        print ("The price for high season is under the price for low season, please enter a valid price, mind you.\n");
        $NewPriceUp="notvalid";
      }
      while ($NewPriceUp !~ /(\d*)/){
        print ("Enter a valid number, mind you.\n");
        $NewPriceUp=<>;
        chomp($NewPriceUp);
        if ($NewPriceUp<$NewPriceDown){
          print ("The price for high season is under the price for low season, please enter a valid price, mind you.\n");
          $NewPriceUp="notvalid";
        }
      }
      print ("Enter the type of the newly added room, available types include : Simple, Double, Triple, Suite.\n");
      my $NewRoomType=<>;
      my $z=0;
      chomp($NewRoomType);
      while($z==0){
          if ($NewRoomType eq "Simple" or $NewRoomType eq "Double" or $NewRoomType eq "Triple" or $NewRoomType eq "Suite"){
          $z=1;
        }
        else {
          print ("Enter a valid type for the newly added room, available types include : Simple, Double, Triple, Suite\n");
          $NewRoomType=<>;
          chomp($NewRoomType);
        }
      }
      my $req13 = $dbh->prepare("INSERT INTO Room VALUES('$Hostel', $NbNewRoom, '$NewRoomType', $NewPriceDown, $NewPriceUp)") or die $dbh->errstr();
      $req13->execute() or die $req13->errstr();
      print("New Room added.\n");
      return;
    }

    if($upchoice == 2){
      my $HostelName2 = Hostelcheck();
      print "Who would you wish to change the manager to ?\n";
      my $Manager = <>;
      chomp($Manager);
      my $req16 = $dbh->prepare("UPDATE Hostel SET Manager='$Manager' WHERE HostelName = '$HostelName2'") or die $dbh->errstr();
      $req16->execute() or die $req16->errstr();
      print ("Manager updated.\n");
      return;
    }

    if($upchoice == 3){
      my $flag = 0;
      my $NbRes="";
      while($flag==0){
        print "What would be the number of the reservation thou wish to cancel ?\n";
        $NbRes = <>;
        chomp($NbRes);
        my $reqwhatever = $dbh->prepare("SELECT NbRes FROM Reservation") or die $dbh->errstr();
        $reqwhatever->execute() or die $reqwhatever->errstr();
        while (my $t = $reqwhatever->fetchrow_array()) {
          if ($NbRes == $t) {
            $flag=1;
          }
        }
        if ($flag==0) {
          print "That reservation does not exist am afraid, try again.\n"
        }
      }

      my $req17 = $dbh->prepare("DELETE FROM Reservation WHERE ResStart > CURRENT_DATE+2 AND NbRes = '$NbRes'") or die $dbh->errstr();
      $req17->execute() or die $req17->errstr("You cannot cancel a reservation that starts in less than two days.\n");
      if ($req17 eq "NULL"){
        print ("Thou cannot cancel a reservation that starts in less than two days.\n");
      }
      else{print("Reservation canceled.\n");}
      return;
    }

    if($upchoice == 4){
      print ("When would be the reservation starting ? format YYYY-MM-DD\n");
      my $Resstart=<>;
      chomp($Resstart);
      while ($Resstart !~ /(\d{4})\-(\d{2})\-(\d{2})/){
        print ("Enter a valid start date, in format YYYY-MM-DD\n");
        my $Resstart=<>;
        chomp($Resstart);
      }
      print ("When would be the reservation ending ? format YYYY-MM-DD\n");
      my $Resend=<>;
      chomp($Resend);
      while ($Resend !~ /(\d{4})\-(\d{2})\-(\d{2})/){
        print ("Enter a valid end date, in format YYYY-MM-DD\n");
        $Resend=<>;
        chomp($Resend);
      }
      my $x=0;
      my $y=0;
      my @hostelList;
      my @resTable;
      my $req88 = $dbh->prepare("SELECT nbRes FROM Reservation") or die $dbh->errstr();
      $req88->execute() or die $req88->errstr();
      while (my @t = $req88->fetchrow_array()) {
      push @resTable, @t;
      }


      my $NbRes = (pop @resTable)+1;
      print $NbRes;
      print "Here is a list of the Hotels where a room would be available for that specific period of time.\n";
      my $req888 = $dbh->prepare("SELECT DISTINCT(Room.HostelName) FROM Room LEFT OUTER JOIN Reservation ON Room.NbRoom=Reservation.NbRoom AND Room.HostelName=Reservation.HostelName WHERE 'ResStart'!='$Resstart' AND 'ResEnd'!='$Resend'") or die $dbh->errstr();
      $req888->execute() or die $req888->errstr();
      while (my @t = $req888->fetchrow_array()) {
        push @hostelList, @t;
        print join(" ",@t),"\n";
      }
      my $HostelName3 = "";
      while ($x == 0){
        print "Choose a Hostel from the following list :\n";
        $HostelName3 = <>;
        chomp $HostelName3;
        for (my $i = 0; $i < @hostelList; $i++) {
          if ($HostelName3 eq @hostelList[$i]) {
            $x=1;
          }
        }
      }

      my @roomList;

      print "Here are the available rooms from the Hostel thou selected :\n";
      my $req99 = $dbh->prepare("SELECT DISTINCT( Room.Nbroom) FROM Room LEFT OUTER JOIN Reservation ON Room.NbRoom=Reservation.NbRoom AND Room.HostelName=Reservation.HostelName WHERE 'ResStart'!='$Resstart' AND 'ResEnd'!='$Resend' AND Room.hostelName='$HostelName3'") or die $dbh->errstr();
      $req99->execute() or die $req99->errstr();
      while (my @t = $req99->fetchrow_array()) {
        push @roomList, @t;
        print join(" ",@t),"\n";
      }
      my $Roomname="";

      while ($y == 0){
        print "Choose a room in the following list, mind you :\n";
        $Roomname = <>;
        chomp $Roomname;
        for (my $j = 0; $j < @hostelList; $j++) {
          if ($Roomname == $roomList[$j]) {
            $y=1;
          }
        }
      }
      my $NbRoom = $Roomname;

      my @Clientlist;

      my $req999 = $dbh->prepare("SELECT clientname FROM Client") or die $dbh->errstr();
      $req999->execute() or die $req999->errstr();
      while (my @t = $req999->fetchrow_array()) {
        push @Clientlist, @t;
      }
      my $z =0;
      my $ClientName;
      print "What would be the name of the client ?\n";
      $ClientName = <>;
      chomp $ClientName;
      for (my $l = 0; $l < @Clientlist; $l++) {
        if ($ClientName eq $Clientlist[$l]) {
          $z=1;
        }
      }
      my $ClientPhone;
      if ($z==0){
        print "It seems this client is not in our database. What is the client's phone number ?\n";
        my $ClientPhone = <>;
        chomp $ClientPhone;
        my $req666 = $dbh->prepare("INSERT INTO Client VALUES('$ClientName', '$ClientPhone')") or die $dbh->errstr();
        $req666->execute() or die $req666->errstr();
        print "Client added"
      }

      my $req969 = $dbh->prepare("INSERT INTO Reservation VALUES($NbRes, '$HostelName3', $NbRoom, '$Resstart', '$Resend', '$ClientName')") or die $dbh->errstr();
      $req969->execute() or die $req969->errstr();
      print("Reservation added\n");
      return;
    }
    if($upchoice == 9){
      return;
  }
}
}

sub statistics {
  print "What sort of statistics would thou wish to displayed, kind sir or ma'am ?\n";
  my $statchoice = 10;
  while($statchoice != 0){
      my $x = 0;
      $statchoice = statistics_menu();
      chomp($statchoice);
      if($statchoice == 1){
        my $h = Hostelcheck();
        my $req10 = $dbh->prepare("SELECT CAST (Sum(Reservation.NbRoom) AS DECIMAL) / CAST(Sum(Room.NbRoom) AS DECIMAL) FROM Reservation,Room WHERE Room.HostelName='$h' AND Reservation.ResStart >= CURRENT_DATE -7 AND Reservation.ResEnd <= CURRENT_DATE") or die $dbh->errstr();
        $req10->execute() or die $req10->errstr();
        while (my @t = $req10->fetchrow_array()) {
          print join(" ",@t),"\n";
        }
      }
      if ($statchoice == 2) {
        my $req11 = $dbh->prepare("SELECT Room.HostelName,CAST (Sum(Reservation.NbRoom) AS DECIMAL) / CAST(Sum(Room.NbRoom) AS DECIMAL) FROM Reservation,Room WHERE Reservation.ResStart >= CURRENT_DATE -7 AND Reservation.ResEnd <= CURRENT_DATE GROUP BY Room.HostelName") or die $dbh->errstr();
        $req11->execute() or die $req11->errstr();
        while (my @t = $req11->fetchrow_array()) {
          print join(" ",@t),"\n";
        }
      }
      if($statchoice == 3){
        my $req12 = $dbh->prepare("SELECT CAST(MAX(*)AS DECIMAL) FROM (SELECT Room.HostelName,CAST (Sum(Reservation.NbRoom) AS DECIMAL) / CAST(Sum(Room.NbRoom) AS DECIMAL) FROM Reservation,Room WHERE Reservation.ResStart >= CURRENT_DATE -7 AND Reservation.ResEnd <= CURRENT_DATE GROUP BY Room.HostelName) AS test") or die $dbh->errstr();
        $req12->execute() or die $req12->errstr();
        while (my @t = $req12->fetchrow_array()) {
          print join(" ",@t),"\n";
        }
      }
      if($statchoice == 9){
        return;
      }
  }
}



sub menu {
    print "What do you want to do ? \n";
    print "\n\t1 - Select data\n\t2 - Upgrade data\n\t3 - Statistics\n\t4 - Save data\n\t9 - Quit\n";
    $choice = <>;
    return $choice;
}

sub display_menu {
    print "\n\t1 - Hostels\n\t2 - Clients\n\t3 - Rooms\n\t4 - Reservations\n\t5 - Managers \n\t6 - Number of managers\n\t7 - Managers of multiple hostels \n\t8 - Hostels with empty rooms\n\t9 - Quit\n";
    $choice = <>;
    return $choice;
}

sub statistics_menu() {
  print "\n\t1 - Display the occupation rate of the Hostel of your choice during the last seven days.\n\t2 - Display the occupation rates for all Hostels during the last seven days.\n\t3 - Display the Hostel with the highest occupation rate during the last seven days.\n\t9 - Quit\n";
  my $statchoice = <>;
  return $statchoice;
}

sub upgrade_menu(){
  print "\n\t1 - Add a room to a Hostel\n\t2 - Change the name of one of the Hostel managers.\n\t3 - Cancel a reservation\n\t4 - Add a reservation\n\t9 - Quit\n";
  my $upchoice = <>;
  return $upchoice;
}

sub request{
  $a = scalar(@_);
  my @result;
  my $req = $dbh->prepare($a) or die $dbh->errstr();
  $req->execute() or die $req->errstr();
  while (my @t = $req->fetchrow_array()) {
    push(@result,@t);
  }
  return @result;
}

sub save_table{
  my @result;
  my @result2;
  my @result3;
  my $request;
  my $request2;
  my $request3;

  print "Quel nom voulez-vous donner à votre FILE ?\n";
  my $FILE_name = <>;

  open (FILE, "> $FILE_name") || die ("Vous ne pouvez pas créer le FILE \"FILE.txt\"");
  print FILE "<!DOCTYPE html> \n
  <html><head>
  <meta http-equiv='content-type' content='text/html; charset=windows-1252'>
  <meta charset='UTF-8'>
  <title>Result Table</title>
  </head>
  <body>
  <table border='1'>
  <caption> Result Table </caption>
  <tbody><tr> ";

  $request = "SELECT COUNT(Manager) FROM Hostel";
  my $req266465 = $dbh->prepare("$request") or die $dbh->errstr();
  $req266465->execute() or die $req266465->errstr();
  while (my @t = $req266465->fetchrow_array()) {
      print FILE "<td> Nbr of Managers ->{",@t,"} </td>";
  }
  print FILE "</tr> \n";

  $request2 = "SELECT Manager FROM Hostel GROUP BY Manager HAVING COUNT(*)>1";
  my $req468 = $dbh->prepare("$request2") or die $dbh->errstr();
  $req468->execute() or die $req468->errstr();
  while (my @t = $req468->fetchrow_array()) {
    print FILE "<tr>";
    print FILE"<td> Manager's Names </td> <td>",@t," </td>";
    print FILE "</tr> \n";
  }
  $request3 = "SELECT Room.HostelName,CAST (Sum(Reservation.NbRoom) AS DECIMAL) / CAST(Sum(Room.NbRoom) AS DECIMAL) FROM Reservation,Room WHERE Reservation.ResStart >= CURRENT_DATE -7 AND Reservation.ResEnd <= CURRENT_DATE GROUP BY Room.HostelName";
  my $req9876 = $dbh->prepare("$request3") or die $dbh->errstr();
  $req9876->execute() or die $req9876->errstr();
  while (my @t = $req9876->fetchrow_array()) {
    print FILE "<tr>";
    print FILE"<td> ",@t[0],"</td> <td> ",@t[1],"</td>";
    print FILE "</tr> \n";
  }
  print FILE "</tbody></table>;
  </body></html>";
  close (FILE);
}






while($choice != 0) {

    while($choice != 0){
      $choice = menu();
        chomp ($choice);
        if($choice == 1){
          display();
        }
        elsif($choice == 2) {
          upgrade();
        }
        elsif($choice == 3) {
          statistics();
        }
        elsif($choice == 9) {
          exit();
        }
        elsif($choice == 4){
          save_table();
        }
    }
}
