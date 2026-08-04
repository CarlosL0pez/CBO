import oracledb
from db import get_connection
#tener cuidado con esto que con quitar una linea se pudre toda la pagina xddddddd
def insertar_transaccion(id_transaccion, id_pago, monto, fecha, id_detalle_transaccion, id_estado):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_TRANSACCIONES_INSERT_SP", [
            id_transaccion, id_pago, monto, fecha, id_detalle_transaccion, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()

def actualizar_transaccion(id_transaccion, id_pago, monto, fecha, id_detalle_transaccion, id_estado):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_TRANSACCIONES_UPDATE_SP", [
            id_transaccion, id_pago, monto, fecha, id_detalle_transaccion, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()

def eliminar_transaccion(id_transaccion):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_TRANSACCIONES_DELETE_SP", [
            id_transaccion
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def obtener_transacciones():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM FIDE_TRANSACCIONES_V ORDER BY "TRANSACCION ID"')
    datos = cursor.fetchall()
    cursor.close()
    conn.close()
    return datos