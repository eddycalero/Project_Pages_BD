
USE YellowPages
GO

CREATE OR ALTER PROC US_DepartamentoEmpresa_Insert(
   	@DepartamentoEmpresaID UNIQUEIDENTIFIER,
	@Name VARCHAR (40)
)
AS
BEGIN
BEGIN TRANSACTION
BEGIN TRY
	INSERT INTO Empresa.DepartamentoEmpresa(
	DepartamentoEmpresaID,[Name])

VALUES(@DepartamentoEmpresaID,@Name)
COMMIT TRANSACTION
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT'Ocurrio un error: US_DepartamentoEmpresa_Insert'

END CATCH
END
GO 

SELECT NEWID()
GO

SELECT * FROM Empresa.DepartamentoEmpresa
GO

EXEC US_DepartamentoEmpresa_Insert 'D09E2056-D6CC-4FDA-BF6D-B91035F2B67A','Masaya'
GO



CREATE OR ALTER  PROC US_EmpresaMunicipio_Insert(
	@MunicipioID UNIQUEIDENTIFIER ,
	@DepartamentoEmpresaID UNIQUEIDENTIFIER,
	@Name VARCHAR(40)
)
AS 
BEGIN
BEGIN TRANSACTION
BEGIN TRY
	INSERT INTO Empresa.Municipio(
		MunicipioID,DepartamentoEmpresaID,[Name]
	)
	VALUES (@MunicipioID,@DepartamentoEmpresaID,@Name)

COMMIT TRANSACTION
END TRY

BEGIN CATCH
ROLLBACK TRANSACTION

PRINT 'OCURRIO UN ERROR:US_EmpresaMunicipio_Insert'

END CATCH
END 
GO

SELECT * FROM Empresa.Empresa
GO

SELECT * FROM Empresa.ContactoEmpresa
GO

EXEC US_EmpresaMunicipio_Insert '6C877944-733E-4801-B311-E800ACBF08AA','2DF55F16-0F3F-448E-AB9F-33E8D6924703','San Rafael del Sur'
GO


GO

CREATE OR ALTER PROC US_AnuncioEmpresa
AS
BEGIN
SELECT r.EmpresaID ,d.Name AS Departamento,x.Name AS Municipio,r.Name AS Empresa,r.Description,r.DireccionWeb,r.DescripcionTwo,r.Direccion
FROM Empresa.DepartamentoEmpresa as d
INNER JOIN Empresa.Municipio AS x
ON d.DepartamentoEmpresaID = x.DepartamentoEmpresaID
INNER JOIN Empresa.Empresa AS r
ON x.MunicipioID = r.MunicipioID
WHERE r.IsActive = 1
END 
GO
select * from Empresa.Empresa
go

EXEC US_AnuncioEmpresa
GO

SELECT * FROM Empresa.DepartamentoEmpresa AS Q
INNER JOIN Empresa.Municipio AS Z
ON Q.DepartamentoEmpresaID = Z.DepartamentoEmpresaID

SELECT NEWID()
GO

CREATE OR ALTER PROC US_Empresa_Insert(
	@Name VARCHAR(40),
	@Description VARCHAR(80),
	@Images1 VARBINARY(MAX) ,
	@DireccionWeb VARCHAR(40),
	@DescripcionTwo VARCHAR(100),
	@ImagenTwo VARBINARY(MAX) ,
	@Direccion VARCHAR(80),
	@Phone VARCHAR(40),
	@Correo VARCHAR(40),
	@NombreOferta VARCHAR (40),
	@NombreOferta2 VARCHAR (40),
	@MunicipioID UNIQUEIDENTIFIER
)
AS
BEGIN
BEGIN TRY
BEGIN TRANSACTION
	DECLARE @EmpresaID UNIQUEIDENTIFIER = NEWID()
	INSERT INTO Empresa.Empresa(
	EmpresaID,MunicipioID,[Name],[Description],Images1,DireccionWeb,
	DescripcionTwo,ImagenTwo,Direccion
	)VALUES(@EmpresaID,@MunicipioID,@Name,@Description,@Images1,@DireccionWeb,@DescripcionTwo,
	@ImagenTwo,@Direccion)

	INSERT INTO Empresa.OfertaEmpresa(
	OfertaEmpresaID,EmpresaID,NombreOferta
	)VALUES(NEWID(),@EmpresaID,@NombreOferta)

	INSERT INTO Empresa.OfertaEmpresa(
	OfertaEmpresaID,EmpresaID,NombreOferta
	)VALUES(NEWID(),@EmpresaID,@NombreOferta2)

	INSERT INTO Empresa.ContactoEmpresa(
	ContactoID,EmpresaID,ContactoName
	)VALUES(NEWID(),@EmpresaID,@Phone)

	INSERT INTO Empresa.ContactoEmpresa(
	ContactoID,EmpresaID,ContactoName
	)VALUES(NEWID(),@EmpresaID,@Correo)

COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT 'Ocurrio un error: US_Empresa_Insert'

END CATCH
END
GO

CREATE OR ALTER PROC US_OfertaEmpresa(
	@OfertaEmpresaID UNIQUEIDENTIFIER,
	@EmpresaID UNIQUEIDENTIFIER,
	@NombreOferta VARCHAR (40)
)
AS
BEGIN
BEGIN TRY
	INSERT INTO Empresa.OfertaEmpresa(
	OfertaEmpresaID,EmpresaID,NombreOferta
	)VALUES(@OfertaEmpresaID,@EmpresaID,@NombreOferta)

COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT 'Ocurrio un error: US_OfertaEmpresa'

END CATCH
END
GO

CREATE OR ALTER PROC US_ContactoEmpresa_Insert(
	@ContactoID UNIQUEIDENTIFIER,
	@EmpresaID UNIQUEIDENTIFIER,
	@ContactoName VARCHAR (40)
)
AS
BEGIN
BEGIN TRY
	INSERT INTO Empresa.ContactoEmpresa(
	ContactoID,EmpresaID,ContactoName
	)VALUES(@ContactoID,@EmpresaID,@ContactoName)

COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT 'Ocurrio un error: US_ContactoEmpresa_Insert'

END CATCH
END
GO


DECLARE @a  varbinary(max) = CAST(1234 AS BINARY(2))
DECLARE @D  varbinary(max) = CAST(56789 AS BINARY(2))

EXEC US_Empresa_Insert 'samsung','Empresa de prueba',@D,'direccion web',
'descripcion 2',@a,'direccion de prueba','23455667','Correo de prueba',
'oferta1','oferta2','6C877944-733E-4801-B311-E800ACBF08AA'
GO

DELETE  FROM Empresa.Empresa 

DELETE FROM Empresa.ContactoEmpresa

DELETE FROM Empresa.OfertaEmpresa

SELECT * FROM Empresa.Empresa

