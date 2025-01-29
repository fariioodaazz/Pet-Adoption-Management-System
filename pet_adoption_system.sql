create database pet_adoption_system;
use pet_adoption_system;

CREATE USER 'newuser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'yourpassword';
GRANT ALL PRIVILEGES ON pet_adoption_system.* TO 'newuser'@'localhost';
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'newuser'@'localhost';

CREATE TABLE if not exists Shelter (
shelterName varchar(200),
shelterLocation varchar(300),
shelterCapacity int,
shelterID int,
shelterContactInfo varchar(300),
shelterType enum("Breed-specific", "Speciality Rescue", "Wildlife Rehabilation", "Exotic Animals"),
PRIMARY KEY (shelterID)
);
 
SELECT user, host, plugin FROM mysql.user WHERE user='root';

 
CREATE TABLE if not exists Animal (
animalID int NOT NULL,
animalName varchar(100) NOT NULL,
animalSpecies varchar(100),
animalBreed varchar(100),
animalDateOfBirth int ,
shelterID int,
animal_Health_Status varchar(300),
animalAvailabilty boolean,
FOREIGN KEY (shelterID) REFERENCES Shelter (shelterID) ON DELETE RESTRICT,
PRIMARY KEY (animalID)
);



create table if not exists Adopter (
adopterID int not null,
adopterName varchar(200),
adopterEmail varchar(200),
adopterPhone_Number varchar (200),
adopterAdress varchar (200),
applicationStatus enum('Rejected', 'In Progress', 'Accepted'),
adoptionDate date,
animalID int,
shelterID int,
FOREIGN KEY (animalID) REFERENCES Animal (animalID) ON DELETE SET NULL,
FOREIGN KEY (shelterID) REFERENCES Shelter (shelterID) ON DELETE SET NULL,
PRIMARY KEY (adopterID)
);


create table MedicalHistory(
medID int not null,
treatmentDate date,
treatmentName varchar(100),
animalID int not null,
FOREIGN KEY (animalID) REFERENCES Animal (animalID) ON DELETE CASCADE,
PRIMARY KEY (medID)
);


create table if not exists Employee(
employeeID int,
employeeName varchar(100),
employeeEmail varchar(100),
employeeSalary int,
supervisorID int,
PRIMARY KEY (employeeID),
FOREIGN KEY (supervisorID) REFERENCES Employee(employeeID) ON DELETE SET NULL,
FOREIGN KEY (shelterID) REFERENCES Shelter(shelterID) ON DELETE CASCADE
);


create table if not exists AdoptionFollowUp(
employeeID int,
adopterID int,
followUpDate date,
notes varchar(300),
FOREIGN KEY (employeeID) REFERENCES Employee(employeeID) ON DELETE SET NULL,
FOREIGN KEY (adopterID) REFERENCES Adopter(adopterID) ON DELETE CASCADE,
PRIMARY KEY (employeeID, adopterID)
);