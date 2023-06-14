
create procedure spAddAppointment
(
	@AppointmentDate Date,
	@AppointmentStartTime time,
	@AppointmentEndTime time,
	@AppointmentDisease varchar(255),
	@AppointmentDescription varchar(255),
	@PatientId varchar(255),
	@doctorId varchar(255)
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if exists (select * from DoctorTable where doctorId = @doctorId)
				BEGIN
					if exists (select * from PatientTable where PatientId = @PatientId)
						begin
							insert into AppointmentNewTable (AppointmentDate, AppointmentStartTime, AppointmentEndTime,	AppointmentDisease, AppointmentDescription, PatientId, doctorId) 
							values (@AppointmentDate, @AppointmentStartTime, @AppointmentEndTime, @AppointmentDisease, @AppointmentDescription, @PatientId, @doctorId)

							select * from AppointmentNewTable

							Set @Result = 'Appointment scheduled successfully';
						
						end
					else
					begin
						Set @Result = 'Patient Id not Exists';
						THROW 52000, 'Patient Id not Exists', -1;
					end
				END

				else
				begin
					Set @Result = 'Doctor Id not Exists';
					THROW 52000, 'Doctor Id not Exists', -1;
				end

			commit Transaction

			return @Result
	End Try
	Begin Catch
		
		if(XACT_STATE()) = -1
		begin
				print
					'Transaction is non-commitable' + ' Rolling Back Transaction'
					RollBack Transaction;
					Print @Result;
					return @result;
		end

		Else if(XACT_STATE()) = 1
		Begin
			Print
				'Transaction is Complitable' + 'Commiting Back Transaction'
				COMMIT TRANSACTION;
				Print @Result;
				return @result;
		End;
		--print 'Unable to Add doctor'
	End Catch
END
GO


