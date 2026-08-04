import oracledb
from db import get_connection
#tener cuidado con esto que con quitar una linea se pudre toda la pagina xddddddd
def insertar_suscripcion(id_suscripcion, fecha_inicio, fecha_fin, id_pago, Estado, precio):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_SUSCRIPCIONES_INSERT_SP", [
            id_suscripcion, fecha_inicio, fecha_fin, id_pago, Estado, precio
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()

def actualizar_suscripcion(id_suscripcion, fecha_inicio, fecha_fin, id_pago, Estado, precio):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_SUSCRIPCIONES_UPDATE_SP", [
            id_suscripcion, fecha_inicio, fecha_fin, id_pago, Estado, precio
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()

def eliminar_suscripcion(id_suscripcion):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_SUSCRIPCIONES_DELETE_SP", [
            id_suscripcion
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def obtener_suscripciones():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM FIDE_SUSCRIPCIONES_V ORDER BY "SUSCRIPCION ID"')
    datos = cursor.fetchall()
    cursor.close()
    conn.close()
    return datos