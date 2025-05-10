# 1. Imagen base oficial de Python ligera
FROM python:3.10-slim

# 2. Directorio de trabajo dentro del contenedor
WORKDIR /app

# 3. Copiar sólo archivos de dependencias para aprovechar la caché
COPY requirements.txt .

RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    build-essential \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 4. Instalar dependencias Python
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar el resto de tu código al contenedor
COPY . .

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# 6. Exponer el puerto que usará Flask
EXPOSE 5000

# 7. Comando por defecto al arrancar el contenedor
CMD ["/wait-for-it.sh", "db:3306", "--", "python", "app.py"]
