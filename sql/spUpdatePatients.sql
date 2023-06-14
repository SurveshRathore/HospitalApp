use hospitalCare

create procedure spUpdatePatient
(
	@PatientId int,
	@DoctorFirstName varchar(255),
	@DoctorLastName varchar(255),
	@DoctorGender varchar(255),
	@DoctorEmail varchar(255),
	@DoctorContactNumber varchar(255),
	@DoctorSpecialization varchar(255),
	@DoctorQualification varchar(255)
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result int = 0;
				if not exists (select * from PatientTable where PatientEmail = @PatientEmail and PatientId = @PatientId)
				begin
					Set @Result = 1;
					THROW 52000, 'Email Id not Exists', -1;
				end

				else
					Begin
							update PatientTable
							set
							PatientFirstName = @PatientFirstName, 
							PatientLastName = @PatientLastName, 
							PatientGender = @PatientGender, 
							PatientEmail = @PatientEmail, 
							PatientContactNumber = @PatientContactNumber 
							
							where PatientId = @PatientId

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

exec spUpdatePatient

	@PatientId = 1,
	@PatientFirstName = 'patient new name',
	@PatientLastName = 'patient last name',
	@PatientGender = 'Male',
	@PatientEmail = 'patient1@gmail.com',
	@PatientContactNumber = '9876543210'