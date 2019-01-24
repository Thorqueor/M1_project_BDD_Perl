/**DROP TABLE Reservation,
DROP TABLE Room,
DROP TABLE Client,
DROP TABLE Hostel,
**/
CREATE TABLE Hostel(
HostelName text,
Manager text,
Star integer,
CONSTRAINT pk_hostel PRIMARY KEY (HostelName));

CREATE TABLE Client(
ClientName text,
ClientPhone integer,
CONSTRAINT pk_client PRIMARY KEY (ClientName));

CREATE TABLE Room(
HostelName text,
NbRoom integer,
Type text,
PriceDown integer,
PriceUp integer,
CONSTRAINT fk_hostel FOREIGN KEY (HostelName) REFERENCES Hostel (HostelName),
CONSTRAINT pk_room PRIMARY KEY (HostelName,NbRoom));

CREATE TABLE Reservation(
NbRes integer,
HostelName text,
NbRoom integer,
ResStart date,
ResEnd date,
ClientName text,
CONSTRAINT pk_reservation PRIMARY KEY (NbRes),
CONSTRAINT fk_hostelname FOREIGN KEY (HostelName) REFERENCES Hostel (HostelName),
CONSTRAINT fk_nbroom_hostelname FOREIGN KEY (NbRoom,HostelName) REFERENCES Room (NbRoom,HostelName));
