CREATE TABLE Schedule
(
  ScheduleID INT,
  ShiftStartTime TIME NOT NULL,
  ShiftEndTime TIME NOT NULL,
  WeekDay INT NOT NULL,
  ScheduleType INT NOT NULL,
  PRIMARY KEY (ScheduleID)
);

CREATE TABLE Warehouse
(
  WarehouseID INT,
  Address VARCHAR(100) NOT NULL,
  NumberOfRows INT NOT NULL,
  RowSize INT NOT NULL,
  ShelfSize INT NOT NULL,
  PRIMARY KEY (WarehouseID)
);

CREATE TABLE Tariffs
(
  TariffID INT,
  ItemType VARCHAR(30) NOT NULL,
  Price NUMERIC(8,2) NOT NULL,
  PRIMARY KEY (TariffID)
);


CREATE TABLE Passport
(
  PassportID INT,
  Series INT NOT NULL,
  Number INT NOT NULL,
  Surname VARCHAR(20) NOT NULL,
  GivenName VARCHAR(20) NOT NULL,
  Patronymic VARCHAR(20) NOT NULL,
  PRIMARY KEY (PassportID),
  UNIQUE (Series, Number)
);

CREATE TABLE Truck
(
  TruckID INT,
  MaxVolume NUMERIC(5,2) NOT NULL,
  MaxMass NUMERIC(6,2) NOT NULL,
  PlateNumber VARCHAR(9)UNIQUE NOT NULL,
  PRIMARY KEY (TruckID)
);

CREATE TABLE Customer
(
  ClientID INT,
  EMail VARCHAR(40) NOT NULL,
  PhoneNumber VARCHAR(20) NOT NULL,
  PassportID INT NOT NULL,
  PRIMARY KEY (ClientID),
  FOREIGN KEY (PassportID) REFERENCES Passport(PassportID)
);

CREATE TABLE "Order"
(
  OrderID INT,
  Row INT,
  Shelf INT,
  Place INT,
  RegistrationDate DATE NOT NULL,
  WarehouseID INT,
  ClientID INT NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID),
  FOREIGN KEY (ClientID) REFERENCES Customer(ClientID)
);

CREATE TABLE Moovers
(
  MooverID INT,
  PhoneNumber VARCHAR(20) NOT NULL,
  PassportID INT NOT NULL,
  PRIMARY KEY (MooverID),
  FOREIGN KEY (PassportID) REFERENCES Passport(PassportID)
);

CREATE TABLE Guard
(
  GuardID INT,
  WarehouseID INT NOT NULL,
  PassportID INT NOT NULL,
  PRIMARY KEY (GuardID),
  FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID),
  FOREIGN KEY (PassportID) REFERENCES Passport(PassportID)
);

CREATE TABLE AssignedMoover
(
  AssignMooverID INT,
  ScheduleID INT NOT NULL,
  MooverID INT NOT NULL,
  PRIMARY KEY (AssignMooverID),
  FOREIGN KEY (ScheduleID) REFERENCES Schedule(ScheduleID),
  FOREIGN KEY (MooverID) REFERENCES Moovers(MooverID)
);

CREATE TABLE AssignedGuard
(
  AssignGUardID INT,
  ScheduleID INT NOT NULL,
  GuardID INT NOT NULL,
  PRIMARY KEY (AssignGUardID),
  FOREIGN KEY (ScheduleID) REFERENCES Schedule(ScheduleID),
  FOREIGN KEY (GuardID) REFERENCES Guard(GuardID)
);

CREATE TABLE Transfer
(
  TransferID INT,
  Type INT NOT NULL,
  Adress VARCHAR(100) NOT NULL,
  Date DATE NOT NULL,
  OrderID INT NOT NULL,
  MooverID INT NOT NULL,
  TruckID INT NOT NULL,
  PRIMARY KEY (TransferID),
  FOREIGN KEY (OrderID) REFERENCES "Order"(OrderID),
  FOREIGN KEY (MooverID) REFERENCES Moovers(MooverID),
  FOREIGN KEY (TruckID) REFERENCES Truck(TruckID)
);

CREATE TABLE Item
(
  ItemID INT,
  Volume NUMERIC(5,2) NOT NULL,
  Mass NUMERIC(6,2) NOT NULL,
  Type VARCHAR(30) NOT NULL,
  StorageStatus INT NOT NULL,
  OrderID INT NOT NULL,
  TarifID INT NOT NULL,
  PRIMARY KEY (ItemID),
  FOREIGN KEY (OrderID) REFERENCES "Order"(OrderID),
  FOREIGN KEY (TarifID) REFERENCES Tariffs(TariffID)
);