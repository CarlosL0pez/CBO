import oracledb
from db import get_connection

def autenticar_usuario(correo, password):
    conn = get_connection()
    try:
        cursor = conn.cursor()

        v_id_usuario = cursor.var(oracledb.NUMBER)
        v_id_rol = cursor.var(oracledb.NUMBER)
        v_rol = cursor.var(str)
        v_id_cliente = cursor.var(oracledb.NUMBER)
        v_mensaje = cursor.var(str)

        cursor.callproc("FIDE_PROYECTO_FINAL_PKG.FIDE_USUARIOS_LOGIN_SP", [
            correo, password,
            v_id_usuario, v_id_rol, v_rol, v_id_cliente, v_mensaje
        ])
    finally:
        cursor.close()
        conn.close()

    mensaje = v_mensaje.getvalue()
    if mensaje != "OK":
        return None, mensaje

    usuario = {
        "id_usuario": v_id_usuario.getvalue(),
        "id_rol": v_id_rol.getvalue(),
        "rol": v_rol.getvalue(),
        "id_cliente": v_id_cliente.getvalue(),
    }
    return usuario, mensaje