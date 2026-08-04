import oracledb
from db import get_connection


def insertar_direccion(id_cliente, id_provincia, id_canton, id_distrito, id_estado):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.SP_FIDE_DIRECCIONES_INSERT", [
            id_cliente, id_provincia, id_canton, id_distrito, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def actualizar_direccion(id_cliente, id_provincia, id_canton, id_distrito, id_estado):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.SP_FIDE_DIRECCIONES_UPDATE", [
            id_cliente, id_provincia, id_canton, id_distrito, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def eliminar_direccion_logico(id_cliente, id_provincia, id_canton, id_distrito):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.SP_FIDE_DIRECCIONES_DELETE", [
            id_cliente, id_provincia, id_canton, id_distrito
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def obtener_direcciones(id_estado=None):
    conn = get_connection()
    cursor = conn.cursor()
    if id_estado:
        cursor.execute(
            'SELECT * FROM FIDE_DIRECCIONES_V WHERE "ID ESTADO" = :id_estado ORDER BY "ID CLIENTE"',
            {"id_estado": id_estado}
        )
    else:
        cursor.execute('SELECT * FROM FIDE_DIRECCIONES_V ORDER BY "ID CLIENTE"')
    datos = cursor.fetchall()
    cursor.close()
    conn.close()
    return datos
