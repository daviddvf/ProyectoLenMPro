from flask import Flask, render_template, request, redirect
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config.update(
    MYSQL_HOST="db",
    MYSQL_USER="cruduser",
    MYSQL_PASSWORD="tu_pass",
    MYSQL_DB="cruddb"
)
mysql = MySQL(app)

@app.route('/')
def index():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM items")
    items = cur.fetchall()
    return render_template('index.html', items=items)

# Añade rutas create, update, delete…

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
