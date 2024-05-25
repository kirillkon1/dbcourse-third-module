from flask import Flask, request, render_template_string, url_for
import mysql.connector
import os

app = Flask(__name__, static_folder='.')


@app.route('/')
def index():
    head_content = ''
    with open('head.inc') as file:
        for line in file:
            head_content += line.rstrip() + '\n'

    table_content = '''
    <table class="tView1">
        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Middle Name</th>
            <th>Passport</th>
            <th>INN</th>
            <th>SNILS</th>
            <th>License</th>
            <th>Additional Documents</th>
            <th>Notes</th>
        </tr>
    '''

    myconn = mysql.connector.connect(
        host='localhost',
        user='root',
        passwd='secret',
        db='db',
        charset='utf8mb4',
        collation='utf8mb4_unicode_ci'
    )
    cur = myconn.cursor()
    cur.execute("SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;")
    cur.execute("USE db;")

    query_string = request.query_string.decode('utf-8')
    urlGets = request.args

    if 'delid' in urlGets:
        delid = urlGets.get('delid')
        cur.execute("DELETE FROM Individuals WHERE Id = %s", (delid,))
        myconn.commit()

    if 'textId' in urlGets and 'textEd1' in urlGets and 'textEd2' in urlGets and 'textEd3' in urlGets:
        textId = urlGets.get('textId')
        textEd1 = urlGets.get('textEd1')
        textEd2 = urlGets.get('textEd2')
        textEd3 = urlGets.get('textEd3')
        cur.execute("UPDATE Individuals SET first_name=%s, last_name=%s, middle_name=%s WHERE Id = %s",
                    (textEd1, textEd2, textEd3, textId))
        myconn.commit()

    try:
        cur.execute("SELECT * FROM Individuals;")
        result = cur.fetchall()
        for line in result:
            table_content += '<tr>'
            for cell in line:
                table_content += f'<td>{str(cell).strip()}</td>'
            table_content += f'<td class="cellDel" title="Delete"><a href="?delid={line[0]}"><img src="{url_for("static", filename="image/delete2.png")}" alt="Delete"></a></td>'
            table_content += '</tr>'
    except Exception as e:
        myconn.rollback()
        table_content += f'<tr><td colspan="11">Ошибка: {e}</td></tr>'

    myconn.close()
    table_content += '</table>'

    foot_content = ''
    with open('foot.inc') as file:
        for line in file:
            foot_content += line.rstrip() + '\n'

    html_content = f'''
    <!doctype html>
    <html lang="ru">
    <head>
        <meta charset="utf-8">
        <title>Individuals Table</title>
        <link rel="stylesheet" href="{url_for('static', filename='./style/main3.css')}">
        <link rel="stylesheet" href="{url_for('static', filename='./style/modal.css')}">
        <link rel="stylesheet" href="{url_for('static', filename='./scrollup/scrollup.css')}">
    </head>
    <body>
        <div class="container">
            <h1>Individuals Table</h1>
            {head_content}
            {table_content}
            {foot_content}
        </div>
        <script src="{url_for('static', filename='./script/modal1.js')}"></script>
        <script src="{url_for('static', filename='./scrollup/scrollup.js')}"></script>
    </body>
    </html>
    '''

    return render_template_string(html_content)


if __name__ == '__main__':
    app.run(debug=True, port=8080)
