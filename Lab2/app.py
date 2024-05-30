from flask import Flask, render_template, request, redirect, url_for, jsonify
import pymysql

app = Flask(__name__)

# Настройки подключения к базе данных
db = pymysql.connect(
    host='localhost',
    user='test',
    password='test',
    db='db',
    cursorclass=pymysql.cursors.DictCursor
)


def get_columns(table_name):
    with db.cursor() as cursor:
        cursor.execute(f"SHOW COLUMNS FROM {table_name}")
        columns = cursor.fetchall()
    return columns


@app.route('/')
def index():
    with db.cursor() as cursor:
        cursor.execute("SELECT * FROM Objects")
        objects = cursor.fetchall()
    columns = get_columns('Objects')
    return render_template('index.html', table='Objects', columns=columns, objects=objects)


@app.route('/joined')
def joined():
    with db.cursor() as cursor:
        cursor.execute("CALL join_two_tables('Objects', 'NaturalObjects')")
        objects = cursor.fetchall()
    columns = get_columns('Objects') + get_columns('NaturalObjects')
    return render_template('index.html', table='Joined', columns=columns, objects=objects)


@app.route('/delete/<int:id>', methods=['POST'])
def delete(id):
    with db.cursor() as cursor:
        cursor.execute("DELETE FROM Objects WHERE id=%s", (id,))
        db.commit()
    return redirect(url_for('index'))


@app.route('/edit/<int:id>', methods=['POST'])
def edit(id):
    data = request.json
    set_clause = ", ".join([f"{key}=%s" for key in data.keys() if key not in ('time', 'date')])
    values = [data[key] for key in data.keys() if key not in ('time', 'date')]
    values.append(id)
    query = f"UPDATE Objects SET {set_clause} WHERE id=%s"

    with db.cursor() as cursor:
        cursor.execute(query, values)
        db.commit()
    return jsonify(success=True)


if __name__ == '__main__':
    app.run(debug=True)
