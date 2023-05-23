use hospitalCare

create table AppointmentNewTable
(
	AppointmentId int primary key identity(1,1),
	AppointmentDate Date,
	AppointmentStartTime time,
	AppointmentEndTime time,
	AppointmentDisease varchar(255),
	AppointmentDescription varchar(255),
	AppointmentStatus varchar(255) default 'Pending',
	PatientId int foreign key references PatientTable(PatientId),
	doctorId int foreign key references DoctorTable(doctorId)
)