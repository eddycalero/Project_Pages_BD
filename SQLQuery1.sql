
IF NOT EXISTS (SELECT * FROM sysdatabases WHERE (name = 'YellowPages'))
BEGIN
	--Crear database
	CREATE DATABASE YellowPages
	PRINT 'CREACION DE DATABASE'
END
ELSE
BEGIN
	--Eliminar database
	DROP DATABASE YellowPages;
	PRINT 'ELIMINACION DE DATABASE'
	--Crear database
	CREATE DATABASE YellowPages;
	PRINT 'CREACION DE DATABASE'
END

USE YellowPages
GO

--Validacion del login si existe en la instancia
IF (SUSER_ID('Jose') IS NULL) --For Login
BEGIN TRY
EXEC sys.sp_addlogin @loginame = 'Jose',    -- sysname
                @passwd = '12345',      -- sysname
                @defdb = 'YellowPages'       -- sysname
                --@deflanguage = NULL, -- sysname
                --@sid = NULL,         -- varbinary(16)
                --@encryptopt = '';     -- varchar(20)
	PRINT 'LOGIN CREADO'
END TRY
BEGIN CATCH

END CATCH
	---Capturamos

	--Validacion si existe el usuario en la base de datos
IF (DATABASE_PRINCIPAL_ID('Jose') IS NULL) --For User
BEGIN TRY
EXEC sys.sp_adduser @loginame = 'Jose',   -- sysname
               @name_in_db = 'Jose', -- sysname
               @grpname = 'db_owner';     -- sysname
	PRINT 'USER CREADO'
END TRY
BEGIN CATCH
	---Capturamos el mensaje de error
	PRINT 'OCURRIO UN FALLO INESPERADO'
END CATCH
ELSE
BEGIN
	PRINT 'YA EXISTE USER'
END 

GO


CREATE SCHEMA Empresa
GO

CREATE SCHEMA Person
GO


CREATE TABLE Empresa.DepartamentoEmpresa
(
	DepartamentoEmpresaID UNIQUEIDENTIFIER PRIMARY KEY,
	[Name] VARCHAR (40) NOT NULL,
	SucursalName VARCHAR(40) NOT NULL,
	IsActive BIT DEFAULT(1)
)
GO


CREATE TABLE Empresa.Municipio
(
	MunicipioID UNIQUEIDENTIFIER PRIMARY KEY,
	DepartamentoEmpresaID UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Empresa.DepartamentoEmpresa(DepartamentoEmpresaID),
	[Name] VARCHAR(40) NOT NULL,
	IsActive BIT DEFAULT (1)
)
GO


CREATE TABLE Empresa.Empresa
(
	EmpresaID UNIQUEIDENTIFIER PRIMARY KEY,
	MunicipioID UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Empresa.Municipio(MunicipioID),
	[Name] VARCHAR(40) NOT NULL,
	[Description] VARCHAR(80) NOT NULL,
	Images1 VARBINARY(MAX) ,
	DateCreate DATETIME DEFAULT(GETDATE()) NOT NULL,
	IsActive BIT DEFAULT(1),
	DireccionWeb VARCHAR(40) NOT NULL,
	DescripcionTwo VARCHAR(100) NOT NULL,
	ImagenTwo VARBINARY(MAX) ,
	Direccion VARCHAR(80) NOT NULL
)
GO


CREATE TABLE Empresa.OfertaEmpresa
(
	OfertaEmpresaID UNIQUEIDENTIFIER PRIMARY KEY,
	EmpresaID UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Empresa.Empresa(EmpresaID),
	NombreOferta VARCHAR (40) NOT NULL,
	IsActive BIT DEFAULT (1)
)
GO

CREATE TABLE Empresa.ContactoEmpresa
(
	ContactoID UNIQUEIDENTIFIER PRIMARY KEY,
	EmpresaID UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Empresa.Empresa(EmpresaID),
	ContactoName VARCHAR (40) NOT NULL,
	IsActive BIT DEFAULT(1)
)
GO
