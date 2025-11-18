select * from Compras
select * from Ventas
delete from compras

update Compras
set CostoU = 15933.98
where CodProducto = 'AC00018'

--Insercion a tabla Dim_Proveedor
select distinct 
	isnull(CodProveedor, 'N/A') as cod_proveedor, 
	isnull(NombreProveedor,'N/A') as nombre_proveedor, 
	isnull(DireccionProveedor, 'N/A') as direccion_proveedor, 
	isnull(NumeroProveedor, 'N/A') as numero_proveedor, 
	isnull(WebProveedor, 'N/A') as web_proveedor
from Compras order by cod_proveedor

--Insercion a tabla Dim_Cliente
select distinct 
	isnull(CodigoCliente,'N/A') as codigo_cliente,
	isnull(NombreCliente,'N/A') as nombre_cliente,
	isnull(TipoCliente,'N/A') as tipo_cliente,
	isnull(DireccionCliente,'N/A') as direccion_cliente,
	isnull(NumeroCliente,'N/A') as numero_cliente
from Ventas

   

--Insercion a tabla Dim_Sucursal
select distinct 
	isnull(SodSuSursal,'N/A') as sod_sucursal,
	isnull(NombreSucursal,'N/A') as nombre_sucursal,
	isnull(DireccionSucursal,'N/A') as direccion_sucursal,
	isnull(Region,'N/A') as region,
	isnull(Departamento,'N/A') as departamento
from Compras
union
select distinct 
	isnull(SodSuSursal,'N/A') as sod_sucursal,
	isnull(NombreSucursal,'N/A') as nombre_sucursal,
	isnull(DireccionSucursal,'N/A') as direccion_sucursal,
	isnull(Region,'N/A') as region,
	isnull(Departamento,'N/A') as departamento
from Ventas

--Insercion a tabla Dim_Vendedor
select distinct 
	isnull(CodVendedor,'N/A') as cod_vendedor,
	isnull(NombreVendedor,'N/A') as nombre_vendedor,
	isnull(Vacacionista, 0) as vacacionista
from Ventas

--Insercion a tabla Dim_Fecha
select 
	isnull(Fecha,'01/01/0001') as fecha,
	isnull(YEAR(Fecha),-1) as anio,
	isnull(MONTH(Fecha),-1) as mes,
	isnull(DAY(Fecha),-1) as dia,
	isnull(DATEPART(QUARTER,Fecha),-1) as trimestre
from Compras
union --all
select 
	isnull(Fecha,'01/01/0001') as fecha,
	isnull(YEAR(Fecha),-1) as anio,
	isnull(MONTH(Fecha),-1) as mes,
	isnull(DAY(Fecha),-1) as dia,
	isnull(DATEPART(QUARTER,Fecha),-1) as trimestre
from Ventas
--order by fecha asc


--Insercion a tabla Dim_Producto
select  
	isnull(CodProducto,'N/A') as cod_producto,
	isnull(NombreProducto,'N/A') as nombre_producto,
	isnull(MarcaProducto,'N/A') as marca_producto,
	isnull(Categoria,'N/A') as categoria
from Compras
union 
select 
	isnull(CodProducto,'N/A') as cod_producto,
	isnull(NombreProducto,'N/A') as nombre_producto,
	isnull(MarcaProducto,'N/A') as marca_producto,
	isnull(Categoria,'N/A') as categoria
from Ventas