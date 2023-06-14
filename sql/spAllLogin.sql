USE [hospitalCare]
GO

/****** Object:  StoredProcedure [dbo].[spAdminLogin]    Script Date: 23-05-2023 14:46:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter procedure [dbo].[spAllLogin]
(
	@Email varchar(255),
	@Password varchar(255)
)
as
Begin
	declare @result int = 0
	if exists (select * from AdminTable where adminEmail = @Email And adminPassword = @Password)
	begin
		set @result = 1
		select @result 
	end
	else
		begin
			if exists (select * from DoctorTable where doctorEmail = @Email And doctorPassword = @Password)
			begin
				set @result = 2
				select @result 
			end
			else
			begin
				if exists (select * from PatientTable where PatientEmail = @Email And PatientPassword = @Password)
				begin
					set @result = 3
					select @result 
				end
				else
					begin
						set @result = 0
						return @result 
					end
			end
		end

End
GO


exec [spAllLogin]
	@Email = 'admin@gmail.com',
	@Password = 'admin@123'