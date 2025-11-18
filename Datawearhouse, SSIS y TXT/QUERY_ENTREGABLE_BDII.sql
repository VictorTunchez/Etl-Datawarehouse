/*ORACLE*/
 EXEC sp_addlinkedserver 
   @server = 'Oracle3',            -- Nombre que se usará para referise a Oracle
   @srvproduct = 'Oracle',
   @provider = 'OraOLEDB.Oracle',
   @datasrc = '192.168.1.13/XEPDB1';           -- IP o nombre del host / nombre del servicio (puede ser SID o SERVICE_NAME)

-- Agrega las credenciales de Oracle
EXEC sp_addlinkedsrvlogin 
   @rmtsrvname = 'Oracle3',
   @useself = 'false',
   @rmtuser = 'VICTOR',
   @rmtpassword = 'A1234';

--consultas para dimensiones hechos.
--COMPRAS
WITH Oracle_Compras1 AS (
    SELECT FECHA,
           UNIDADES,
           COSTO_U,
           CODPROVEEDOR,
           CODPRODUCTO,
           SODSUCURSAL
    FROM OPENQUERY(Oracle3, 'SELECT * FROM VICTOR.COMPRAS_ORACLE')
)
SELECT  
    dt.id_tiempo AS id_tiempo,
    dp.id AS cod_proveedor,
    dpr.id AS cod_producto,
    ds.id AS sod_sucursal,
    oc.UNIDADES AS unidades,
    oc.COSTO_U AS costo_unitario
FROM Oracle_Compras1 oc
INNER JOIN Dimension_Tiempo dt ON oc.FECHA = dt.fecha
INNER JOIN Dimension_Proveedor dp ON dp.cod_proveedor = oc.CODPROVEEDOR
INNER JOIN Dimension_Producto dpr ON dpr.cod_producto = oc.CODPRODUCTO
INNER JOIN Dimension_Sucursal ds ON ds.sod_sucursal = oc.SODSUCURSAL


-- VENTAS 
with Oracle_Ventas1 as (
SELECT		
			FECHA,
            CODIGOCLIENTE,
            CODPRODUCTO,
            SODSUCURSAL,
            CODVENDEDOR,
            UNIDADES,
            PRECIOUNITARIO
FROM OPENQUERY(Oracle3, 'SELECT * FROM VICTOR.VENTAS_ORACLE'))

select  
		dt.id_tiempo as id_tiempo,
		dc.Id as cod_cliente,
		dp.Id as cod_producto,
		ds.Id as sod_sucursal,
		dv.Id as cod_vendedor,
		ov.UNIDADES as unidades,
		ov.PRECIOUNITARIO as precio_unitario
from Oracle_Ventas1 ov
inner join Dimension_Tiempo dt on ov.FECHA = dt.fecha
inner join Dimension_Cliente dc on dc.cod_cliente = ov.CodigoCliente
inner join Dimension_Producto dp on dp.cod_producto = ov.CodProducto
inner join Dimension_sucursal ds on ds.sod_sucursal = ov.SodSucursal
inner join Dimension_Vendedor dv on dv.cod_vendedor = ov.CodVendedor

--------------------------------------------------------------------------------------------------------------

/*SQL SERVER*/
-- Crear el linked server
EXEC sp_addlinkedserver 
    @server = 'ServidorJose6',               
    @srvproduct = '', 
    @provider = 'SQLOLEDB',                      
    @datasrc = '192.168.1.19'                 

-- Establecer las credenciales
EXEC sp_addlinkedsrvlogin 
    @rmtsrvname = 'ServidorJose6', 
    @useself = 'false', 
    @locallogin = NULL,                         
    @rmtuser = 'sa', 
    @rmtpassword = 'Mazate123.'

EXEC master.dbo.sp_enum_oledb_providers

-- COMPRAS 
select dt.id_tiempo,
	dp.Id as cod_proveedor,
	dpr.Id as cod_producto,
	ds.Id as sod_sucursal,
	c.Unidades as unidades,
	c.CostoU as costo_unitario
from [ServidorJose5].[ProyectoFinal].[dbo].[Compras] c 
inner join Dimension_Tiempo dt on c.Fecha = dt.fecha
inner join Dimension_Proveedor dp on dp.cod_proveedor = c.CodProveedor
inner join Dimension_Producto dpr on dpr.cod_producto = c.CodProducto
inner join Dimension_sucursal ds on ds.sod_sucursal = c.SodSuSursal

--VENTAS 
select dt.id_tiempo,
	dc.Id as cod_cliente,
	dp.Id as cod_producto,
	ds.Id as sod_sucursal,
	dv.Id as cod_vendedor,
	v.Unidades as unidades,
	v.PrecioUnitario as precio_unitario
from [ServidorJose5].[ProyectoFinal].[dbo].[Ventas] v 
inner join Dimension_Tiempo dt on v.Fecha = dt.fecha
inner join Dimension_Cliente dc on dc.cod_cliente = v.CodigoCliente
inner join Dimension_Producto dp on dp.cod_producto = v.CodProducto
inner join Dimension_sucursal ds on ds.sod_sucursal = v.SodSuSursal
inner join Dimension_Vendedor dv on dv.cod_vendedor = v.CodVendedor


-------------------------------------------------------------------------------------------------------------

/*utilizaciones*/
select * from Dimension_Cliente
select * from Dimension_Producto
select * from Dimension_Proveedor
select * from Dimension_sucursal
select * from Dimension_Tiempo
select * from Dimension_Vendedor
select * from AUX_Compras
select * from AUX_VENTAS
select * from Hechos_Compras
select * from Hechos_Ventas

delete from Hechos_Ventas
delete from Hechos_Compras
delete from Dimension_Cliente
delete from Dimension_Producto
delete from Dimension_Proveedor
delete from Dimension_sucursal
delete from Dimension_Tiempo
delete from Dimension_Vendedor
delete from AUX_Compras
delete from AUX_VENTAS



--------------------------------------------------------------------------------------------------------
select  
		dc.codigo_cliente as Id_Cliente,
		dp.cod_producto as Id_Producto,
		dpro.cod_proveedor as Id_Proveedor,
		ds.sod_sucursal as Id_Sucursal,
		dt.id_tiempo as Id_Tiempo,
		dv.cod_vendedor as Id_Vendedor
from Dimension_Cliente dc

inner join Dimension_Producto dp on dc.codigo_cliente = dp.id_producto
inner join Dimension_Proveedor dpro on dp.id_producto = dpro.id_proveedor
inner join Dimension_sucursal ds on dpro.id_proveedor = ds.id_sucursal
inner join Dimension_Tiempo dt on ds.id_sucursal = dt.id_tiempo
inner join Dimension_Vendedor dv on dt.id_tiempo = dv.id_vendedor


select 
		dc.id_cliente as Id_Cliente,
		dpd.id_producto as Id_Producto,
		ds.id_sucursal as Id_Sucursal,
		dt.id_tiempo as Id_Tiempo,
		dv.id_vendedor as Id_Vendedor

from Hechos_Ventas hv
right join Dimension_Cliente dc on hv.id_cliente = dc.id_cliente
right join Dimension_Producto dpd on hv.id_producto = dpd.id_producto
right join Dimension_sucursal ds on hv.id_sucursal = ds.id_sucursal
right join Dimension_Vendedor dv on hv.id_vendedor = dv.id_vendedor
right join Dimension_Tiempo dt on hv.id_tiempo = dt.id_tiempo


------------------------------------------------------------------------------------------------------------
--AQUI EMPIEZA LAS CONSULTAS DE TXT 
--COMPRAS
select 
		dt.id_tiempo,
		dpro.Id as Cod_proveedor,
		dp.Id as Cod_producto,
		ds.Id as Sod_sucursal,
		txt.Unidades,
		txt.CostoU
from AUX_Compras txt
inner join Dimension_Tiempo dt on txt.Fecha = dt.fecha
inner join Dimension_Proveedor dpro on txt.CodProveedor = dpro.cod_proveedor
inner join Dimension_Producto dp on txt.CodProducto = dp.cod_producto
inner join Dimension_sucursal ds on txt.SodSuSursal = ds.sod_sucursal

select txt.Fecha
from Dimension_Tiempo dt
inner join AUX_Compras txt on dt.fecha = txt.Fecha

select * from Dimension_sucursal




--VENTAS
select 
		dt.id_tiempo,
		dc.Id as Cod_cliente,
		dp.Id as Cod_producto,
		ds.Id as Cod_sucursal,
		dv.Id as Cod_vendedor,
		txt2.Unidades as Unidades,
		txt2.PrecioUnitario as Precio_unitario

from AUX_VENTAS txt2
inner join Dimension_Tiempo dt on txt2.Fecha = dt.fecha
inner join Dimension_Cliente dc on txt2.CodigoCliente = dc.cod_cliente
inner join Dimension_Producto dp on txt2.CodProducto = dp.cod_producto
inner join Dimension_sucursal ds on txt2.SodSuSursal = ds.sod_sucursal
inner join Dimension_Vendedor dv on txt2.CodVendedor = dv.cod_vendedor



SELECT 
    Id,
    ISNULL(sod_sucursal, 'Desconocido') AS sod_sucursal,
    ISNULL(nombre_sucursal, 'Sucursal sin nombre') AS nombre_sucursal,
    ISNULL(direccion_sucursal, 'Sin dirección') AS direccion_sucursal,
    ISNULL(region, 'Región desconocida') AS region,
    ISNULL(departamento, 'Departamento desconocido') AS departamento
FROM dbo.Dimension_sucursal

SELECT 
    Id,
    ISNULL(cod_cliente, 'Desconocido') AS cod_cliente,
    ISNULL(nombre_cliente, 'Desconocido') AS nombre_cliente,
    ISNULL(tipo_cliente, 'Desconocido') AS tipo_cliente,
    ISNULL(direccion_cliente, 'Sin dirección') AS direccion_cliente,
    ISNULL(numero_cliente, 'Sin número') AS numero_cliente
FROM dbo.Dimension_Cliente

-------------------------------------------------------------------------------------------------------------------------



--Creacion de Tabla DWH
-- DIMENSIONES

-- Tiempo
CREATE TABLE Dimension_Tiempo ( 
	id_tiempo INT PRIMARY KEY,
    fecha DATE
)

-- Producto
CREATE TABLE Dimension_Producto (
    id_producto INT PRIMARY KEY,
    cod_producto VARCHAR(50),
    nombre_producto VARCHAR(100),
    marca_producto VARCHAR(50),
    categoria VARCHAR(50)
)

-- Cliente
CREATE TABLE Dimension_Cliente (
    id_cliente INT PRIMARY KEY,
    codigo_cliente VARCHAR(50),
    nombre_cliente VARCHAR(100),
    tipo_cliente VARCHAR(50),
    direccion_cliente VARCHAR(150),
    numero_cliente VARCHAR(20)
)

-- Proveedor
CREATE TABLE Dimension_Proveedor (
    id_proveedor INT PRIMARY KEY,
    cod_proveedor VARCHAR(50),
    nombre_proveedor VARCHAR(100),
    direccion_proveedor VARCHAR(150),
    numero_proveedor VARCHAR(20),
    web_proveedor VARCHAR(100)
)

-- Vendedor
CREATE TABLE Dimension_Vendedor (
    id_vendedor INT PRIMARY KEY,
    cod_vendedor VARCHAR(50),
    nombre_vendedor VARCHAR(100),
    vacacionista BIT
)

-- Sucursal
CREATE TABLE Dimension_sucursal (
    id_sucursal INT PRIMARY KEY,
    sod_sucursal VARCHAR(50),
    nombre_sucursal VARCHAR(100),
    direccion_sucursal VARCHAR(150),
    region VARCHAR(50),
    departamento VARCHAR(50)
)


-- TABLA DE HECHOS

-- Compras
CREATE TABLE Hechos_Compras (
    id_compra INT PRIMARY KEY,
    id_tiempo INT,
    id_proveedor INT,
    id_producto INT,
    id_sucursal INT,
    unidades INT,
    costo_unitario DECIMAL(10,2),
    FOREIGN KEY (id_tiempo) REFERENCES Dimension_Tiempo(id_tiempo),
    FOREIGN KEY (id_proveedor) REFERENCES Dimension_Proveedor(id_proveedor),
    FOREIGN KEY (id_producto) REFERENCES Dimension_Producto(id_producto),
    FOREIGN KEY (id_sucursal) REFERENCES Dimension_Sucursal(id_sucursal)
)

-- Ventas
CREATE TABLE Hechos_Ventas (
    id_venta INT PRIMARY KEY,
    id_tiempo INT,
    id_cliente INT,
    id_producto INT,
    id_sucursal INT,
    id_vendedor INT,
    unidades INT,
    precio_unitario DECIMAL(10,2),
    FOREIGN KEY (id_tiempo) REFERENCES Dimension_Tiempo(id_tiempo),
    FOREIGN KEY (id_cliente) REFERENCES Dimension_Cliente(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES Dimension_Producto(id_producto),
    FOREIGN KEY (id_sucursal) REFERENCES Dimension_Sucursal(id_sucursal),
    FOREIGN KEY (id_vendedor) REFERENCES Dimension_Vendedor(id_vendedor)
)


