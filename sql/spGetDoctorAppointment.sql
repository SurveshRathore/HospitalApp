create procedure spGetDoctorAppointment
(
	@doctorId int
	
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if exists (select * from DoctorTable where doctorId = @doctorId)
				BEGIN

					select * from AppointmentTable where doctorId = @doctorId
					Set @Result = 'doctor Appointment list fetch successfully';
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

exec spGetDoctorAppointment

	@doctorId  = 1

	--drop proc spAddDoctor

	
