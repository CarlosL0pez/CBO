import oracledb
from db import get_connection
#tener cuidado con esto que con quitar una linea se pudre toda la pagina xddddddd
def insertar_producto(id_producto, nombre, descripcion, precio, unidades, id_estado):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_PRODUCTOS_INSERT_SP", [
            id_producto, nombre, descripcion, precio, unidades, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()

def actualizar_producto(id_producto, nombre, descripcion, precio, unidades, id_estado):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_PRODUCTOS_UPDATE_SP", [
            id_producto, nombre, descripcion, precio, unidades, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()

def eliminar_producto_logico(id_producto):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_PRODUCTOS_DELETE_SP", [
            id_producto
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def obtener_productos():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM FIDE_PRODUCTOS_V ORDER BY "PRODUCTO ID"')
    datos = cursor.fetchall()
    cursor.close()
    conn.close()
    return datos

