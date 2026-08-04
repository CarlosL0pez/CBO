import oracledb
from db import get_connection


def insertar_cliente_x_servicio(id_cliente, id_servicio, id_estado=1):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.SP_FIDE_CLIENTES_X_SERVICIO_INSERT", [
            id_cliente, id_servicio, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def actualizar_cliente_x_servicio(id_cliente, id_servicio, id_estado):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.SP_FIDE_CLIENTES_X_SERVICIO_UPDATE", [
            id_cliente, id_servicio, id_estado
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def eliminar_cliente_x_servicio_logico(id_cliente, id_servicio):
    conexion = get_connection()
    try:
        cursor = conexion.cursor()
        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.SP_FIDE_CLIENTES_X_SERVICIO_DELETE", [
            id_cliente, id_servicio
        ])
        conexion.commit()
    except Exception as e:
        conexion.rollback()
        raise e
    finally:
        cursor.close()
        conexion.close()


def obtener_clientes_x_servicio(id_estado=None):
    conn = get_connection()
    cursor = conn.cursor()
    if id_estado:
        cursor.execute(
            'SELECT * FROM FIDE_CLIENTES_X_SERVICIO_V WHERE "ID ESTADO" = :id_estado ORDER BY "ID CLIENTE"',
            {"id_estado": id_estado}
        )
    else:
        cursor.execute('SELECT * FROM FIDE_CLIENTES_X_SERVICIO_V ORDER BY "ID CLIENTE"')
    datos = cursor.fetchall()
    cursor.close()
    conn.close()
    return datos
