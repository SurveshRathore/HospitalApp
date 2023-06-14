


create procedure spSetAppointmentStatus
(
	@AppointmentId int,
	@AppointmentStatus varchar(255) 
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if exists (select * from AppointmentTable where AppointmentId = @AppointmentId)
				BEGIN
					UPDATE AppointmentTable
					SET AppointmentStatus = @AppointmentStatus
					where AppointmentId = @AppointmentId

					
					select * from AppointmentTable where AppointmentId = @AppointmentId
					Set @Result = 'Appointment status change successfully';
				END
				else
				begin
					Set @Result = 'Appointment Id not Exists';
					THROW 52000, 'Appointment Id not Exists', -1;
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

exec spSetAppointmentStatus

	@AppointmentId = 1,
	@AppointmentStatus = 'Confirmed' 

	appointment status
cancled 
confirmed
resched
scheduled
	

	--drop proc spAddDoctor