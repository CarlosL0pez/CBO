import oracledb
from db import get_connection


def insertar_producto_x_plaga(id_plaga, id_producto, id_estado=1):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.SP_FIDE_PRODUCTOS_X_PLAGA_INSERT", [
            id_plaga, id_producto, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def actualizar_producto_x_plaga(id_plaga, id_producto, id_estado):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.SP_FIDE_PRODUCTOS_X_PLAGA_UPDATE", [
            id_plaga, id_producto, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def eliminar_producto_x_plaga_logico(id_plaga, id_producto):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.SP_FIDE_PRODUCTOS_X_PLAGA_DELETE", [
            id_plaga, id_producto
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def obtener_productos_x_plaga(id_estado=None):
    conn = get_connection()
    cursor = conn.cursor()
    if id_estado:
        cursor.execute(
            'SELECT * FROM FIDE_PRODUCTOS_X_PLAGA_V WHERE "ID ESTADO" = :id_estado ORDER BY "ID PLAGA"',
            {"id_estado": id_estado}
        )
    else:
        cursor.execute('SELECT * FROM FIDE_PRODUCTOS_X_PLAGA_V ORDER BY "ID PLAGA"')
    datos = cursor.fetchall()
    cursor.close()
    conn.close()
    return datos
