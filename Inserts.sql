/*=========================================================
CostaBugOff - INSERTS DE PRUEBA (AVANCE 2)
=========================================================
Objetivo: cargar datos minimos pero coherentes para poder
probar las 15 funciones/cursores de Vista Cliente y
Vista Administrador.

NOTAS DE DISENO (leer antes de ejecutar):

1) Solo se llenan las tablas que las funciones y vistas
   realmente necesitan. NO se insertan datos en: TELEFONOS,
   CORREOS, PROVINCIAS, CANTONES, DISTRITOS, DIRECCIONES,
   TELEFONOS_EMPLEADOS, CORREOS_EMPLEADOS, TELEFONOS_PROVEEDORES,
   CORREOS_PROVEEDORES, PERMISOS, PERMISOS_X_ROL,
   PRODUCTOS_X_PLAGA. Si las necesitas para otra parte del
   proyecto, se pueden agregar aparte.

2) FIDE_SUSCRIPCIONES_TB no tiene ID_CLIENTE, y FIDE_PAGOS_TB,
   FIDE_TRANSACCIONES_TB y FIDE_FACTURAS_TB tampoco. El unico
   punto de union hacia el cliente es FIDE_VISITAS_TB (tiene
   ID_CLIENTE e ID_SUSCRIPCION). Por eso varias funciones
   navegan: CLIENTE -> VISITAS -> SUSCRIPCION -> PAGO ->
   TRANSACCION -> FACTURA. Los datos de abajo estan pensados
   para que esa cadena funcione.

3) Las fechas se generan con SYSDATE +/- N para que la
   demostracion (visitas vencidas, proximas, facturacion del
   mes, etc.) siga siendo valida sin importar el dia en que
   se ejecute este script.

4) Catalogo de ESTADOS usado por TODAS las tablas (es la
   tabla padre general):
   1  ACTIVO
   2  INACTIVO      (coincide con el borrado logico de tu CRUD: SET ID_ESTADO = 2)
   3  PENDIENTE
   4  VENCIDO
   5  CANCELADO
   6  PROGRAMADA    (visita agendada, aun no realizada)
   7  REALIZADA     (visita o servicio ya efectuado)
   8  EXITOSO       (pago/transaccion exitosa)
   9  FALLIDO
   10 REEMBOLSADO
   11 PAGADA        (usado en facturas)
   12 ANULADA       (usado en facturas)
=========================================================*/


/*=========================================================
1. TABLA DE ESTADOS (catalogo general)
=========================================================*/
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (1,  'ACTIVO',      'Estado general activo para cualquier entidad');
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (2,  'INACTIVO',    'Estado general inactivo o baja logica');
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (3,  'PENDIENTE',   'Pendiente de pago o de proceso');
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (4,  'VENCIDO',     'Vencido o caducado');
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (5,  'CANCELADO',   'Cancelado por el cliente o el sistema');
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (6,  'PROGRAMADA',  'Visita programada, aun no realizada');
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (7,  'REALIZADA',   'Visita o servicio ya efectuado');
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (8,  'EXITOSO',     'Pago o transaccion exitosa');
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (9,  'FALLIDO',     'Pago o transaccion fallida');
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (10, 'REEMBOLSADO', 'Transaccion reembolsada al cliente');
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (11, 'PAGADA',      'Factura pagada');
INSERT INTO FIDE_ESTADOS_TB (ID_ESTADO, NOMBRE, DESCRIPCION) VALUES (12, 'ANULADA',     'Factura anulada (por ejemplo, tras un reembolso)');


/*=========================================================
2. TABLA DE CLIENTES
   (4 = inactivo, sirve para probar "clientes activos")
=========================================================*/
INSERT INTO FIDE_CLIENTES_TB (ID_CLIENTE, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ID_ESTADO) VALUES (1, 'Maria', 'Rodriguez', 'Jimenez',  1);
INSERT INTO FIDE_CLIENTES_TB (ID_CLIENTE, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ID_ESTADO) VALUES (2, 'Carlos', 'Vargas',   'Mora',     1);
INSERT INTO FIDE_CLIENTES_TB (ID_CLIENTE, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ID_ESTADO) VALUES (3, 'Ana',   'Solis',     'Campos',   1);
INSERT INTO FIDE_CLIENTES_TB (ID_CLIENTE, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ID_ESTADO) VALUES (4, 'Luis',  'Fernandez', 'Chaves',   2);


/*=========================================================
3. TABLA DE PUESTOS
=========================================================*/
INSERT INTO FIDE_PUESTOS_TB (ID_PUESTO, NOMBRE, DESCRIPCION, ID_ESTADO) VALUES (1, 'Tecnico de Fumigacion',   'Aplica los tratamientos en campo', 1);
INSERT INTO FIDE_PUESTOS_TB (ID_PUESTO, NOMBRE, DESCRIPCION, ID_ESTADO) VALUES (2, 'Supervisor de Servicios', 'Supervisa la calidad de los servicios', 1);


/*=========================================================
4. TABLA DE EMPLEADOS
=========================================================*/
INSERT INTO FIDE_EMPLEADOS_TB (ID_EMPLEADO, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ID_PUESTO, ID_ESTADO) VALUES (1, 'Jorge', 'Salas',     'Rojas', 1, 1);
INSERT INTO FIDE_EMPLEADOS_TB (ID_EMPLEADO, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ID_PUESTO, ID_ESTADO) VALUES (2, 'Diego', 'Alvarado',  'Nunez', 1, 1);
INSERT INTO FIDE_EMPLEADOS_TB (ID_EMPLEADO, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, ID_PUESTO, ID_ESTADO) VALUES (3, 'Karla', 'Mendez',    'Urena', 2, 1);


/*=========================================================
5. TABLA DE ROLES
=========================================================*/
INSERT INTO FIDE_ROLES_TB (ID_ROL, NOMBRE, DESCRIPCION, ID_ESTADO) VALUES (1, 'Administrador', 'Acceso total al sistema', 1);
INSERT INTO FIDE_ROLES_TB (ID_ROL, NOMBRE, DESCRIPCION, ID_ESTADO) VALUES (2, 'Empleado',      'Acceso operativo a clientes y servicios', 1);
INSERT INTO FIDE_ROLES_TB (ID_ROL, NOMBRE, DESCRIPCION, ID_ESTADO) VALUES (3, 'Cliente',       'Acceso limitado: agendar y ver sus propias visitas', 1);


/*=========================================================
6. TABLA DE USUARIOS (uno por empleado)
=========================================================*/
INSERT INTO FIDE_USUARIOS_TB (ID_USUARIO, USUARIO, CONTRASENA, ID_EMPLEADO, ID_ROL, ID_ESTADO) VALUES (1, 'jsalas',    'Tecnico#26', 1, 2, 1);
INSERT INTO FIDE_USUARIOS_TB (ID_USUARIO, USUARIO, CONTRASENA, ID_EMPLEADO, ID_ROL, ID_ESTADO) VALUES (2, 'dalvarado', 'Tecnico#27', 2, 2, 1);
INSERT INTO FIDE_USUARIOS_TB (ID_USUARIO, USUARIO, CONTRASENA, ID_EMPLEADO, ID_ROL, ID_ESTADO) VALUES (3, 'kmendez',   'Super#28',   3, 1, 1);


/*=========================================================
7. TABLA DE PLAGAS
=========================================================*/
INSERT INTO FIDE_PLAGAS_TB (ID_PLAGA, TIPO, NOMBRE, DESCRIPCION, UNIDADES_NECESARIAS, ID_ESTADO) VALUES (1, 'Insectos', 'Cucarachas',       'Plaga comun en cocinas y areas humedas', 2, 1);
INSERT INTO FIDE_PLAGAS_TB (ID_PLAGA, TIPO, NOMBRE, DESCRIPCION, UNIDADES_NECESARIAS, ID_ESTADO) VALUES (2, 'Roedores', 'Ratones y Ratas',  'Roedores urbanos frecuentes en bodegas', 3, 1);
INSERT INTO FIDE_PLAGAS_TB (ID_PLAGA, TIPO, NOMBRE, DESCRIPCION, UNIDADES_NECESARIAS, ID_ESTADO) VALUES (3, 'Insectos', 'Termitas',         'Plaga que afecta estructuras de madera', 4, 1);


/*=========================================================
8. TABLA DE PRODUCTOS
   (producto 4 = menor stock activo, producto 5 = inactivo
   con 0 stock, para probar que el filtro de estado funciona)
=========================================================*/
INSERT INTO FIDE_PRODUCTOS_TB (ID_PRODUCTO, NOMBRE, DESCRIPCION, PRECIO, UNIDADES_ACTUALES, ID_ESTADO) VALUES (1, 'Insecticida Liquido X200',       'Insecticida de amplio espectro',      8500,  50, 1);
INSERT INTO FIDE_PRODUCTOS_TB (ID_PRODUCTO, NOMBRE, DESCRIPCION, PRECIO, UNIDADES_ACTUALES, ID_ESTADO) VALUES (2, 'Cebo para Roedores',             'Cebo toxico en bloques',              4200,  30, 1);
INSERT INTO FIDE_PRODUCTOS_TB (ID_PRODUCTO, NOMBRE, DESCRIPCION, PRECIO, UNIDADES_ACTUALES, ID_ESTADO) VALUES (3, 'Repelente en Gel',               'Gel repelente para termitas',         6000,  15, 1);
INSERT INTO FIDE_PRODUCTOS_TB (ID_PRODUCTO, NOMBRE, DESCRIPCION, PRECIO, UNIDADES_ACTUALES, ID_ESTADO) VALUES (4, 'Trampa Adhesiva',                'Trampa para insectos rastreros',      1500,   3, 1);
INSERT INTO FIDE_PRODUCTOS_TB (ID_PRODUCTO, NOMBRE, DESCRIPCION, PRECIO, UNIDADES_ACTUALES, ID_ESTADO) VALUES (5, 'Equipo de Proteccion Personal',  'Traje y guantes de bioseguridad',     12000,  0, 2);


/*=========================================================
9. TABLA DE SERVICIOS REALIZADOS
   (FECHA relativa a SYSDATE, para poder ordenar por
   antiguedad en las funciones de cliente)
=========================================================*/
INSERT INTO FIDE_SERVICIOS_REALIZADOS_TB (ID_SERVICIO_REALIZADO, FECHA, UBICACION, INFORME, ID_ESTADO) VALUES (1, SYSDATE-3, 'Curridabat, San Jose', 'Fumigacion general realizada sin incidentes.', 7);
INSERT INTO FIDE_SERVICIOS_REALIZADOS_TB (ID_SERVICIO_REALIZADO, FECHA, UBICACION, INFORME, ID_ESTADO) VALUES (2, SYSDATE-6, 'Escazu, San Jose', 'Aplicacion de insecticida en cocina y bodega.', 7);
INSERT INTO FIDE_SERVICIOS_REALIZADOS_TB (ID_SERVICIO_REALIZADO, FECHA, UBICACION, INFORME, ID_ESTADO) VALUES (3, SYSDATE-9, 'Alajuela Centro', 'Control de roedores en el perimetro de la propiedad.', 7);
INSERT INTO FIDE_SERVICIOS_REALIZADOS_TB (ID_SERVICIO_REALIZADO, FECHA, UBICACION, INFORME, ID_ESTADO) VALUES (4, SYSDATE-12, 'Heredia Centro', 'Inspeccion preventiva sin hallazgos relevantes.', 7);
INSERT INTO FIDE_SERVICIOS_REALIZADOS_TB (ID_SERVICIO_REALIZADO, FECHA, UBICACION, INFORME, ID_ESTADO) VALUES (5, SYSDATE-15, 'San Pedro, Montes de Oca', 'Tratamiento contra termitas en estructura de madera.', 7);
INSERT INTO FIDE_SERVICIOS_REALIZADOS_TB (ID_SERVICIO_REALIZADO, FECHA, UBICACION, INFORME, ID_ESTADO) VALUES (6, SYSDATE-18, 'Curridabat, San Jose', 'Fumigacion de seguimiento mensual.', 7);
INSERT INTO FIDE_SERVICIOS_REALIZADOS_TB (ID_SERVICIO_REALIZADO, FECHA, UBICACION, INFORME, ID_ESTADO) VALUES (7, SYSDATE-22, 'Tibas, San Jose', 'Control de plagas en bodega comercial.', 7);
INSERT INTO FIDE_SERVICIOS_REALIZADOS_TB (ID_SERVICIO_REALIZADO, FECHA, UBICACION, INFORME, ID_ESTADO) VALUES (8, SYSDATE-27, 'Escazu, San Jose', 'Fumigacion general con doble aplicacion.', 7);
INSERT INTO FIDE_SERVICIOS_REALIZADOS_TB (ID_SERVICIO_REALIZADO, FECHA, UBICACION, INFORME, ID_ESTADO) VALUES (9, SYSDATE-33, 'Alajuela Centro', 'Colocacion de cebos para roedores.', 7);
INSERT INTO FIDE_SERVICIOS_REALIZADOS_TB (ID_SERVICIO_REALIZADO, FECHA, UBICACION, INFORME, ID_ESTADO) VALUES (10, SYSDATE-40, 'Heredia Centro', 'Revision de trampas y reposicion de producto.', 7);


/*=========================================================
10. TABLA DE SERVICIOS
    (NOMBRE se repite a proposito para poder calcular el
    "servicio mas solicitado"; ID_USUARIO define quien lo
    hizo, para "empleado con mas trabajos")
=========================================================*/
INSERT INTO FIDE_SERVICIOS_TB (ID_SERVICIO, NOMBRE, ID_PLAGA, ID_USUARIO, ID_SERVICIO_REALIZADO, ID_ESTADO) VALUES (1,  'Fumigacion General',      1, 1, 1,  1);
INSERT INTO FIDE_SERVICIOS_TB (ID_SERVICIO, NOMBRE, ID_PLAGA, ID_USUARIO, ID_SERVICIO_REALIZADO, ID_ESTADO) VALUES (2,  'Control de Roedores',     2, 2, 2,  1);
INSERT INTO FIDE_SERVICIOS_TB (ID_SERVICIO, NOMBRE, ID_PLAGA, ID_USUARIO, ID_SERVICIO_REALIZADO, ID_ESTADO) VALUES (3,  'Fumigacion General',      1, 1, 3,  1);
INSERT INTO FIDE_SERVICIOS_TB (ID_SERVICIO, NOMBRE, ID_PLAGA, ID_USUARIO, ID_SERVICIO_REALIZADO, ID_ESTADO) VALUES (4,  'Inspeccion Preventiva',   3, 3, 4,  1);
INSERT INTO FIDE_SERVICIOS_TB (ID_SERVICIO, NOMBRE, ID_PLAGA, ID_USUARIO, ID_SERVICIO_REALIZADO, ID_ESTADO) VALUES (5,  'Tratamiento de Termitas', 3, 1, 5,  1);
INSERT INTO FIDE_SERVICIOS_TB (ID_SERVICIO, NOMBRE, ID_PLAGA, ID_USUARIO, ID_SERVICIO_REALIZADO, ID_ESTADO) VALUES (6,  'Fumigacion General',      1, 2, 6,  1);
INSERT INTO FIDE_SERVICIOS_TB (ID_SERVICIO, NOMBRE, ID_PLAGA, ID_USUARIO, ID_SERVICIO_REALIZADO, ID_ESTADO) VALUES (7,  'Control de Roedores',     2, 3, 7,  1);
INSERT INTO FIDE_SERVICIOS_TB (ID_SERVICIO, NOMBRE, ID_PLAGA, ID_USUARIO, ID_SERVICIO_REALIZADO, ID_ESTADO) VALUES (8,  'Fumigacion General',      1, 1, 8,  1);
INSERT INTO FIDE_SERVICIOS_TB (ID_SERVICIO, NOMBRE, ID_PLAGA, ID_USUARIO, ID_SERVICIO_REALIZADO, ID_ESTADO) VALUES (9,  'Control de Roedores',     2, 2, 9,  1);
INSERT INTO FIDE_SERVICIOS_TB (ID_SERVICIO, NOMBRE, ID_PLAGA, ID_USUARIO, ID_SERVICIO_REALIZADO, ID_ESTADO) VALUES (10, 'Tratamiento de Termitas', 3, 3, 10, 1);


/*=========================================================
11. TABLA DE CLIENTES POR SERVICIO
    Maria(1)=4 servicios, Carlos(2)=2, Ana(3)=3, Luis(4)=1
=========================================================*/
INSERT INTO FIDE_CLIENTES_X_SERVICIO_TB (ID_CLIENTE, ID_SERVICIO, ID_ESTADO) VALUES (1, 1,  1);
INSERT INTO FIDE_CLIENTES_X_SERVICIO_TB (ID_CLIENTE, ID_SERVICIO, ID_ESTADO) VALUES (2, 2,  1);
INSERT INTO FIDE_CLIENTES_X_SERVICIO_TB (ID_CLIENTE, ID_SERVICIO, ID_ESTADO) VALUES (1, 3,  1);
INSERT INTO FIDE_CLIENTES_X_SERVICIO_TB (ID_CLIENTE, ID_SERVICIO, ID_ESTADO) VALUES (3, 4,  1);
INSERT INTO FIDE_CLIENTES_X_SERVICIO_TB (ID_CLIENTE, ID_SERVICIO, ID_ESTADO) VALUES (1, 5,  1);
INSERT INTO FIDE_CLIENTES_X_SERVICIO_TB (ID_CLIENTE, ID_SERVICIO, ID_ESTADO) VALUES (2, 6,  1);
INSERT INTO FIDE_CLIENTES_X_SERVICIO_TB (ID_CLIENTE, ID_SERVICIO, ID_ESTADO) VALUES (3, 7,  1);
INSERT INTO FIDE_CLIENTES_X_SERVICIO_TB (ID_CLIENTE, ID_SERVICIO, ID_ESTADO) VALUES (1, 8,  1);
INSERT INTO FIDE_CLIENTES_X_SERVICIO_TB (ID_CLIENTE, ID_SERVICIO, ID_ESTADO) VALUES (3, 9,  1);
INSERT INTO FIDE_CLIENTES_X_SERVICIO_TB (ID_CLIENTE, ID_SERVICIO, ID_ESTADO) VALUES (4, 10, 1);


/*=========================================================
12. TABLA DE METODOS DE PAGO
=========================================================*/
INSERT INTO FIDE_METODOSDEPAGO_TB (ID_METODO_PAGO, NOMBRE, ID_ESTADO) VALUES (1, 'Tarjeta de Credito', 1);
INSERT INTO FIDE_METODOSDEPAGO_TB (ID_METODO_PAGO, NOMBRE, ID_ESTADO) VALUES (2, 'Tarjeta de Debito',  1);
INSERT INTO FIDE_METODOSDEPAGO_TB (ID_METODO_PAGO, NOMBRE, ID_ESTADO) VALUES (3, 'PayPal',             1);


/*=========================================================
13. TABLA DE DETALLE DE TRANSACCIONES
=========================================================*/
INSERT INTO FIDE_DETALLE_TRANSACCIONES_TB (ID_DETALLE_TRANSACCION, DETALLE, ID_ESTADO) VALUES (1, 'Pago de suscripcion mensual',     1);
INSERT INTO FIDE_DETALLE_TRANSACCIONES_TB (ID_DETALLE_TRANSACCION, DETALLE, ID_ESTADO) VALUES (2, 'Renovacion de plan trimestral',   1);
INSERT INTO FIDE_DETALLE_TRANSACCIONES_TB (ID_DETALLE_TRANSACCION, DETALLE, ID_ESTADO) VALUES (3, 'Cargo por plan anual',           1);


/*=========================================================
14. TABLA DE PAGOS (uno por suscripcion)
=========================================================*/
INSERT INTO FIDE_PAGOS_TB (ID_PAGO, ID_METODO_PAGO, ID_ESTADO) VALUES (1, 1, 8);  -- suscripcion 1 (Maria, actual)
INSERT INTO FIDE_PAGOS_TB (ID_PAGO, ID_METODO_PAGO, ID_ESTADO) VALUES (2, 2, 8);  -- suscripcion 2 (Carlos, vencida)
INSERT INTO FIDE_PAGOS_TB (ID_PAGO, ID_METODO_PAGO, ID_ESTADO) VALUES (3, 3, 3);  -- suscripcion 3 (Ana, pendiente)
INSERT INTO FIDE_PAGOS_TB (ID_PAGO, ID_METODO_PAGO, ID_ESTADO) VALUES (4, 1, 10); -- suscripcion 4 (Luis, cancelada/reembolsada)
INSERT INTO FIDE_PAGOS_TB (ID_PAGO, ID_METODO_PAGO, ID_ESTADO) VALUES (5, 1, 8);  -- suscripcion 5 (Maria, anterior)


/*=========================================================
15. TABLA DE SUSCRIPCIONES
    Maria tiene 2 (una vencida antigua y una activa actual),
    para probar que la funcion de estado toma la MAS RECIENTE.
=========================================================*/
INSERT INTO FIDE_SUSCRIPCIONES_TB (ID_SUSCRIPCION, NOMBRE, FECHA_INICIO, FECHA_FIN, ID_PAGO, ID_ESTADO) VALUES (1, 'Plan Mensual Hogar',        SYSDATE-60,  SYSDATE+30, 1, 1);
INSERT INTO FIDE_SUSCRIPCIONES_TB (ID_SUSCRIPCION, NOMBRE, FECHA_INICIO, FECHA_FIN, ID_PAGO, ID_ESTADO) VALUES (2, 'Plan Trimestral Comercial', SYSDATE-200, SYSDATE-20, 2, 4);
INSERT INTO FIDE_SUSCRIPCIONES_TB (ID_SUSCRIPCION, NOMBRE, FECHA_INICIO, FECHA_FIN, ID_PAGO, ID_ESTADO) VALUES (3, 'Plan Mensual Hogar',        SYSDATE-10,  SYSDATE+20, 3, 3);
INSERT INTO FIDE_SUSCRIPCIONES_TB (ID_SUSCRIPCION, NOMBRE, FECHA_INICIO, FECHA_FIN, ID_PAGO, ID_ESTADO) VALUES (4, 'Plan Anual Premium',        SYSDATE-400, SYSDATE-35, 4, 5);
INSERT INTO FIDE_SUSCRIPCIONES_TB (ID_SUSCRIPCION, NOMBRE, FECHA_INICIO, FECHA_FIN, ID_PAGO, ID_ESTADO) VALUES (5, 'Plan Mensual Hogar',        SYSDATE-90,  SYSDATE-60, 5, 4);


/*=========================================================
16. TABLA DE VISITAS
    (unico enlace real entre CLIENTE y SUSCRIPCION)
=========================================================*/
INSERT INTO FIDE_VISITAS_TB (ID_VISITA, NOMBRE, FECHA_PROGRAMADA, FECHA_REALIZADA, ID_SUSCRIPCION, ID_CLIENTE, ID_ESTADO) VALUES (1, 'Visita de fumigacion', SYSDATE-85, SYSDATE-85, 5, 1, 7);
INSERT INTO FIDE_VISITAS_TB (ID_VISITA, NOMBRE, FECHA_PROGRAMADA, FECHA_REALIZADA, ID_SUSCRIPCION, ID_CLIENTE, ID_ESTADO) VALUES (3, 'Visita de fumigacion', SYSDATE+20, NULL,       1, 1, 6);
INSERT INTO FIDE_VISITAS_TB (ID_VISITA, NOMBRE, FECHA_PROGRAMADA, FECHA_REALIZADA, ID_SUSCRIPCION, ID_CLIENTE, ID_ESTADO) VALUES (4, 'Visita de fumigacion', SYSDATE-25, SYSDATE-25, 2, 2, 7);
INSERT INTO FIDE_VISITAS_TB (ID_VISITA, NOMBRE, FECHA_PROGRAMADA, FECHA_REALIZADA, ID_SUSCRIPCION, ID_CLIENTE, ID_ESTADO) VALUES (5, 'Visita de fumigacion', SYSDATE+5,  NULL,       3, 3, 6);
INSERT INTO FIDE_VISITAS_TB (ID_VISITA, NOMBRE, FECHA_PROGRAMADA, FECHA_REALIZADA, ID_SUSCRIPCION, ID_CLIENTE, ID_ESTADO) VALUES (6, 'Visita de fumigacion', SYSDATE-50, SYSDATE-50, 4, 4, 7);


/*=========================================================
17. TABLA DE TRANSACCIONES
    Maria acumula 3 transacciones (pagos 1 y 5) para probar
    que la suma del "total pagado" funciona con varios cargos.
    Ana (pago 3) no tiene ninguna transaccion todavia -> su
    total pagado y su cantidad de facturas deben dar 0.
=========================================================*/
INSERT INTO FIDE_TRANSACCIONES_TB (ID_TRANSACCION, ID_PAGO, MONTO, FECHA, ID_DETALLE_TRANSACCION, ID_ESTADO) VALUES (1, 1, 25000, SYSDATE,     1, 8);
INSERT INTO FIDE_TRANSACCIONES_TB (ID_TRANSACCION, ID_PAGO, MONTO, FECHA, ID_DETALLE_TRANSACCION, ID_ESTADO) VALUES (2, 1, 25000, SYSDATE-33,  1, 8);
INSERT INTO FIDE_TRANSACCIONES_TB (ID_TRANSACCION, ID_PAGO, MONTO, FECHA, ID_DETALLE_TRANSACCION, ID_ESTADO) VALUES (3, 5, 20000, SYSDATE-88,  1, 8);
INSERT INTO FIDE_TRANSACCIONES_TB (ID_TRANSACCION, ID_PAGO, MONTO, FECHA, ID_DETALLE_TRANSACCION, ID_ESTADO) VALUES (4, 2, 45000, SYSDATE-195, 2, 8);
INSERT INTO FIDE_TRANSACCIONES_TB (ID_TRANSACCION, ID_PAGO, MONTO, FECHA, ID_DETALLE_TRANSACCION, ID_ESTADO) VALUES (5, 4, 60000, SYSDATE-390, 3, 10);


/*=========================================================
18. TABLA DE FACTURAS (una por transaccion)
    (11=PAGADA, 12=ANULADA; la factura 5 esta anulada porque
    su transaccion fue reembolsada)
=========================================================*/
INSERT INTO FIDE_FACTURAS_TB (ID_FACTURA, NUMERO, FECHA, TOTAL, ID_TRANSACCION, ID_ESTADO) VALUES (1, 1001, SYSDATE,     25000, 1, 11);
INSERT INTO FIDE_FACTURAS_TB (ID_FACTURA, NUMERO, FECHA, TOTAL, ID_TRANSACCION, ID_ESTADO) VALUES (2, 1002, SYSDATE-33,  25000, 2, 11);
INSERT INTO FIDE_FACTURAS_TB (ID_FACTURA, NUMERO, FECHA, TOTAL, ID_TRANSACCION, ID_ESTADO) VALUES (3, 1003, SYSDATE-88,  20000, 3, 11);
INSERT INTO FIDE_FACTURAS_TB (ID_FACTURA, NUMERO, FECHA, TOTAL, ID_TRANSACCION, ID_ESTADO) VALUES (4, 1004, SYSDATE-195, 45000, 4, 11);
INSERT INTO FIDE_FACTURAS_TB (ID_FACTURA, NUMERO, FECHA, TOTAL, ID_TRANSACCION, ID_ESTADO) VALUES (5, 1005, SYSDATE-390, 60000, 5, 12);


/*=========================================================
19. TABLA DE REABASTECIMIENTO DE INVENTARIO
    (necesaria para poder registrar proveedores)
=========================================================*/
INSERT INTO FIDE_REABASTECIMIENTO_INVENTARIO_TB (ID_REABASTECIMIENTO, CANTIDAD, ID_ESTADO) VALUES (1, 100, 1);
INSERT INTO FIDE_REABASTECIMIENTO_INVENTARIO_TB (ID_REABASTECIMIENTO, CANTIDAD, ID_ESTADO) VALUES (2, 50,  1);


/*=========================================================
20. TABLA DE PROVEEDORES
    (proveedor 3 = inactivo, para probar el filtro de "activos")
=========================================================*/
INSERT INTO FIDE_PROVEEDORES_TB (ID_PROVEEDOR, NOMBRE, ID_REABASTECIMIENTO, ID_ESTADO) VALUES (1, 'Distribuidora Quimica CR',     1, 1);
INSERT INTO FIDE_PROVEEDORES_TB (ID_PROVEEDOR, NOMBRE, ID_REABASTECIMIENTO, ID_ESTADO) VALUES (2, 'Insumos Agricolas SA',         2, 1);
INSERT INTO FIDE_PROVEEDORES_TB (ID_PROVEEDOR, NOMBRE, ID_REABASTECIMIENTO, ID_ESTADO) VALUES (3, 'Proveedora Industrial Vargas', 1, 2);


/*=========================================================
21. TABLA DE PRODUCTOS POR PROVEEDOR
    (proveedor 1 = 3 productos, para probar "proveedor con mas productos")
=========================================================*/
INSERT INTO FIDE_PRODUCTOS_X_PROVEEDOR_TB (ID_PRODUCTO, ID_PROVEEDOR, ID_ESTADO) VALUES (1, 1, 1);
INSERT INTO FIDE_PRODUCTOS_X_PROVEEDOR_TB (ID_PRODUCTO, ID_PROVEEDOR, ID_ESTADO) VALUES (2, 1, 1);
INSERT INTO FIDE_PRODUCTOS_X_PROVEEDOR_TB (ID_PRODUCTO, ID_PROVEEDOR, ID_ESTADO) VALUES (3, 1, 1);
INSERT INTO FIDE_PRODUCTOS_X_PROVEEDOR_TB (ID_PRODUCTO, ID_PROVEEDOR, ID_ESTADO) VALUES (4, 2, 1);
INSERT INTO FIDE_PRODUCTOS_X_PROVEEDOR_TB (ID_PRODUCTO, ID_PROVEEDOR, ID_ESTADO) VALUES (5, 3, 1);


COMMIT;
