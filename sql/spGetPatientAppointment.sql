create procedure spGetPatientAppointment
(
	@PatientId int
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if exists (select * from PatientTable where PatientId = @PatientId)
				BEGIN

					select * from AppointmentTable where PatientId = @PatientId
					Set @Result = 'Patient Appointment list fetch successfully';
				END
				else
				begin
					Set @Result = 'Patient Id not Exists';
					THROW 52000, 'Patient Id not Exists', -1;
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

exec spGetPatientAppointment

	@PatientId  = 1
