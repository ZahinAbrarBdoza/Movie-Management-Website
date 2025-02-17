Movie Management Software
Overview
This project is a Movie Management Software developed using Flask and MySQL. It allows users to browse, add, and manage movies and TV shows, handle user authentication, and book tickets.

Features
User authentication and session management
Admin panel for adding/removing movies and managing users
Browse trending, top-rated, and recommended movies
Watchlist management (watched and planned movies)
Movie booking system with payment processing
Discussion forum for movie-related topics
Installation
1. Clone the Repository
git clone https://github.com/RafidGit/Movie-Management-Software.git
cd projectfile
2. Install Dependencies
Ensure you have Python 3.11 installed, then install required dependencies:

pip install flask flask-login pymysql
3. Set Up MySQL Database
Create a new database named 370pro in MySQL.
Import the necessary tables using the following query:
CREATE TABLE users (
    UserId INT PRIMARY KEY AUTO_INCREMENT,
    Password VARCHAR(255),
    UserName VARCHAR(255),
    Email VARCHAR(255),
    Country VARCHAR(100),
    LikedCategory VARCHAR(100),
    Watched TEXT,
    Planned TEXT
);

CREATE TABLE tvshows (
    ShowId INT PRIMARY KEY AUTO_INCREMENT,
    ShowName VARCHAR(255),
    ReleaseDate DATE,
    Genre VARCHAR(255),
    Rating FLOAT,
    Language VARCHAR(100),
    ShowType VARCHAR(50),
    MovieLink TEXT,
    MoviePoster TEXT
);
4. Run the Application
Start the Flask application:

python app.py
Open a browser and visit: http://127.0.0.1:5000

Usage
Register/Login to explore movies.
Admins can log in to the Admin Panel to add/remove movies.
Users can add movies to their watchlist and book tickets.
Requirements
Python 3.11
Flask
Flask-Login
MySQL
PyMySQL
Contributing
Feel free to fork this repository, improve the project, and submit a pull request.
