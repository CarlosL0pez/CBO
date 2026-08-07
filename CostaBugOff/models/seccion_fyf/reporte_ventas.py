import oracledb
from db import get_connection


def obtener_reporte_ventas():
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute('''
            SELECT ANIO, MES, TOTAL_VENTAS, CANTIDAD_TRANSACCIONES, VENTAS_ACUMULADAS
            FROM FIDE_REPORTE_VENTAS_V
            ORDER BY ANIO, MES
        ''')
        datos = cursor.fetchall()
    finally:
        cursor.close()
        conn.close()
    return datos
