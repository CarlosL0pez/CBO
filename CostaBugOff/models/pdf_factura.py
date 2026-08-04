import io
import os
from reportlab.lib import colors
from reportlab.lib.pagesizes import letter
from reportlab.lib.units import cm
from reportlab.platypus import (
    SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer, Image
)
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.enums import TA_RIGHT, TA_LEFT

IVA = 0.13

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
LOGO_PATH = os.path.join(BASE_DIR, "..", "static", "img", "Jeremy.png")

VERDE = colors.HexColor("#1c5e3c")
GRIS = colors.HexColor("#f0f0f0")


def generar_pdf_factura(factura, detalle):
    """
    factura: dict con NUMERO, FECHA, TOTAL, NOMBRE_CLIENTE, CORREO_CLIENTE,
             DIRECCION_FACTURA, TELEFONO_FACTURA, METODO_PAGO
    detalle: lista de dicts con NOMBRE_ITEM, CANTIDAD, PRECIO_UNITARIO, SUBTOTAL
    Devuelve bytes del PDF.
    """
    buffer = io.BytesIO()
    doc = SimpleDocTemplate(
        buffer, pagesize=letter,
        topMargin=1.5 * cm, bottomMargin=1.5 * cm,
        leftMargin=1.5 * cm, rightMargin=1.5 * cm,
    )

    styles = getSampleStyleSheet()
    style_titulo = ParagraphStyle("titulo", parent=styles["Heading1"], fontSize=16, textColor=VERDE)
    style_normal = styles["Normal"]
    style_der = ParagraphStyle("der", parent=styles["Normal"], alignment=TA_RIGHT)
    style_der_bold = ParagraphStyle("derb", parent=styles["Normal"], alignment=TA_RIGHT, fontName="Helvetica-Bold")

    elementos = []

    # ---- Encabezado: logo + datos empresa | numero de factura ----
    logo = Image(LOGO_PATH, width=2.2 * cm, height=2.2 * cm) if os.path.exists(LOGO_PATH) else Paragraph("", style_normal)
    datos_empresa = Paragraph(
        "<b>CostaBugOff</b><br/>Control de plagas residencial y comercial<br/>Costa Rica<br/>info@costabugoff.com",
        style_normal,
    )
    datos_factura = Paragraph(
        f"<b>Factura No.</b> {factura.get('NUMERO', '')}<br/>"
        f"<b>Fecha:</b> {factura.get('FECHA', '')}<br/>"
        f"<b>Forma de pago:</b> {factura.get('METODO_PAGO', '')}",
        style_der,
    )

    tabla_encabezado = Table(
        [[logo, datos_empresa, datos_factura]],
        colWidths=[2.5 * cm, 9 * cm, 6 * cm],
    )
    tabla_encabezado.setStyle(TableStyle([
        ("VALIGN", (0, 0), (-1, -1), "TOP"),
    ]))
    elementos.append(tabla_encabezado)
    elementos.append(Spacer(1, 0.5 * cm))

    # ---- Datos del cliente ----
    datos_cliente = Paragraph(
        f"<b>Cliente:</b> {factura.get('NOMBRE_CLIENTE', '')}<br/>"
        f"<b>Correo:</b> {factura.get('CORREO_CLIENTE', '') or '-'}<br/>"
        f"<b>Direccion:</b> {factura.get('DIRECCION_FACTURA', '') or '-'}<br/>"
        f"<b>Telefono:</b> {factura.get('TELEFONO_FACTURA', '') or '-'}",
        style_normal,
    )
    elementos.append(datos_cliente)
    elementos.append(Spacer(1, 0.6 * cm))

    # ---- Tabla de lineas ----
    encabezados = ["Producto / Suscripcion", "Cantidad", "Precio Unitario", "Subtotal"]
    filas = [encabezados]
    for linea in detalle:
        filas.append([
            linea.get("NOMBRE_ITEM", ""),
            str(linea.get("CANTIDAD", "")),
            f"CRC {linea.get('PRECIO_UNITARIO', 0):,.2f}",
            f"CRC {linea.get('SUBTOTAL', 0):,.2f}",
        ])

    tabla = Table(filas, colWidths=[8 * cm, 2.5 * cm, 3.5 * cm, 3.5 * cm], repeatRows=1)
    tabla.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, 0), VERDE),
        ("TEXTCOLOR", (0, 0), (-1, 0), colors.white),
        ("FONTNAME", (0, 0), (-1, 0), "Helvetica-Bold"),
        ("ALIGN", (1, 0), (-1, -1), "RIGHT"),
        ("ALIGN", (0, 0), (0, -1), "LEFT"),
        ("GRID", (0, 0), (-1, -1), 0.5, colors.grey),
        ("ROWBACKGROUNDS", (0, 1), (-1, -1), [colors.white, GRIS]),
        ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
        ("TOPPADDING", (0, 0), (-1, -1), 6),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 6),
    ]))
    elementos.append(tabla)
    elementos.append(Spacer(1, 0.5 * cm))

    # ---- Totales ----
    subtotal = sum(l.get("SUBTOTAL", 0) for l in detalle)
    monto_iva = subtotal * IVA
    total = subtotal + monto_iva

    tabla_totales = Table(
        [
            ["Subtotal:", f"CRC {subtotal:,.2f}"],
            ["IVA (13%):", f"CRC {monto_iva:,.2f}"],
            ["Total a pagar:", f"CRC {total:,.2f}"],
        ],
        colWidths=[4 * cm, 3.5 * cm],
    )
    tabla_totales.setStyle(TableStyle([
        ("ALIGN", (0, 0), (-1, -1), "RIGHT"),
        ("FONTNAME", (0, 2), (-1, 2), "Helvetica-Bold"),
        ("FONTSIZE", (0, 2), (-1, 2), 12),
        ("LINEABOVE", (0, 2), (-1, 2), 1, VERDE),
        ("TOPPADDING", (0, 0), (-1, -1), 4),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 4),
    ]))

    envoltorio = Table([[None, tabla_totales]], colWidths=[10 * cm, 7.5 * cm])
    elementos.append(envoltorio)
    elementos.append(Spacer(1, 1 * cm))

    # ---- Pie ----
    elementos.append(Paragraph(
        "Gracias por confiar en CostaBugOff. Esta factura fue generada automaticamente por el sistema.",
        ParagraphStyle("pie", parent=styles["Normal"], fontSize=8, textColor=colors.grey),
    ))

    doc.build(elementos)
    buffer.seek(0)
    return buffer.getvalue()
