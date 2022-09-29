
USE YellowPages
GO

EXEC sp_configure filestream_access_level, 2
RECONFIGURE

SELECT * FROM Empresa.Empresa
GO

SELECT NEWID()
GO

INSERT INTO Empresa.Empresa
(
	EmpresaID,[Name],[Description],ImagenTwo,DescripcionTwo,DireccionWeb,Direccion,
	DateCreate
)
VALUES
(
	'61E97CE7-5021-43FA-8957-01E6EA1472F9','Eddy','EmpresaPrueba',
    CONVERT(varbinary,
	'C:\Users\Eddy\Downloads\679.jpg'),
	'SEGUNDA DESCRIPCION','WWWW.CMCNC.COM','SAN MARCOS',GETDATE()
	
)
GO