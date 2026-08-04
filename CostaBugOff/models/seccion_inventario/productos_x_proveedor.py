import oracledb
from db import get_connection

def insertar_producto_x_proveedor(id_producto, id_proveedor, id_estado=1):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_PRODUCTOS_X_PROVEEDOR_INSERT_SP", [
            id_producto, id_proveedor, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()

def eliminar_producto_x_proveedor_logico(id_producto, id_proveedor):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_PRODUCTOS_X_PROVEEDOR_DELETE_SP", [
            id_proveedor, id_producto
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()

def obtener_productos_x_proveedor(id_estado=None):
    conn = get_connection()
    cursor = conn.cursor()
    if id_estado:
        cursor.execute(
            'SELECT * FROM FIDE_PRODUCTOS_X_PROVEEDOR_V WHERE "ID ESTADO" = :id_estado ORDER BY "ID PROVEEDOR"',
            {"id_estado": id_estado}
        )
    else:
        cursor.execute('SELECT * FROM FIDE_PRODUCTOS_X_PROVEEDOR_V ORDER BY "ID PROVEEDOR"')
    datos = cursor.fetchall()
    cursor.close()
    conn.close()
    return datos