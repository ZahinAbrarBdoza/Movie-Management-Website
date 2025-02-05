from flask import Flask, render_template, request, redirect, url_for, session
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
import os
import pymysql

app = Flask(__name__)
app.secret_key = "your_unique_secret_key"


app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = '370pro'

db = pymysql.connect(
    host=app.config['MYSQL_HOST'],
    user=app.config['MYSQL_USER'],
    password=app.config['MYSQL_PASSWORD'],
    db=app.config['MYSQL_DB'],
    cursorclass=pymysql.cursors.DictCursor
)

admin_list = [
    ['123', 'Ishmum'],
    ['231', 'Rafid'],
    ['312', 'Dipto']
]


# Read user database from text file
users={}

with db.cursor() as cursor:
    # Execute the query to fetch user data
    cursor.execute("SELECT * FROM users")

    # Fetch all rows
    user_rows = cursor.fetchall()

    # Populate the 'users' dictionary
    for user_row in user_rows:
        user_id = user_row['UserId']
        users[user_id] = {
            'password': user_row['Password'],
            'username': user_row['UserName'],
            'email': user_row['Email'],
            'country': user_row['Country'],
            'liked_category': user_row['LikedCategory'],
            'watched_shows': user_row['Watched'].split(',') if user_row['Watched'] else [],
            'planned_shows': user_row['Planned'].split(',') if user_row['Planned'] else []
        }

tv_shows = {}

# Remove the existing code that reads from the txt file

# Fetch TV show data from MySQL table and populate the tv_shows dictionary
with db.cursor() as cursor:
    cursor.execute("SELECT * FROM tvshows")
    tv_show_rows = cursor.fetchall()

    for row in tv_show_rows:
        show_id = row['ShowId']
        show_data = [
            row['ShowName'],
            row['ReleaseDate'],
            row['Genre'],
            row['Rating'],
            row['Language'],
            row['ShowType'],
            row['MovieLink'],
            row['MoviePoster']
        ]
        tv_shows[show_id] = show_data


@app.route('/admin', methods=['GET', 'POST'])
def admin():
    authenticated = False
    authentication_failed = False
    user_data = None  # Initialize user_data variable

    if request.method == 'POST':
        admin_name = request.form.get('admin_name')
        admin_password = request.form.get('admin_password')

        # Check if the admin's name and password match
        for admin_info in admin_list:
            if admin_info[1] == admin_name and admin_info[0] == admin_password:
                authenticated = True
                session['admin_authenticated'] = True  # Set session flag
                break

        if not authenticated:
            authentication_failed = True

    #Check if user identifier is provided and search for user
        user_identifier = request.form.get('user_identifier')
        if user_identifier:
            user_data = search_user(user_identifier)
            session['user_data'] = user_data  # Store user_data in session

    if authenticated:
        return redirect(url_for('admin_panel'))
    else:
        return render_template('admin.html', authentication_failed=authentication_failed)


@app.route('/admin/panel', methods=['GET', 'POST'])
def admin_panel():
    user_data = None
    add_show_visible = session.get('add_show_visible', False)  # Get the session variable

    if request.method == 'POST':
        user_identifier = request.form.get('user_identifier')
        if user_identifier:
            user_data = search_user(user_identifier)
        
        # Check if the form is for adding a new TV show
        if 'add_show' in request.form:
            # Get the form data
            show_name = request.form.get('show_name')
            release_date = request.form.get('release_date')
            genre = request.form.get('genre')
            rating = request.form.get('rating')
            language = request.form.get('language')
            show_type = request.form.get('show_type')
            movie_link = request.form.get('movie_link')
            movie_poster = request.form.get('movie_poster')

            # Generate a new show ID
            new_show_id = max(tv_shows.keys(), default=0) + 1

            # Store the new TV show in the tv_shows dictionary
            tv_shows[new_show_id] = [show_name, release_date, genre, rating, language, show_type, movie_link, movie_poster]
            
            # Update the TV shows database (MySQL table)
            with db.cursor() as cursor:
                sql = """
                INSERT INTO tvshows (ShowId, ShowName, ReleaseDate, Genre, Rating, Language, ShowType, MovieLink, MoviePoster) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                """
                cursor.execute(sql, (new_show_id, show_name, release_date, genre, rating, language, show_type, movie_link, movie_poster))
                db.commit()
    
        # Check if the form is for deleting a TV show
        if 'delete_show' in request.form:
            show_id_to_delete = int(request.form.get('delete_show'))
            if show_id_to_delete in tv_shows:
                # Remove the TV show from the dictionary
                del tv_shows[show_id_to_delete]
                
                # Delete the TV show from the MySQL table
                with db.cursor() as cursor:
                    sql = "DELETE FROM tvshows WHERE ShowId = %s"
                    cursor.execute(sql, (show_id_to_delete,))
                    db.commit()

    show_list_visible = session.get('show_list_visible', True)  # Get the session variable

    # Check if the ticket sales report should be displayed
    report_data = None
    if 'view_report' in request.form:
        with db.cursor() as cursor:
            cursor.execute("""
                SELECT t.ShowName, s.theater, COUNT(b.id) AS tickets_sold, SUM(b.seats) AS total_seats
                FROM bookings b
                JOIN screenings s ON b.screening_id = s.id
                JOIN tvshows t ON s.movie_id = t.ShowId
                GROUP BY t.ShowName, s.theater
            """)
            report_data = cursor.fetchall()

    return render_template(
        'admin_panel.html',
        user_data=user_data,
        tv_shows=tv_shows,
        show_list_visible=show_list_visible,
        add_show_visible=add_show_visible,
        report_data=report_data  # Pass the report data to the template
    )

@app.route('/admin/toggle_add_show', methods=['POST'])
def toggle_add_show():
    # Toggle the visibility of the "Add New TV Show" form
    session['add_show_visible'] = not session.get('add_show_visible', False)
    return redirect(url_for('admin_panel'))

@app.route('/admin/toggle_show_list', methods=['POST'])
def toggle_show_list():
    # Toggle the visibility of the show list
    session['show_list_visible'] = not session.get('show_list_visible', False)
    return redirect(url_for('admin_panel'))

@app.route('/admin/delete_user', methods=['POST'])
def delete_user():
    user_id_to_delete = int(request.form.get('delete_user'))
    if user_id_to_delete in users:
        # Delete the user from the dictionary
        del users[user_id_to_delete]
        
        # Delete the user from the MySQL table
        with db.cursor() as cursor:
            sql = "DELETE FROM users WHERE UserId = %s"
            cursor.execute(sql, (user_id_to_delete,))
            db.commit()

    return redirect(url_for('admin_panel'))

@app.route('/book_tickets/<int:show_id>', methods=['POST'])
def book_tickets(show_id):
    # Redirect the user to the multi-step booking page
    return redirect(url_for('booking_page', show_id=show_id))

def search_user(identifier):
    # Search for user by user ID
    for user_id, user_data in users.items():
        if str(user_id) == identifier:
            return {
                'id': user_id,
                'username': user_data['username'],
                'email': user_data['email'],
                'country': user_data['country'],
                'liked_category': user_data['liked_category'],
                'watched_shows': user_data['watched_shows'],
                'planned_shows': user_data['planned_shows']
            }
    return None  # Return None if user not found

@app.route('/admin/logout')
def admin_logout():
    session.pop('admin_authenticated', None)  # Remove admin authentication from session
    return redirect(url_for('admin'))


@app.route('/')
def home():
    # Get the latest 5 TV shows (trending)
    trending_shows = {}
    latest_show_ids = sorted(tv_shows.keys(), reverse=True)[:5]
    for show_id in latest_show_ids:
        trending_shows[show_id] = tv_shows[show_id]

    # Get the top 10 highest-rated TV shows
    top_10_show_ids = sorted(tv_shows.keys(), key=lambda show_id: float(tv_shows[show_id][3]), reverse=True)[:10]
    top_10_shows = [(show_id, tv_shows[show_id]) for show_id in top_10_show_ids]

    # Get recommendations based on LikedCategory for logged-in users
    recommendations = {}
    if 'user_id' in session:
        user_id = session['user_id']
        with db.cursor() as cursor:
            cursor.execute("SELECT LikedCategory FROM users WHERE UserId = %s", (user_id,))
            liked_category = cursor.fetchone()['LikedCategory']

            cursor.execute("""
                SELECT * FROM tvshows 
                WHERE Genre LIKE %s
                ORDER BY Rating DESC
                LIMIT 10
            """, (f"%{liked_category}%",))
            recommended_shows = cursor.fetchall()

            for show in recommended_shows:
                recommendations[show['ShowId']] = [
                    show['ShowName'], show['ReleaseDate'], show['Genre'], 
                    show['Rating'], show['Language'], show['ShowType'], 
                    show['MovieLink'], show['MoviePoster']
                ]

    return render_template('home.html', 
                           trending_shows=trending_shows, 
                           top_10_shows=top_10_shows, 
                           recommendations=recommendations)

@app.route('/add_to_list/<int:show_id>', methods=['POST'])
def add_to_list(show_id):
    user_id = session.get('user_id')  # Assume the user is logged in
    list_type = request.form.get('list_type')  # 'watched' or 'planned'

    if user_id and list_type in ['watched', 'planned']:
        with db.cursor() as cursor:
            sql = """
                INSERT INTO showList (user_id, show_id, list_type)
                VALUES (%s, %s, %s)
            """
            cursor.execute(sql, (user_id, show_id, list_type))
            db.commit()

            if list_type == 'watched':
                update_user_discounts(user_id)
            
        return redirect(url_for('profile'))
    return "Invalid Request, Please Log in to add to list", 400

def get_user_lists(user_id):
    with db.cursor() as cursor:
        cursor.execute("""
            SELECT tvshows.* 
            FROM showList 
            JOIN tvshows ON showList.show_id = tvshows.ShowId 
            WHERE showList.user_id = %s AND showList.list_type = 'watched'
        """, (user_id,))
        watched_shows = cursor.fetchall()
        
        cursor.execute("""
            SELECT tvshows.* 
            FROM showList 
            JOIN tvshows ON showList.show_id = tvshows.ShowId 
            WHERE showList.user_id = %s AND showList.list_type = 'planned'
        """, (user_id,))
        planned_shows = cursor.fetchall()
    
    return watched_shows, planned_shows

@app.route('/remove_from_list/<int:show_id>', methods=['POST'])
def remove_from_list(show_id):
    user_id = session.get('user_id')
    list_type = request.form.get('list_type')  # 'watched' or 'planned'

    if user_id and list_type in ['watched', 'planned']:
        with db.cursor() as cursor:
            sql = """
                DELETE FROM showList
                WHERE user_id = %s AND show_id = %s AND list_type = %s
            """
            cursor.execute(sql, (user_id, show_id, list_type))
            db.commit()
    return redirect(url_for('profile'))

@app.route('/search', methods=['GET'])
def search():
    search_query = request.args.get('query')
    results = []

    if search_query:
        for show_id, show_data in tv_shows.items():
            if search_query.lower() in show_data[0].lower():
                results.append((show_id, show_data))

    return render_template('search_results.html', search_query=search_query, results=results)

#     matching_show_id = None
    
#     if search_query:
#         for show_id, show_data in tv_shows.items():
#             if search_query.lower() in show_data[0].lower():
#                 matching_show_id = show_id
#                 break
    
#     if matching_show_id is not None:
#         return redirect(url_for('show', show_id=matching_show_id))
#     else:
#         return render_template('search_results.html', search_query=search_query, results={})

@app.route('/discussion')
def discussion():
    # Connect to the MySQL database
    db = pymysql.connect(
        host=app.config['MYSQL_HOST'],
        user=app.config['MYSQL_USER'],
        password=app.config['MYSQL_PASSWORD'],
        db=app.config['MYSQL_DB'],
        cursorclass=pymysql.cursors.DictCursor
    )

    try:
        # Fetch discussion data from the MySQL table
        with db.cursor() as cursor:
            cursor.execute("SELECT * FROM discussion")
            discussion_data = cursor.fetchall()

        return render_template('discussion.html', discussion_data=discussion_data)

    finally:
        db.close()


@app.route('/add_discussion_message', methods=['POST'])
def add_discussion_message():
    message = request.form.get('message')
    user_id = session.get('user_id')
    user_name = users.get(user_id, {}).get('username', 'Unknown')

    if message and user_name:
        db = pymysql.connect(
            host=app.config['MYSQL_HOST'],
            user=app.config['MYSQL_USER'],
            password=app.config['MYSQL_PASSWORD'],
            db=app.config['MYSQL_DB'],
            cursorclass=pymysql.cursors.DictCursor
        )

        try:
            with db.cursor() as cursor:
                # Insert new message into the discussion table
                sql = "INSERT INTO discussion (UserId, UserName, Comment) VALUES (%s, %s, %s)"
                cursor.execute(sql, (user_id, user_name, message))
                db.commit()  # Commit changes

        finally:
            db.close()

    return redirect(url_for('discussion'))  # Redirect back to the discussion page



@app.route('/shows')
def shows():
    return render_template('shows.html', tv_shows=tv_shows)

@app.route('/show/<int:show_id>')
def show(show_id):
    show_data = tv_shows.get(show_id)
    if not show_data:
        return render_template('show_not_found.html')

    with db.cursor() as cursor:
        cursor.execute("SELECT id, theater, time FROM screenings WHERE movie_id = %s", (show_id,))
        screenings = cursor.fetchall()

    # Convert YouTube watch link to embed link
    trailer_url = show_data[6]
    if "watch?v=" in trailer_url:
        trailer_url = trailer_url.replace("watch?v=", "embed/")

    return render_template(
        'show.html',
        show_id=show_id,
        show_data=show_data,
        screenings=screenings,
        trailer_url=trailer_url
    )


@app.route('/add_to_watched/<int:show_id>', methods=['POST'])
def add_to_watched(show_id):
    user_id = session.get('user_id')
    show_data = tv_shows.get(show_id)
    if user_id:
        user_data = users.get(user_id)
        if user_data:
            user_data['watched_shows'].append(((show_id),(show_data[0])))
            update_user_database()

    return redirect(url_for('show', show_id=show_id))


@app.route('/add_to_planned/<int:show_id>', methods=['POST'])
def add_to_planned(show_id):
    user_id = session.get('user_id')
    show_data = tv_shows.get(show_id)
    if user_id:
        user_data = users.get(user_id)
        if user_data:
            user_data['planned_shows'].append(((show_id),(show_data[0])))
            update_user_database()

    return redirect(url_for('show', show_id=show_id))


def update_user_database():
    # Update the MySQL database with the new user data
    with db.cursor() as cursor:
        for user_id, user_data in users.items():
            watched_str = ','.join(map(str, user_data['watched_shows']))
            planned_str = ','.join(map(str, user_data['planned_shows']))
            sql = "UPDATE users SET Watched = %s, Planned = %s WHERE UserId = %s"
            cursor.execute(sql, (watched_str, planned_str, user_id))
        db.commit()


@app.route('/login', methods=['GET', 'POST'])
def login():
    login_failed = False

    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')

        # Check if the provided username and password match any user
        for user_id, user_data in users.items():
            if user_data['username'] == username and user_data['password'] == password:
                session['user_id'] = user_id
                return redirect(url_for('home'))
        
        # If no match found, set login_failed flag to True
        login_failed = True

    return render_template('login.html', login_failed=login_failed)



@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        # Generate a new user ID
        max_user_id = max(users.keys(), default=0)
        user_id = max_user_id + 1

        # Collect form data
        password = request.form.get('password')
        username = request.form.get('username')
        email = request.form.get('email')
        country = request.form.get('country')
        liked_category = request.form.get('liked_category')

        # Check for existing username
        if any(user_data['username'] == username for user_data in users.values()):
            return render_template('register.html', username_exists=True)

        # Add new user to the in-memory dictionary
        users[user_id] = {
            'password': password,
            'username': username,
            'email': email,
            'country': country,
            'liked_category': liked_category,
            'watched_shows': [],
            'planned_shows': []
        }

        # Update the MySQL database with the new user
        with db.cursor() as cursor:
            sql = """
                INSERT INTO users (UserId, Password, UserName, Email, Country, LikedCategory)
                VALUES (%s, %s, %s, %s, %s, %s)
            """
            cursor.execute(sql, (user_id, password, username, email, country, liked_category))
            db.commit()

        return redirect(url_for('login'))

    # Render the registration page
    return render_template('register.html')

@app.route('/admin/report')
def admin_report():
    # Assuming you use a session variable to check admin authentication
    if 'admin_authenticated' not in session or not session['admin_authenticated']:
        return redirect(url_for('admin'))  # Redirect to admin login page

    # Fetch ticket sales data
    with db.cursor() as cursor:
        cursor.execute("""
            SELECT t.ShowName, s.theater, COUNT(b.id) AS tickets_sold, 
                   SUM(b.seats) AS total_seats
            FROM bookings b
            JOIN screenings s ON b.screening_id = s.id
            JOIN tvshows t ON s.movie_id = t.ShowId
            GROUP BY t.ShowName, s.theater
        """)
        report_data = cursor.fetchall()

    # Render the admin report page
    return render_template('admin_report.html', report_data=report_data)

@app.route('/admin/bookings')
def admin_bookings():
    with db.cursor() as cursor:
        cursor.execute("""
            SELECT b.id, u.UserName, t.ShowName, s.theater, s.time, b.seats
            FROM bookings b
            JOIN users u ON b.user_id = u.UserId
            JOIN screenings s ON b.screening_id = s.id
            JOIN tvshows t ON s.movie_id = t.ShowId
        """)
        bookings = cursor.fetchall()

    return render_template('admin_bookings.html', bookings=bookings)

@app.route('/booking/<int:show_id>', methods=['GET', 'POST'])
def booking_page(show_id):
    # Fetch the show data
    show_data = tv_shows.get(show_id)  # Ensure this fetches data by ShowId, not name
    
    if not show_data:
        return render_template('show_not_found.html')
    
    # Fetch available dates and screenings
    with db.cursor() as cursor:
        cursor.execute("""
            SELECT id, theater, time, ticket_price 
            FROM screenings 
            WHERE movie_id = %s
        """, (show_id,))
        screenings = cursor.fetchall()

    return render_template('booking.html', 
                           show_id=show_id, 
                           show_data=show_data, 
                           screenings=screenings)


@app.route('/confirm_booking/<int:show_id>', methods=['POST'])
def confirm_booking(show_id):
    # Get form data
    date = request.form['date']
    screening_id = request.form['screening']
    seats = int(request.form['seats'])
    user_id = session.get('user_id')

    if not user_id:
        return redirect(url_for('login'))

    # Save booking to the database
    with db.cursor() as cursor:
        # Fetch ticket price for the screening
        cursor.execute("SELECT ticket_price FROM screenings WHERE id = %s", (screening_id,))
        ticket_price = cursor.fetchone()['ticket_price']

        # Fetch the most recent discount for the user
        cursor.execute("""
            SELECT discount_rate 
            FROM discounts 
            WHERE user_id = %s 
            ORDER BY id DESC 
            LIMIT 1
        """, (user_id,))
        discount = cursor.fetchone()

        # Safely assign the discount rate
        discount_rate = discount['discount_rate'] if discount else 0

        # Calculate the total cost
        total_cost = (float(ticket_price * seats)) * float((1 - discount_rate / 100))

        # Save booking
        sql = """
            INSERT INTO bookings (screening_id, user_id, seats, payment_status, total_cost)
            VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(sql, (screening_id, user_id, seats, 'Pending', total_cost))
        db.commit()

    booking_id = cursor.lastrowid
    return redirect(url_for('booking_confirmation', booking_id=booking_id))



@app.route('/booking_confirmation/<int:booking_id>')
def booking_confirmation(booking_id):
    with db.cursor() as cursor:
        cursor.execute("""
            SELECT b.id, s.theater, s.time, b.seats, t.ShowName, b.payment_status, b.total_cost
            FROM bookings b
            JOIN screenings s ON b.screening_id = s.id
            JOIN tvshows t ON s.movie_id = t.ShowId
            WHERE b.id = %s
        """, (booking_id,))
        booking = cursor.fetchone()

    return render_template('booking_confirmation.html', booking=booking)

def update_user_discounts(user_id):
    with db.cursor() as cursor:
        cursor.execute("""
            SELECT COUNT(*) AS watched_count 
            FROM showList 
            WHERE user_id = %s AND list_type = 'watched'
        """, (user_id,))
        watched_count = cursor.fetchone()['watched_count']

        # Calculate discount based on watched shows
        discount_rate = min(20, watched_count * 2)  # Example: 2% per show, max 20%

        # Update or insert discount
        cursor.execute("""
            INSERT INTO discounts (user_id, discount_rate)
            VALUES (%s, %s)
            ON DUPLICATE KEY UPDATE discount_rate = %s
        """, (user_id, discount_rate, discount_rate))
        db.commit()


@app.route('/cancel_booking/<int:booking_id>', methods=['POST'])
def cancel_booking(booking_id):
    with db.cursor() as cursor:
        # Delete booking from the database
        cursor.execute("DELETE FROM bookings WHERE id = %s", (booking_id,))
        db.commit()

    return redirect(url_for('profile'))

@app.route('/make_payment/<int:booking_id>', methods=['POST'])
def make_payment(booking_id):
    with db.cursor() as cursor:
        # Update payment status to 'Paid'
        sql = "UPDATE bookings SET payment_status = 'Paid' WHERE id = %s"
        cursor.execute(sql, (booking_id,))
        db.commit()

    return redirect(url_for('booking_confirmation', booking_id=booking_id))


'''
@app.route('/profile')
def profile():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    user_id = session['user_id']
    with db.cursor() as cursor:
        # Fetch user data
        cursor.execute("SELECT * FROM users WHERE UserId = %s", (user_id,))
        user_data = cursor.fetchone()
        user_data = users.get(user_id)

        # Fetch bookings
        cursor.execute("""
            SELECT t.ShowName, s.theater, s.time, b.seats
            FROM bookings b
            JOIN screenings s ON b.screening_id = s.id
            JOIN tvshows t ON s.movie_id = t.ShowId
            WHERE b.user_id = %s
        """, (user_id,))
        bookings = cursor.fetchall()

    return render_template('profile.html', user_data=user_data, bookings=bookings)
'''
@app.route('/profile')
def profile():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    user_id = session['user_id']

    # Fetch watched and planned shows
    watched_shows, planned_shows = get_user_lists(user_id)

    # Fetch user data
    with db.cursor() as cursor:
        cursor.execute("SELECT * FROM users WHERE UserId = %s", (user_id,))
        user_data = cursor.fetchone()

        # Fetch bookings
        cursor.execute("""
            SELECT b.id, t.ShowName, s.theater, s.time, b.seats, b.payment_status, b.total_cost
            FROM bookings b
            JOIN screenings s ON b.screening_id = s.id
            JOIN tvshows t ON s.movie_id = t.ShowId
            WHERE b.user_id = %s
        """, (user_id,))
        bookings = cursor.fetchall()
        
    return render_template('profile.html', 
                           user_data=user_data, 
                           watched_shows=watched_shows, 
                           planned_shows=planned_shows, 
                           bookings=bookings)




@app.route('/logout')
def logout():
    session.pop('user_id', None)
    return redirect(url_for('home'))

app.run(debug=True)



