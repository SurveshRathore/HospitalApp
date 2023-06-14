create database hospitalCare

use hospitalCare

create table AdminTable
(
	adminId int primary key identity(1,1),
	adminFirstName varchar(255),
	adminLastName varchar(255),
	adminEmail varchar(255),
	adminPassword varchar(255),
)

create table DoctorTable
(
	doctorId int primary key identity(1,1),
	doctorFirstName varchar(255),
	doctorLastName varchar(255),
	doctorGender varchar(255),
	doctorEmail varchar(255),
	doctorContactNumber varchar(255),
	doctorSpecialization varchar(255),
	doctorQualification varchar(255),

)

create table PatientTable
(
	PatientId int primary key identity(1,1),
	PatientFirstName varchar(255),
	PatientLastName varchar(255),
	PatientGender varchar(255),
	PatientEmail varchar(255),
	PatientContactNumber varchar(255),
	

)

create table AppointmentTable
(
	AppointmentId int primary key identity(1,1),
	AppointmentDate DateTime,
	AppointmentType varchar(255),
	AppointmentDescription varchar(255),
	AppointmentStatus varchar(255) default 'Pending',
	PatientId int foreign key references PatientTable(PatientId),
	doctorId int foreign key references DoctorTable(doctorId)
)

select * from AppointmentTable
--Drop table AppointmentTable

alter table DoctorTable add doctorPassword varchar(255) 
alter table PatientTable add PatientPassword varchar(255) 