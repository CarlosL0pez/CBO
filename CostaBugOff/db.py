import os
import oracledb

# Carpeta donde vive este archivo (db.py), sin importar desde dónde se
# ejecute "python app.py" ni el sistema operativo (Mac usa "/", Windows
# usa "\"). os.path.join arma la ruta con el separador correcto en cada SO.
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
WALLET_DIR = os.path.join(BASE_DIR, "wallet", "Wallet_IIQ2026")

def get_connection():
    return oracledb.connect(
        user="PROYECTO1",
        password="Admin12345678",
        dsn="iiq2026_high",
        config_dir=WALLET_DIR,
        wallet_location=WALLET_DIR,
        wallet_password="Negropa2110#"
    )