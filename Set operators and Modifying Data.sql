Use MetroAlt

--1) Create a Union between Person and PersonAddress in Community assist and Employee in MetroAlt. You will need to fully qualify the tables in the CommunityAssist part of the query:
--CommunityAssist.dbo.Person etc.
Select EmployeeZipCode, EmployeeCity--both sides of the union have to have the same structure
From Employee
Union
Select PersonAddressZip,  PersonAddressCity
From Community_Assist.dbo.PersonAddress

--2) Do an intersect between the PersonAddress and Employee that returns the cities that are in both.
Select EmployeeCity
From Employee
Intersect
Select PersonAddressCity
From Community_Assist.dbo.PersonAddress

--3) Do an except between PersonAddress and Employee that returns the cities that are not in both.
Select EmployeeCity
From Employee 
Except
Select PersonAddressCity
From Community_Assist.dbo.PersonAddress

--4) For this we will use the Data Tables we made in Assignment 1. Insert the following services
--into BusService: General Maintenance, Brake service, hydraulic maintenance, and Mechanical Repair.
--You can add descriptions if you like. Next add entries into the Maintenance table for busses 12 and 24.
--You can use today’s date. For the details on 12 add General Maintenance and Brake Service, for
--24 just General Maintenance. You can use employees 60 and 69 they are both mechanics.


--5) Create a table that has the same structure as Employee, name it Drivers. 
--Use the Select form of an insert
--to copy all the employees whose position is driver (1) into the new table.
CREATE TABLE Drivers(
	EmployeeKey int NOT NULL,
	DriversLastName nvarchar(255) not null,
	DriversFirstName nvarchar(255) not null,
	DriversAddress nvarchar(255) not null,
	DriversCity nvarchar(255) not null,
	DriversZipCode nchar(5) not null,
	DriversPhone nchar(10) null,
	DriversEmail nvarchar(255) not null,
	DriversHireDate date not null	
)
ALTER TABLE Drivers
ADD CONSTRAINT fk_Employee_Drivers
FOREIGN KEY (EmployeeKey)
References Employee (EmployeeKey);

Insert into Drivers(EmployeeKey, DriversLastName, DriversFirstName, DriversAddress, DriversCity, DriversZipCode, DriversPhone, DriversEmail, DriversHireDate)
Select Employee.EmployeeKey, EmployeeLastName, EmployeeFirstName, EmployeeAddress, EmployeeCity, EmployeeZipCode, EmployeePhone, EmployeeEmail, EmployeeHireDate
From Employee
INNER JOIN EmployeePosition
ON Employee.EmployeeKey = EmployeePosition.EmployeeKey
WHERE PositionKey = '1'

--6) Edit the record for Bob Carpenter (Key 3) so that his first name is Robert and is City is Bellevue
UPDATE Employee
SET EmployeeFirstName='Robert' 
Where EmployeeKey='3'

UPDATE Employee
SET EmployeeCity='Bellevue' 
Where EmployeeKey='3'

--7) Give everyone a 3% Cost of Living raise.
UPDATE EmployeePosition
SET EmployeeHourlyPayRate = (EmployeeHourlyPayRate*1.03)

--8) Delete the position Detailer
DELETE FROM Position
WHERE PositionName='Detailer'




