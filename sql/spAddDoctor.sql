use hospitalCare

create procedure spAddDoctor
(
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
			Declare @Result varchar(255) = '';
				if exists (select * from DoctorTable where doctorEmail = @DoctorEmail)
				begin
					Set @Result = 'Email Id already Exists';
					THROW 52000, 'Email Id already Exists', -1;
				end

				else
					Begin
							insert into DoctorTable (doctorFirstName, doctorLastName, doctorGender, doctorEmail, doctorContactNumber, doctorSpecialization, doctorQualification) 
							values (@doctorFirstName, @doctorLastName, @doctorGender, @doctorEmail, @doctorContactNumber, @doctorSpecialization, @doctorQualification)

							select * from DoctorTable

							Set @Result = 'doctor details inserted successfully';
					End
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

exec spAddDoctor

	@DoctorFirstName = 'doctor name',
	@DoctorLastName = 'doctor last name',
	@DoctorGender = 'Male',
	@DoctorEmail = 'doctor@gmail.com',
	@DoctorContactNumber = '9876543210',
	@DoctorSpecialization = 'Heart',
	@DoctorQualification = 'MD'

	--drop proc spAddDoctor
