import oracledb
from db import get_connection

def obtener_estados():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT ID_ESTADO, NOMBRE FROM FIDE_ESTADOS_TB ORDER BY ID_ESTADO')
    datos = cursor.fetchall()
    cursor.close()
    conn.close()
    return datos