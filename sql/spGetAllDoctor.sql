use hospitalCare

create proc spGetAllDoctor
as
BEGIN
	select * from DoctorTable
END