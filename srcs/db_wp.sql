-- Configure database Wordpress
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO username @'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;