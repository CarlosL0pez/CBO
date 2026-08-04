import oracledb
from db import get_connection
#tener cuidado con esto que con quitar una linea se pudre toda la pagina xddddddd
def insertar_detalle_transaccion(id_detalle_transaccion, detalle, id_estado, id_transaccion, id_producto, id_suscripcion, cantidad, precio_unitario, subtotal):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_DETALLE_TRANSACCIONES_INSERT_SP", [
            id_detalle_transaccion, detalle, id_estado, id_transaccion, id_producto, id_suscripcion, cantidad, precio_unitario, subtotal
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()

def actualizar_detalle_transaccion(id_detalle_transaccion, detalle, id_estado, id_transaccion, id_producto, id_suscripcion, cantidad, precio_unitario, subtotal):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_DETALLE_TRANSACCIONES_UPDATE_SP", [
            id_detalle_transaccion, detalle, id_estado, id_transaccion, id_producto, id_suscripcion, cantidad, precio_unitario, subtotal
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()

def eliminar_detalle_transaccion(id_detalle_transaccion):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_DETALLE_TRANSACCIONES_DELETE_SP", [
            id_detalle_transaccion
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def obtener_detalle_transacciones():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM FIDE_DETALLE_TRANSACCIONES_V')
    datos = cursor.fetchall()
    cursor.close()
    conn.close()
    return datos