use hospitalCare

create procedure spAddPatient
(
	@PatientFirstName varchar(255),
	@PatientLastName varchar(255),
	@PatientGender varchar(255),
	@PatientEmail varchar(255),
	@PatientContactNumber varchar(255)
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result int = 0;
				if exists (select * from PatientTable where PatientEmail = @PatientEmail)
				begin
					Set @Result = 1;
					THROW 52000, 'Email Id already Exists', -1;
				end

				else
					Begin
							insert into PatientTable (PatientFirstName, PatientLastName, PatientGender, PatientEmail, PatientContactNumber ) 
							values (@PatientFirstName, @PatientLastName, @PatientGender, @PatientEmail, @PatientContactNumber)

							select * from PatientTable

							Set @Result = 2;
					End
			commit Transaction

			return @Result
	End Try
	Begin Catch
		
		if(XACT_STATE()) = -1
		begin
				print
					'Transaction is Uncomplitable' + 'Rolling Back Transaction'
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
		--print 'Unable to Add patient'
	End Catch
END

exec spAddPatient

	@PatientFirstName = 'patient name',
	@PatientLastName = 'patient last name',
	@PatientGender = 'Male',
	@PatientEmail = 'patient@gmail.com',
	@PatientContactNumber = '9876543210'