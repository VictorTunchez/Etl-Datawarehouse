# Proyecto de Business Intelligence  

Este proyecto implementa un sistema de Business Intelligence (BI) utilizando SQL Server, Oracle, SSIS, SSAS, SSRS y Power BI.  
El objetivo principal es integrar datos de diferentes fuentes, transformarlos mediante reglas de negocio y construir un Data Warehouse, un cubo OLAP y reportes que permitan analizar información de compras y ventas.

---

# Índice del Proyecto

1. Configuración de red por medio de IPs  
2. Proceso ETL con Integration Services (SSIS)  
3. Diseño del Data Warehouse  
4. Construcción de cubos OLAP con SSAS  
5. Desarrollo de reportes con SSRS  
6. Dashboards en Power BI  

---

# 1. Configuración de Red

Se configuró una red local que permitió:

- Conectarse a SQL Server y Oracle  
- Transferir archivos .COMP y .VENT  
- Administrar los equipos de forma remota  
- Configurar puertos y controladores OLE DB  

Esto facilitó el trabajo colaborativo en cada etapa del proyecto.

---

# 2. Proceso ETL en SSIS

El proceso ETL se desarrolló en las siguientes fases:

### Extract
- Lectura de archivos .COMP y .VENT  
- Conexión a SQL Server  
- Conexión a Oracle  
- Importación de archivos TXT  

### Transform
- Limpieza de nulos  
- Conversión de tipos de datos  
- Creación de columnas derivadas  
- Validación de integridad y reglas de negocio  
- Filtros y normalización  

### Load
- Carga en tablas de Staging  
- Carga final al Data Warehouse  

Componentes utilizados: Lookup, Derived Column, Conditional Split, Merge Join, Sort, Data Conversion.

<img width="844" height="862" alt="image" src="https://github.com/user-attachments/assets/a6c23da9-5952-43ec-826e-7c0c74495956" />
<img width="611" height="566" alt="image" src="https://github.com/user-attachments/assets/729051bd-0dd4-46da-9f4a-23bf92e6a731" />
<img width="745" height="653" alt="image" src="https://github.com/user-attachments/assets/bca729f9-574a-47ba-b27c-139e172684b7" />

---

# 3. Diseño del Data Warehouse

Se trabajó con un modelo dimensional compuesto por:

### Tablas de Hechos:
- Hechos_Compras  
- Hechos_Ventas  

### Tablas de Dimensiones:
- Dim_Cliente  
- Dim_Producto  
- Dim_Proveedor  
- Dim_Sucursal  
- Dim_Tiempo  
- Dim_Vendedor  

Cada dimensión fue alimentada mediante procesos individuales desde SQL Server, Oracle y archivos TXT.
<img width="669" height="554" alt="image" src="https://github.com/user-attachments/assets/86d620af-2939-42a7-84fc-c5067e4ba57c" />

---

# 4. Cubo OLAP (SSAS)

Se construyó un cubo multidimensional que facilita:

- Análisis de ventas por producto, región y fecha  
- Análisis de compras por categoría y proveedor  
- Tendencias mensuales y anuales  
- Evaluación de KPIs empresariales  

Incluyó los pasos: creación de Data Source, Data Source View, dimensiones, cubo, procesamiento y deployment.
<img width="801" height="591" alt="image" src="https://github.com/user-attachments/assets/91b3ffdc-fb33-49d1-8d5d-cb4f4a7e8854" />

---

# 5. Reportes con SSRS

Se elaboraron reportes que permiten:

- Visualizar información de compras y ventas  
- Aplicar filtros por fechas, categorías y regiones  
- Exportar reportes a PDF, Excel y HTML  
- Realizar consultas parametrizadas  
<img width="433" height="230" alt="image" src="https://github.com/user-attachments/assets/dd7d67a3-32e9-46b3-83fe-013b916023ab" />

---

# 6. Dashboards en Power BI

Conexión directa al cubo OLAP mediante Live Connection.  
Se generaron dashboards con:

- Gráficos comparativos de compras y ventas  
- KPIs  
- Mapas geográficos  
- Análisis por jerarquías  
- Tendencias temporales  
<img width="940" height="531" alt="image" src="https://github.com/user-attachments/assets/397d8f49-5858-4f82-9cc1-a148279e9b0a" />
<img width="938" height="533" alt="image" src="https://github.com/user-attachments/assets/ce4326b1-6ff3-4c01-8f65-4d73edfb9200" />


---

# Participación del Grupo

| Integrante | Aporte |
|-----------|--------|
| José Maltez | SSIS Stage SQL, SSIS DW SQL, Cubo SSAS |
| Javier Rojas | Stage TXT, diseño del DW, SSIS DW TXT |
| Samuel Maeda | Power BI, SSRS, documentación, apoyo en SSIS |
| Víctor Tunchez | SSIS Stage Oracle, SSIS DW Oracle |

---

# Licencia

Proyecto académico — Universidad Mariano Gálvez de Guatemala.  
Uso permitido únicamente con fines educativos y de referencia.
