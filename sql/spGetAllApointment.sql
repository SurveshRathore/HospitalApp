use hospitalCare
create procedure spGetAllApointment
as
begin
	select AppointmentTable.AppointmentDate, AppointmentTable.AppointmentType, PatientTable.PatientFirstName, PatientTable.PatientEmail, DoctorTable.doctorFirstName, DoctorTable.doctorEmail
	from AppointmentTable
	inner join PatientTable on AppointmentTable.PatientId = PatientTable.PatientId
	inner join DoctorTable on AppointmentTable.doctorId = DoctorTable.doctorId

end

exec spGetAllApointment