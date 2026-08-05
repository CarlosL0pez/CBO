import oracledb
from db import get_connection


def insertar_servicio(id_servicio, nombre, id_plaga, id_usuario, id_servicio_realizado, id_estado):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.SP_FIDE_SERVICIOS_INSERT", [
            id_servicio, nombre, id_plaga, id_usuario, id_servicio_realizado, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def actualizar_servicio(id_servicio, nombre, id_plaga, id_usuario, id_servicio_realizado, id_estado):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.SP_FIDE_SERVICIOS_UPDATE", [
            id_servicio, nombre, id_plaga, id_usuario, id_servicio_realizado, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def eliminar_servicio_logico(id_servicio):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_SERVICIOS_DELETE_SP", [
            id_servicio
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def obtener_servicios(id_estado=None):
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM FIDE_SERVICIOS_DISPONIBLES_V')
        datos = cursor.fetchall()
    finally:
        cursor.close()
        conn.close()
    return datos
