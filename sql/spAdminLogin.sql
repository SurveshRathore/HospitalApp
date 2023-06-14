create procedure spAdminLogin
(
	@adminEmail varchar(255),
	@adminPassword varchar(255)
)
as
Begin
	select * from AdminTable where adminEmail = @adminEmail And adminPassword = @adminPassword
End

insert into AdminTable(adminFirstName, adminLastName, adminEmail, adminPassword) values ('Hospital', 'Admin', 'admin@gmail.com', 'admin@123')